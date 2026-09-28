// ============================================
// GENERATOR SQL LEVEL 6 (KURIKULUM AL-QURAN) — Baqi
// 5 sublevel x 8 materi = 40 materi; soal quran 6 / grammar 8.
//  Path A: Arab via CONVERT(0x... USING utf8mb4); ASCII literal dengan escape ''.
//  File output 100% ASCII.
// Build: PREVIEW default; FINAL=1 tulis output/l6/*.sql
// ============================================
const fs = require('fs');
const path = require('path');
const FINAL = process.env.FINAL === '1';
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

const norm = (s) => String(s).trim().toLowerCase();
const hasArabic = (s) => /[\u0600-\u06FF]/.test(String(s));
const safeChar = (ch) => ch < '\x80' || /[\u0600-\u06FF\u061C\u061F]/.test(ch) || /[\u0640-\u0652\u0670\u06D6-\u06ED]/.test(ch);
const allSafe = (s) => [...String(s)].every(safeChar);

const pad = (n, len) => String(n).padStart(len, '0');
const slvId = (n) => 'SLV' + pad(36 + n, 12);          // 037..041
const mtrId = (n) => 'MTR' + pad(205 + n, 12);         // 206..245
const qstId = (i) => 'QST' + pad(4000 + i, 20);        // 4000..
const BG = ['#7BA95C', '#EE6C4D', '#A7BD3C'];

// ---- load konten ----
const content = [1, 2, 3, 4, 5].map((n) => require(path.join(__dirname, 'content-s' + n + '.js')));
if (content.some((c) => !Array.isArray(c) || c.length !== 8)) throw new Error('Setiap sublevel harus berisi 8 materi');

// ---- validasi ----
const problems = [];
let qstIdx = -1;
const seenMtr = new Set(), seenSlv = new Set(), seenQst = new Set();
const MATERI = [];   // {id, slv, type, range, title, soal:[] }
const SOAL = [];     // {id, mid, ...soal fields}
const SUBLEVELS = []; // {id, sub(n), bg}

for (let n = 1; n <= 5; n++) {
  const sub = { id: slvId(n), name: 'Sublevel ' + n, bg: BG[(n - 1) % 3] };
  if (seenSlv.has(sub.id)) problems.push('SLV duplikat ' + sub.id);
  seenSlv.add(sub.id);
  SUBLEVELS.push(sub);

  content[n - 1].forEach((mat, k) => {
    const mid = mtrId((n - 1) * 8 + (k + 1)); // 206..245
    if (seenMtr.has(mid)) problems.push('MTR duplikat ' + mid);
    seenMtr.add(mid);
    const tag = 'SLV' + n + ' ' + mat.title.slice(0, 30);

    const nOpt = mat.soal.filter((x) => x.t === 'option').length;
    const nMulti = mat.soal.filter((x) => x.t === 'multi').length;
    const nYn = mat.soal.filter((x) => x.t === 'yesorno').length;
    if (mat.type === 'quran' && mat.soal.length !== 6) problems.push(tag + ': quran soal != 6');
    if (mat.type === 'quran' && (nOpt !== 5 || nYn !== 1)) problems.push(tag + ': quran harus 5 option + 1 yesorno');
    if (mat.type === 'grammar' && mat.soal.length !== 8) problems.push(tag + ': grammar soal != 8');
    if (mat.type === 'grammar' && !(nYn === 1 && ((nOpt === 7 && nMulti === 0) || (nOpt === 6 && nMulti === 1))))
      problems.push(tag + ': grammar harus 7 option+1 yesorno ATAU 6 option+1 multi+1 yesorno (' + nOpt + '/' + nMulti + '/' + nYn + ')');

    mat.soal.forEach((x, i) => {
      qstIdx++;
      const qid = qstId(qstIdx);
      if (seenQst.has(qid)) problems.push('QST duplikat ' + qid);
      seenQst.add(qid);
      if (!x.q.trim() || !x.qe.trim()) problems.push(qid + ': teks kosong');
      for (const s of [x.q, x.qe]) {
        if (/["\\]/.test(s)) problems.push(qid + ': kutip ganda/backslash di teks');
        if (!allSafe(s)) problems.push(qid + ': karakter non-ASCII non-Arab ' + JSON.stringify([...s].find((c) => !safeChar(c))));
      }
      if (x.t === 'yesorno') {
        if (x.opts.join(',') !== 'Yes,No') problems.push(qid + ': yesorno options != Yes,No');
        if (!['Yes', 'No'].includes(String(x.corr))) problems.push(qid + ': corr yesorno tidak valid');
      } else {
        if (x.opts.length !== 4 || x.optsE.length !== 4) problems.push(qid + ': opsi harus 4');
        for (const k of ['opts', 'optsE']) {
          const set = x[k].map(norm);
          if (new Set(set).size !== set.length) problems.push(qid + ': duplikat di ' + k);
          for (const s of x[k]) {
            if (/["\\]/.test(s)) problems.push(qid + ': kutip ganda/backslash di opsi ' + k);
            if (!allSafe(s)) problems.push(qid + ': non-ASCII non-Arab di ' + k + ' ' + JSON.stringify([...s].find((c) => !safeChar(c))));
          }
        }
        const c = Array.isArray(x.corr) ? x.corr : [x.corr];
        const ce = Array.isArray(x.corrE) ? x.corrE : [x.corrE];
        const oi = x.opts.map(norm), oei = x.optsE.map(norm);
        if (!c.length || c.some((s) => !oi.includes(norm(s)))) problems.push(qid + ': corr ID tidak di opts');
        if (!ce.length || ce.some((s) => !oei.includes(norm(s)))) problems.push(qid + ': corr EN tidak di optsE');
        if (x.t === 'multi' && c.length < 2) problems.push(qid + ': multi tapi 1 benar');
      }
      SOAL.push({ id: qid, mid, ...x });
    });

    MATERI.push({ id: mid, slv: n, sublevel: sub.name, type: mat.type, range: mat.range || '', title: mat.title, soalIdxs: SOAL.slice(-mat.soal.length).map((s) => s.id) });
  });
}

if (qstIdx + 1 !== 280) problems.push('Total soal harus 280, dapat ' + (qstIdx + 1));
if (qstIdx > 999) problems.push('Melebihi blok QST 4000-4999: ' + qstIdx);

console.log('=== LEVEL 6: 5 SUBLEVEL + 40 MATERI + 280 SOAL ===');
SUBLEVELS.forEach((s, i) => {
  const mats = MATERI.filter((m) => m.slv === i + 1);
  console.log(' ' + s.id + ' | ' + s.name + ' | ' + mats.map((m) => m.id).join(' '));
});
function qsum(soals) { const o = soals.filter((x) => x.t === 'option').length + soals.filter((x) => x.t === 'multi').length; const y = soals.filter((x) => x.t === 'yesorno').length; return o + ' option/multi + ' + y + ' yesorno'; }
MATERI.forEach((m) => {
  const ss = SOAL.filter((s) => s.mid === m.id);
  console.log('  ' + m.id + ' [' + m.type + '] ' + (m.range ? '(' + m.range + ') ' : '') + m.title + ' -> ' + ss.length + ' soal (' + qsum(ss) + ')');
});
console.log('Masalah:', problems.length ? '\n  ' + problems.join('\n  ') : '0 \u2713');
if (problems.length) { console.log('\nBatal tulis SQL.'); return; }

// ---- SQL ----
const wrapC = (v) => (Array.isArray(v)
  ? 'CONVERT(0x' + hexM(phpser(v)) + ' USING utf8mb4)'
  : hasArabic(String(v))
    ? 'CONVERT(0x' + hexM(String(v)) + ' USING utf8mb4)'
    : "'" + String(v).replace(/'/g, "''") + "'");

// columns secara eksplisit (superset dari model existing)
const INSERT_SL = 'INSERT INTO sub_levels(id, name, level, state_exam, ujian_grammer, ujian_pelajaran, backgroundColor, created, updated) VALUES\n';
const INSERT_MTR = 'INSERT INTO materi(id, level, sub_levels, doc, doc_en, test, watch, information, information_en, description, state_exam, created, updated) VALUES\n';
const INSERT_SOAL = 'INSERT INTO soal(id, question, type, mid, options, image, correct_option, question_en, options_en, correct_option_en, created, updated) VALUES\n';

const HEAD = (t) => `-- ============================================
-- ${t}
-- Path A: semua teks Arab via CONVERT(0x... USING utf8mb4).
-- File 100% ASCII. CARA IMPORT: phpMyAdmin -> Import -> file ini.
-- ============================================

SET NAMES utf8mb4;

`;

if (FINAL) {
  const dir = path.join(__dirname, 'output', 'l6');
  fs.mkdirSync(dir, { recursive: true });

  // 00 sublevels
  const slRows = SUBLEVELS.map((s) => `('${s.id}','${s.name}','Level 6','yes','','','${s.bg}','${NOW}','${NOW}')`);
  let sql0 = HEAD('INSERT LEVEL 6 - 5 SUBLEVEL (sub_levels)') + INSERT_SL + slRows.join(',\n') + ';\n';
  fs.writeFileSync(path.join(dir, '00_sublevels.sql'), sql0, 'utf8');

  // 01..05 per sublevel: materi + soal
  for (let n = 1; n <= 5; n++) {
    const mats = MATERI.filter((m) => m.slv === n);
    const mRows = mats.map((m) => {
      const info = wrapC(m.title);
      return `('${m.id}','Level 6','Sublevel ${n}','','','','',${info},'','${DESC}','yes','${NOW}','${NOW}')`;
    });
    const soals = SOAL.filter((s) => mats.some((m) => m.id === s.mid));
    const qRows = soals.map((x) => {
      const corr = wrapC(x.corr), corrE = wrapC(x.corrE);
      const opts = 'CONVERT(0x' + hexM(phpser(x.opts)) + ' USING utf8mb4)';
      const optsE = 'CONVERT(0x' + hexM(phpser(x.optsE)) + ' USING utf8mb4)';
      return `('${x.id}',${wrapC(x.q)},'${x.t}','${x.mid}',${opts},'',${corr},${wrapC(x.qe)},${optsE},${corrE},'${NOW}','${NOW}')`;
    });
    const sql = HEAD(`INSERT LEVEL 6 - ${mats.length} MATERI + ${qRows.length} SOAL (SUBLEVEL ${n})`)
      + INSERT_MTR + mRows.join(',\n') + ';\n\n'
      + INSERT_SOAL + qRows.join(',\n') + ';\n';
    fs.writeFileSync(path.join(dir, '0' + n + '_sublevel' + n + '.sql'), sql, 'utf8');
  }

  // manifest (sidecar untuk verifikasi lokal — bukan untuk import)
  const manifest = {
    sublevels: SUBLEVELS, materi: MATERI, soal: SOAL,
    now: NOW, desc: DESC, count: { sublevels: SUBLEVELS.length, materi: MATERI.length, soal: SOAL.length }
  };
  fs.writeFileSync(path.join(dir, 'rows.json'), JSON.stringify(manifest, null, 1), 'utf8');

  // byte-check ASCII
  let bad = 0;
  for (const f of fs.readdirSync(dir).filter((x) => x.endsWith('.sql'))) {
    const b = fs.readFileSync(path.join(dir, f));
    let na = 0;
    for (const c of b) if (c > 127) na++;
    if (na) { bad++; console.log(f, 'NON-ASCII', na); }
  }
  console.log('\nFile ditulis :', dir);
  console.log('Non-ASCII   :', bad === 0 ? '0 (semua file ASCII)' : 'ADA MASALAH');
  console.log('Total       : sublevels ' + SUBLEVELS.length + ', materi ' + MATERI.length + ', soal ' + SOAL.length);
} else {
  console.log('\n(PREVIEW ONLY — FINAL=1 untuk menulis file SQL.)');
}