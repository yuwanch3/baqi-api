// ============================================
// VERIFIKASI LEVEL 6 (KURIKULUM AL-QURAN)
//  local : cek file SQL + rows.json vs konten (ID unik, jumlah, hex round-trip, ASCII)
//  api   : verifikasi read-only setelah import (sublevels, materi, soal via API)
// Usage  : node l6/verify-l6.js            -> local
//          node l6/verify-l6.js api        -> API (setelah user import)
// ============================================
const fs = require('fs');
const path = require('path');
const mode = process.argv[2] || 'local';
const dir = path.join(__dirname, 'output', 'l6');
const NOW = '2026-09-25 16:00:00';
const DESC = 'Setelah melihat video diatas, silahkan lanjutkan ke step selanjutnya : Baca atau Ujian';

const cp1252dec = new TextDecoder('windows-1252');
const byteToChar = new Map();
for (let b = 0; b < 256; b++) byteToChar.set(b, cp1252dec.decode(Uint8Array.of(b)));
const charToByte = new Map();
for (let b = 0; b < 256; b++) charToByte.set(byteToChar.get(b), b);
const toM = (s) => cp1252dec.decode(Buffer.from(s, 'utf8'));
const hexM = (s) => Buffer.from(toM(s), 'utf8').toString('hex');
const phpser = (arr) => 'a:' + arr.length + ':{' + arr.map((s, i) => `i:${i};s:${Buffer.byteLength(s, 'utf8')}:"${s}"`).join(';') + ';}';
const hasArabic = (s) => /[\u0600-\u06FF]/.test(String(s));
const wrapC = (v) => (Array.isArray(v)
  ? 'CONVERT(0x' + hexM(phpser(v)) + ' USING utf8mb4)'
  : hasArabic(String(v))
    ? 'CONVERT(0x' + hexM(String(v)) + ' USING utf8mb4)'
    : "'" + String(v).replace(/'/g, "''") + "'");

function decodeHex(hex) {
  const s = Buffer.from(hex, 'hex').toString('utf8');
  const bytes = [];
  for (const ch of s) {
    const b = charToByte.get(ch);
    if (b === undefined) throw new Error('karakter tidak terpetakan di decodeHex: U+' + ch.charCodeAt(0).toString(16));
    bytes.push(b);
  }
  return Buffer.from(bytes).toString('utf8');
}

const problems = [];

if (mode === 'local') {
  const rows = JSON.parse(fs.readFileSync(path.join(dir, 'rows.json'), 'utf8'));
  const { sublevels, materi, soal, count } = rows;

  // ---- ID & jumlah ----
  if (sublevels.length !== 5) problems.push('sublevels != 5');
  if (materi.length !== 40) problems.push('materi != 40');
  if (soal.length !== 280) problems.push('soal != 280 (' + soal.length + ')');
  const uniq = (arr) => new Set(arr).size === arr.length;
  if (!uniq(sublevels.map((s) => s.id))) problems.push('SLV duplikat');
  if (!uniq(materi.map((m) => m.id))) problems.push('MTR duplikat');
  if (!uniq(soal.map((s) => s.id))) problems.push('QST duplikat');
  const slvOk = sublevels.every((s, i) => s.id === 'SLV' + String(37 + i).padStart(12, '0'));
  if (!slvOk) problems.push('ID SLV tidak berurutan 037-041');
  const qids = soal.map((s) => Number(s.id.slice(3)));
  if (Math.min(...qids) !== 4000 || Math.max(...qids) !== 4279) problems.push('QST harus 4000-4279, dpt ' + Math.min(...qids) + '-' + Math.max(...qids));
  for (let i = 0; i < materi.length; i++) {
    const e = 'MTR' + String(206 + i).padStart(12, '0');
    if (materi[i].id !== e) { problems.push('MTR urutan salah: ' + materi[i].id + ' harus ' + e); break; }
  }
  // materi per sublevel
  for (let n = 1; n <= 5; n++) {
    const c = materi.filter((m) => m.slv === n).length;
    if (c !== 8) problems.push('sublevel ' + n + ' materi != 8 (' + c + ')');
  }
  // soal per materi: quran 6, grammar 8
  for (const m of materi) {
    const c = soal.filter((s) => s.mid === m.id).length;
    const expect = m.type === 'quran' ? 6 : 8;
    if (c !== expect) problems.push(m.id + ' soal ' + c + ' != ' + expect);
    if (m.type === 'quran' && !m.range) problems.push(m.id + ': quran tanpa range');
  }
  // soal tipe & corr
  for (const s of soal) {
    if (!['option', 'multi', 'yesorno'].includes(s.t)) problems.push(s.id + ': tipe tidak dikenal ' + s.t);
    if (s.t === 'yesorno' && !['Yes,No', 'No,Yes'].includes(s.opts.join(','))) problems.push(s.id + ': yesorno opts');
    if (s.t === 'yesorno' && !['Yes', 'No'].includes(String(s.corr))) problems.push(s.id + ': yesorno corr');
    if (s.t !== 'yesorno') {
      if (s.opts.length !== 4 || s.optsE.length !== 4) problems.push(s.id + ': jumlah opsi');
      const oi = s.opts.map((x) => String(x).trim().toLowerCase());
      const oei = s.optsE.map((x) => String(x).trim().toLowerCase());
      const cs = Array.isArray(s.corr) ? s.corr : [s.corr];
      const cse = Array.isArray(s.corrE) ? s.corrE : [s.corrE];
      if (!cs.every((x) => oi.includes(String(x).trim().toLowerCase()))) problems.push(s.id + ': corr ID tidak di opts');
      if (!cse.every((x) => oei.includes(String(x).trim().toLowerCase()))) problems.push(s.id + ': corr EN tidak di optsE');
      if (new Set(oi).size !== oi.length || new Set(oei).size !== oei.length) problems.push(s.id + ': duplikat opsi');
      if (s.t === 'multi' && cs.length < 2) problems.push(s.id + ': multi 1 benar');
    }
  }

  // ---- hex round-trip + ASCII literal dari file SQL ----
  // 6 file import (00-05) + file shuffle opsi (zz_*) — keduanya wajib ASCII
  const sqlFiles = fs.readdirSync(dir).filter((f) => f.endsWith('.sql')).sort();
  const importFiles = sqlFiles.filter((f) => /^0[0-5]_/.test(f));
  if (importFiles.length !== 6) problems.push('file sql import != 6 (' + importFiles.join(',') + ')');

  const needHex = new Set();     // string tunggal ber-Arab -> CONVERT(0x hexM ...)
  const needPlain = new Set();   // string tunggal ASCII -> literal 'escaped'
  const needSer = new Set();     // array (opts/optsE/corr-multi) -> CONVERT(0x hexM(phpser) ...)
  const matBySlv = {};
  materi.forEach((m) => { (matBySlv[m.slv] = matBySlv[m.slv] || []).push(m); });

  const addSingle = (s) => { const v = String(s); (hasArabic(v) ? needHex : needPlain).add(v); };
  const addArray = (a) => { needSer.add(JSON.stringify(a.map(String))); };

  sublevels.forEach((sl) => addSingle(sl.name));
  for (const m of materi) addSingle(m.title);
  for (const s of soal) {
    addSingle(s.q); addSingle(s.qe);
    addArray(s.opts); addArray(s.optsE);
    if (Array.isArray(s.corr)) addArray(s.corr); else addSingle(s.corr);
    if (Array.isArray(s.corrE)) addArray(s.corrE); else addSingle(s.corrE);
  }

  const allSql = sqlFiles.map((f) => fs.readFileSync(path.join(dir, f), 'utf8')).join('\n');
  // decode semua hex di file sekali (untuk round-trip)
  const found = new Set();
  const re = /CONVERT\(0x([0-9a-f]+) USING utf8mb4\)/g;
  let mm;
  while ((mm = re.exec(allSql))) {
    try { found.add(decodeHex(mm[1])); } catch (e) { problems.push('decode gagal: ' + e.message); }
  }
  // 1) string tunggal ber-Arab -> CONVERT(0x hexM ...) dan round-trip
  for (const raw of needHex) {
    const expected = 'CONVERT(0x' + hexM(raw) + ' USING utf8mb4)';
    if (!allSql.includes(expected)) problems.push('hex tidak ditemukan: ' + JSON.stringify(raw.slice(0, 40)));
    if (!found.has(raw)) problems.push('round-trip gagal: ' + JSON.stringify(raw.slice(0, 40)));
  }
  // 2) array -> CONVERT(0x hexM(phpser) ...) dan round-trip
  for (const key of needSer) {
    const arr = JSON.parse(key);
    const expected = 'CONVERT(0x' + hexM(phpser(arr)) + ' USING utf8mb4)';
    if (!allSql.includes(expected)) problems.push('serialized tidak ditemukan: ' + key.slice(0, 60));
    if (!found.has(phpser(arr))) problems.push('round-trip serialize gagal: ' + key.slice(0, 60));
  }
  // 3) string tunggal ASCII -> literal dengan escape ''
  for (const raw of needPlain) {
    const esc = raw.replace(/'/g, "''");
    if (!allSql.includes("'" + esc + "'")) problems.push('literal tidak ditemukan: ' + JSON.stringify(esc.slice(0, 40)));
  }
  // 4) ASCII byte
  for (const f of sqlFiles) {
    const buf = fs.readFileSync(path.join(dir, f));
    for (const b of buf) if (b > 127) { problems.push(f + ' mengandung byte non-ASCII'); break; }
  }
  // 5) struktur baris: jumlah VALUES per file sesuai manifest
  for (let n = 1; n <= 5; n++) {
    const fn = '0' + n + '_sublevel' + n + '.sql';
    const txt = fs.readFileSync(path.join(dir, fn), 'utf8');
    const nMat = matBySlv[n].length;
    const nSoal = soal.filter((s) => matBySlv[n].some((m) => m.id === s.mid)).length;
    const nq = (txt.match(/'QS/g) || []).length;
    if (nq !== nSoal) problems.push(fn + ': jumlah baris soal ' + nq + ' != ' + nSoal);
  }
  {
    const txt = fs.readFileSync(path.join(dir, '00_sublevels.sql'), 'utf8');
    const nq = (txt.match(/'SLV/g) || []).length;
    if (nq !== 5) problems.push('00_sublevels.sql: jumlah ' + nq + ' != 5');
  }
  // 6) metadata (now/desc) konsisten
  if (rows.now !== NOW) problems.push('rows.now != NOW');
  if (rows.desc !== DESC) problems.push('rows.desc != DESC');

  console.log('=== VERIFY LOCAL — LEVEL 6 ===');
  console.log('sublevels ' + sublevels.length + ' | materi ' + materi.length + ' | soal ' + soal.length + ' | file sql ' + sqlFiles.length);
  console.log('Masalah:', problems.length ? '\n  ' + problems.join('\n  ') : '0 \u2713 (siap diimport)');

} else if (mode === 'api') {
  const BASE = 'https://baqi.jannahku.com/react/';
  const KEY = 'X64irOkE01qT0jWpG6re95j4MTHIa0Y5LiUK5Z3zFtPU7';
  const toArr = (d) => (Array.isArray(d) ? d : (d && d.value && Array.isArray(d.value) ? d.value : []));
  async function get(u) { try { const r = await fetch(u, { signal: AbortSignal.timeout(30000) }); return r.ok ? await r.json() : null; } catch (e) { return null; } }
  const pad = (n, len) => String(n).padStart(len, '0');

  (async () => {
    const rows = JSON.parse(fs.readFileSync(path.join(dir, 'rows.json'), 'utf8'));
    const subs = toArr(await get(BASE + 'sublevels/Level%206/' + KEY));
    if (subs.length !== 5) problems.push('API sublevels != 5 (' + subs.length + ')');
    for (const s of subs) console.log('  ' + s.id + ' ' + s.name + ' ' + s.backgroundColor);
    for (let n = 1; n <= 5; n++) {
      const expId = 'SLV' + pad(36 + n, 12);
      const sl = subs.find((x) => x.id === expId);
      if (!sl) { problems.push('SLV ' + expId + ' tidak ada'); continue; }
      const mats = toArr(await get(BASE + 'materi/get/' + 'Level 6' + '/' + sl.name + '/' + KEY));
      if (mats.length !== 8) problems.push(sl.name + ': materi API != 8 (' + mats.length + ')');
      for (const m of mats) {
        const exp = rows.materi.find((x) => x.id === m.id);
        if (!exp) { problems.push(m.id + ': tidak ada di manifest'); continue; }
        if (m.state_exam !== 'yes' || m.doc !== '' || m.watch !== '' || m.test !== '') problems.push(m.id + ': field doc/watch/test/state_exam tidak sesuai');
        if (m.information !== exp.title) problems.push(m.id + ': information berbeda');
        const qs = toArr(await get(BASE + 'questions/mid/' + m.id + '/' + KEY));
        const expectCount = exp.type === 'quran' ? 6 : 8;
        if (qs.length !== expectCount) { problems.push(m.id + ': jumlah soal ' + qs.length + ' != ' + expectCount); continue; }
        for (const raw of qs) {
          const wrapped = !!raw && !!raw.value && typeof raw.value === 'object' && !Array.isArray(raw.value) && ('type' in raw.value || 'question' in raw.value);
          const v = wrapped ? raw.value : raw;
          const qid = v.id || (raw && raw.id);
          const ex = rows.soal.find((x) => x.id === qid);
          if (!ex) { problems.push(qid + ': tidak ada di manifest'); continue; }
          const jc = (a, b) => JSON.stringify(a) === JSON.stringify(b);
          if (v.mid !== m.id) problems.push(qid + ': mid salah (' + v.mid + ')');
          if (!jc(v.type, ex.t)) problems.push(qid + ': type berbeda (' + v.type + ' vs ' + ex.t + ')');
          if (!jc(v.question, ex.q)) problems.push(qid + ': question ID berbeda');
          if (!jc(v.question_en, ex.qe)) problems.push(qid + ': question_en berbeda');
          if (!jc(v.correct_option, ex.corr)) problems.push(qid + ': correct_option berbeda');
          if (!jc(v.correct_option_en, ex.corrE)) problems.push(qid + ': correct_option_en berbeda');
          if (!jc(v.options, ex.opts)) problems.push(qid + ': options berbeda');
          if (!jc(v.options_en, ex.optsE)) problems.push(qid + ': options_en berbeda');
        }
      }
    }
    console.log('\n=== VERIFY API — LEVEL 6 (setelah import) ===');
    console.log('Masalah:', problems.length ? '\n  ' + problems.join('\n  ') : '0 \u2713 (data tampil & benar)');
  })().catch((e) => console.error('ERR', e));
} else {
  console.log('mode tidak dikenal:', mode);
}
if (mode === 'local' || (mode === 'api' && problems.length)) process.exit(problems.length ? 1 : 0);