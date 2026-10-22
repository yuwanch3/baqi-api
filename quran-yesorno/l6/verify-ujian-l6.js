// ============================================
// VERIFIKASI LEVEL 6 — UJIAN PELAJARAN + UJIAN TATA BAHASA (final_exam)
//  local : cek file SQL zz_ujian1_level6_v1.sql + rows-ujian.json
//          (ID FQT unik/blok, jumlah 140, excerpt/lid, tipe, ASCII, hex round-trip)
//  api   : verifikasi read-only setelah import (subexam/<slv>/<excerpt>/<api>)
// Komposisi: pelajaran 8 option + 2 multi + 2 yesorno; grammer 8 option + 2 drag + 3 multi + 3 yesorno.
// Usage  : node l6/verify-ujian-l6.js            -> local
//          node l6/verify-ujian-l6.js api        -> API (setelah user import)
// ============================================
const fs = require('fs');
const path = require('path');
const mode = process.argv[2] || 'local';
const dir = path.join(__dirname, 'output', 'l6');
const SQL_FILE = path.join(dir, 'zz_ujian1_level6_v1.sql');
const NOW = '2026-09-28 00:00:00';

const cp1252dec = new TextDecoder('windows-1252');
const byteToChar = new Map();
for (let b = 0; b < 256; b++) byteToChar.set(b, cp1252dec.decode(Uint8Array.of(b)));
const charToByte = new Map();
for (let b = 0; b < 256; b++) charToByte.set(byteToChar.get(b), b);
const toM = (s) => cp1252dec.decode(Buffer.from(s, 'utf8'));
const hexM = (s) => Buffer.from(toM(s), 'utf8').toString('hex');
const phpser = (arr) => 'a:' + arr.length + ':{' + arr.map((s, i) => `i:${i};s:${Buffer.byteLength(s, 'utf8')}:"${s}"`).join(';') + ';}';
const hasArabic = (s) => /[\u0600-\u06FF]/.test(String(s));

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
  const rows = JSON.parse(fs.readFileSync(path.join(dir, 'rows-ujian.json'), 'utf8'));
  const exams = rows.exams;
  const allSoal = [];
  exams.forEach((e) => { allSoal.push(...e.pelajaran, ...e.grammer); });

  if (exams.length !== 5) problems.push('banks != 5 (' + exams.length + ')');
  if (allSoal.length !== 140) problems.push('soal != 140 (' + allSoal.length + ')');
  if (rows.now !== NOW) problems.push('rows.now != NOW');
  const uniq = (arr) => new Set(arr).size === arr.length;
  const cnt = (arr, t) => arr.filter((x) => x.t === t).length;

  // ---- struktur manifest ----
  const slvExpected = (n) => 'SLV' + String(36 + n).padStart(12, '0');
  for (const e of exams) {
    if (e.lid !== slvExpected(e.slv)) problems.push(e.lid + ': lid tidak sesuai urutan');
    if (e.pelajaran.length !== 12) problems.push(e.lid + ': pelajaran != 12');
    if (e.grammer.length !== 16) problems.push(e.lid + ': grammer != 16');
    if (cnt(e.pelajaran, 'option') !== 8 || cnt(e.pelajaran, 'multi') !== 2 || cnt(e.pelajaran, 'yesorno') !== 2) {
      problems.push(e.lid + ': pelajaran harus 8 option + 2 multi + 2 yesorno');
    }
    if (cnt(e.grammer, 'option') !== 8 || cnt(e.grammer, 'drag') !== 2 || cnt(e.grammer, 'multi') !== 3 || cnt(e.grammer, 'yesorno') !== 3) {
      problems.push(e.lid + ': grammer harus 8 option + 2 drag + 3 multi + 3 yesorno');
    }
    e.pelajaran.forEach((x) => { if (x.excerpt !== 'Ujian Pelajaran') problems.push(x.id + ': excerpt pelajaran salah'); });
    e.grammer.forEach((x) => { if (x.excerpt !== 'Ujian Grammer') problems.push(x.id + ': excerpt grammer salah'); });
  }
  if (!uniq(allSoal.map((s) => s.id))) problems.push('FQT duplikat di manifest');

  // ID FQT: blok 90000000000..90000000139 urut
  const qids = allSoal.map((s) => Number(s.id.slice(3)));
  if (Math.min(...qids) !== 90000000000 || Math.max(...qids) !== 90000000139) problems.push('FQT harus 90000000000-90000000139, dpt ' + Math.min(...qids) + '-' + Math.max(...qids));
  for (let i = 0; i < allSoal.length; i++) {
    const e = 'FQT' + String(90000000000 + i).padStart(20, '0');
    if (allSoal[i].id !== e) { problems.push('FQT urutan salah: ' + allSoal[i].id + ' harus ' + e); break; }
  }

  // isi soal
  for (const s of allSoal) {
    const wantOpts = s.t === 'yesorno' ? 2 : 4;
    if (s.opts.length !== wantOpts || s.optsE.length !== wantOpts) problems.push(s.id + ': opsi harus ' + wantOpts + ' (tipe ' + s.t + ')');
    const oi = s.opts.map((x) => String(x).trim().toLowerCase());
    const oei = s.optsE.map((x) => String(x).trim().toLowerCase());
    const cs = Array.isArray(s.corr) ? s.corr : [s.corr];
    const cse = Array.isArray(s.corrE) ? s.corrE : [s.corrE];
    if (!cs.every((x) => oi.includes(String(x).trim().toLowerCase()))) problems.push(s.id + ': corr ID tidak di opts');
    if (!cse.every((x) => oei.includes(String(x).trim().toLowerCase()))) problems.push(s.id + ': corr EN tidak di optsE');
    if (new Set(oi).size !== oi.length || new Set(oei).size !== oei.length) problems.push(s.id + ': duplikat opsi');
    if (s.t === 'drag' && (!Array.isArray(s.corr) || cs.length < 1 || cs.length > 3)) problems.push(s.id + ': drag harus array 1-3 benar');
    if (s.t === 'multi' && (!Array.isArray(s.corr) || cs.length < 2)) problems.push(s.id + ': multi harus array minimal 2 benar');
    if (s.t === 'yesorno') {
      if (JSON.stringify(s.opts) !== '["Yes","No"]' || JSON.stringify(s.optsE) !== '["Yes","No"]') problems.push(s.id + ': yesorno opsi harus Yes,No');
      if (!['Yes', 'No'].includes(String(s.corr)) || !['Yes', 'No'].includes(String(s.corrE))) problems.push(s.id + ': yesorno corr harus Yes/No');
      if (Array.isArray(s.corr) || Array.isArray(s.corrE)) problems.push(s.id + ': yesorno corr tidak boleh array');
    }
  }

  // ---- cek file SQL ----
  if (!fs.existsSync(SQL_FILE)) {
    problems.push('zz_ujian1_level6_v1.sql tidak ada');
  } else {
    const txt = fs.readFileSync(SQL_FILE, 'utf8');
    const fileIds = [...txt.matchAll(/'FQT(\d{20})'/g)].map((m) => Number(m[1]));
    const expIds = allSoal.map((s) => Number(s.id.slice(3)));
    if (fileIds.length !== 140) problems.push('sql: jumlah id FQT ' + fileIds.length + ' != 140');
    if (!uniq(fileIds)) problems.push('sql: FQT duplikat');
    const sameOrder = expIds.every((v, i) => v === fileIds[i]);
    if (!sameOrder) problems.push('sql: urutan FQT tidak sama dengan manifest');

    const nPel = (txt.match(/'Ujian Pelajaran'/g) || []).length;
    const nGrm = (txt.match(/'Ujian Grammer'/g) || []).length;
    if (nPel !== 60) problems.push('sql: excerpt Ujian Pelajaran ' + nPel + ' != 60');
    if (nGrm !== 80) problems.push('sql: excerpt Ujian Grammer ' + nGrm + ' != 80');
    const nOpt = (txt.match(/'option'/g) || []).length;
    const nMul = (txt.match(/'multi'/g) || []).length;
    const nYes = (txt.match(/'yesorno'/g) || []).length;
    const nDrag = (txt.match(/'drag'/g) || []).length;
    if (nOpt !== 80) problems.push('sql: type option ' + nOpt + ' != 80');
    if (nMul !== 25) problems.push('sql: type multi ' + nMul + ' != 25');
    if (nYes !== 25) problems.push('sql: type yesorno ' + nYes + ' != 25');
    if (nDrag !== 10) problems.push('sql: type drag ' + nDrag + ' != 10');
    if (!/REPLACE INTO final_exam/.test(txt)) problems.push('sql: bukan REPLACE INTO final_exam');
    if (!/SET NAMES utf8mb4/.test(txt)) problems.push('sql: SET NAMES utf8mb4 hilang');

    // lid per SLV: setiap SLV punya 28 baris
    for (let n = 1; n <= 5; n++) {
      const slv = slvExpected(n);
      const count = (txt.match(new RegExp("'" + slv + "'", 'g')) || []).length;
      if (count !== 28) problems.push(slv + ': jumlah baris ' + count + ' != 28');
    }

    // hex round-trip: setiap string ber-Arab tunggal & array harus ada & ter-decode
    const allSql = txt;
    const found = new Set();
    const re = /CONVERT\(0x([0-9a-f]+) USING utf8mb4\)/g;
    let mm;
    while ((mm = re.exec(allSql))) {
      try { found.add(decodeHex(mm[1])); } catch (e) { problems.push('decode gagal: ' + e.message); }
    }
    const needHex = new Set();
    const needSer = new Set();
    const addSingle = (s) => { const v = String(s); if (hasArabic(v)) needHex.add(v); };
    const addArray = (a) => { needSer.add(JSON.stringify(a.map(String))); };
    for (const s of allSoal) {
      addSingle(s.q); addSingle(s.qe);
      addArray(s.opts); addArray(s.optsE);
      if (Array.isArray(s.corr)) addArray(s.corr); else addSingle(s.corr);
      if (Array.isArray(s.corrE)) addArray(s.corrE); else addSingle(s.corrE);
    }
    for (const raw of needHex) {
      const expected = 'CONVERT(0x' + hexM(raw) + ' USING utf8mb4)';
      if (!allSql.includes(expected)) problems.push('hex tidak ditemukan: ' + JSON.stringify(raw.slice(0, 40)));
      if (!found.has(raw)) problems.push('round-trip gagal: ' + JSON.stringify(raw.slice(0, 40)));
    }
    for (const key of needSer) {
      const arr = JSON.parse(key);
      const expected = 'CONVERT(0x' + hexM(phpser(arr)) + ' USING utf8mb4)';
      if (!allSql.includes(expected)) problems.push('serialized tidak ditemukan: ' + key.slice(0, 60));
      if (!found.has(phpser(arr))) problems.push('round-trip serialize gagal: ' + key.slice(0, 60));
    }

    // ASCII byte
    const buf = fs.readFileSync(SQL_FILE);
    for (const b of buf) if (b > 127) { problems.push('sql: byte non-ASCII'); break; }
  }

  console.log('=== VERIFY LOCAL — LEVEL 6 UJIAN (final_exam) ===');
  console.log('banks ' + exams.length + ' | soal ' + allSoal.length + ' | option ' + cnt(allSoal, 'option') + ' + multi ' + cnt(allSoal, 'multi') + ' + yesorno ' + cnt(allSoal, 'yesorno') + ' + drag ' + cnt(allSoal, 'drag'));
  console.log('Masalah:', problems.length ? '\n  ' + problems.join('\n  ') : '0 \u2713 (siap diimport)');

} else if (mode === 'api') {
  const BASE = 'https://baqi.jannahku.com/react/';
  const KEY = 'X64irOkE01qT0jWpG6re95j4MTHIa0Y5LiUK5Z3zFtPU7';
  const toArr = (d) => (Array.isArray(d) ? d : (d && d.value && Array.isArray(d.value) ? d.value : []));
  async function get(u) { try { const r = await fetch(u, { signal: AbortSignal.timeout(30000) }); return r.ok ? await r.json() : null; } catch (e) { return null; } }
  const pad = (n, len) => String(n).padStart(len, '0');

  (async () => {
    const rows = JSON.parse(fs.readFileSync(path.join(dir, 'rows-ujian.json'), 'utf8'));
    const byId = new Map();
    rows.exams.forEach((e) => { e.pelajaran.forEach((s) => byId.set(s.id, s)); e.grammer.forEach((s) => byId.set(s.id, s)); });

    for (let n = 1; n <= 5; n++) {
      const slv = 'SLV' + pad(36 + n, 12);
      for (const ex of ['Ujian Pelajaran', 'Ujian Grammer']) {
        const got = toArr(await get(BASE + 'subexam/' + slv + '/' + ex + '/' + KEY));
        const expectCount = ex === 'Ujian Pelajaran' ? 12 : 16;
        if (got.length !== expectCount) { problems.push(slv + ' ' + ex + ': jumlah ' + got.length + ' != ' + expectCount); continue; }
        for (const raw of got) {
          const v = (raw && raw.value && typeof raw.value === 'object' && !Array.isArray(raw.value)) ? raw.value : raw;
          const qid = v.id || (raw && raw.id);
          const exP = byId.get(qid);
          if (!exP) { problems.push(qid + ': tidak ada di manifest'); continue; }
          const jc = (a, b) => JSON.stringify(a) === JSON.stringify(b);
          if (v.lid !== slv) problems.push(qid + ': lid salah (' + v.lid + ')');
          if (v.excerpt !== ex) problems.push(qid + ': excerpt salah (' + v.excerpt + ')');
          if (!jc(v.type, exP.t)) problems.push(qid + ': type berbeda (' + v.type + ' vs ' + exP.t + ')');
          if (!jc(v.question, exP.q)) problems.push(qid + ': question ID berbeda');
          if (!jc(v.question_en, exP.qe)) problems.push(qid + ': question_en berbeda');
          if (!jc(v.correct_option, exP.corr)) problems.push(qid + ': correct_option berbeda');
          if (!jc(v.correct_option_en, exP.corrE)) problems.push(qid + ': correct_option_en berbeda');
          if (!jc(v.options, exP.opts)) problems.push(qid + ': options berbeda');
          if (!jc(v.options_en, exP.optsE)) problems.push(qid + ': options_en berbeda');
        }
      }
    }
    console.log('\n=== VERIFY API — LEVEL 6 UJIAN (setelah import) ===');
    console.log('Masalah:', problems.length ? '\n  ' + problems.join('\n  ') : '0 \u2713 (data tampil & benar)');
  })().catch((e) => console.error('ERR', e));
} else {
  console.log('mode tidak dikenal:', mode);
}
if (mode === 'local' || (mode === 'api' && problems.length)) process.exit(problems.length ? 1 : 0);