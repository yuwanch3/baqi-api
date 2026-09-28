// ============================================
// GENERATOR SQL LEVEL 6 — UJIAN 1 PELAJARAN + UJIAN 1 TATA BAHASA
// Tabel final_exam (prefix FQT), excerpt 'Ujian Pelajaran' / 'Ujian Grammer',
// lid = SLV000000000037..041 (Level 6).
// Pola jumlah = Level 5: Pelajaran 12 (option); Grammer 16 (14 option + 2 drag).
//  ID blok FQT: 90000000000.. (jauh dari produksi ~1051 & blok petro 92e9).
//  Path A: Arab via CONVERT(0x... USING utf8mb4); file 100% ASCII.
// Build: PREVIEW default; FINAL=1 tulis output/l6/zz_ujian1_level6_v1.sql
// ============================================
const fs = require('fs');
const path = require('path');
const FINAL = process.env.FINAL === '1';
const NOW = '2026-09-28 00:00:00';

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

const wrapC = (v) => (Array.isArray(v)
  ? 'CONVERT(0x' + hexM(phpser(v)) + ' USING utf8mb4)'
  : hasArabic(String(v))
    ? 'CONVERT(0x' + hexM(String(v)) + ' USING utf8mb4)'
    : "'" + String(v).replace(/'/g, "''") + "'");

const l6dir = path.join(__dirname, 'output', 'l6');
const banks = require('./exam-content.js');

// ---- bangun manifest ----
let fqt = 90000000000;
const fqtId = () => 'FQT' + String(fqt++).padStart(20, '0');
const pad = (n, len) => String(n).padStart(len, '0');
const slvId = (n) => 'SLV' + pad(36 + n, 12); // 037..041

const EXC_PEL = 'Ujian Pelajaran';
const EXC_GRM = 'Ujian Grammer';

const problems = [];
const manifest = { now: NOW, exams: [] };

const chkSoal = (x, lid, excerpt, qid) => {
  if (!['option', 'drag'].includes(x.t)) problems.push(qid + ': tipe tidak dikenal ' + x.t);
  if (x.opts.length !== 4 || x.optsE.length !== 4) problems.push(qid + ': opsi harus 4');
  for (const s of [x.q, x.qe, ...x.opts, ...x.optsE, ...(Array.isArray(x.corr) ? x.corr : [x.corr]), ...(Array.isArray(x.corrE) ? x.corrE : [x.corrE])]) {
    if (/["\\]/.test(s)) problems.push(qid + ': kutip ganda/backslash: ' + JSON.stringify(String(s).slice(0, 40)));
    if (!allSafe(s)) problems.push(qid + ': non-ASCII non-Arab ' + JSON.stringify([...String(s)].find((c) => !safeChar(c))));
  }
  const oi = x.opts.map(norm), oei = x.optsE.map(norm);
  if (new Set(oi).size !== oi.length || new Set(oei).size !== oei.length) problems.push(qid + ': duplikat opsi');
  const c = Array.isArray(x.corr) ? x.corr : [x.corr];
  const ce = Array.isArray(x.corrE) ? x.corrE : [x.corrE];
  if (!c.length || c.some((s) => !oi.includes(norm(s)))) problems.push(qid + ': corr ID tidak di opts');
  if (!ce.length || ce.some((s) => !oei.includes(norm(s)))) problems.push(qid + ': corr EN tidak di optsE');
  if (x.t === 'drag' && (!Array.isArray(x.corr) || c.length < 1 || c.length > 3)) problems.push(qid + ': drag harus array 1-3 benar');
  if (x.t === 'option' && (Array.isArray(x.corr) || Array.isArray(x.corrE))) problems.push(qid + ': option koran tidak boleh array');
  return { id: qid, lid, excerpt, ...x };
};

for (const b of banks) {
  const lid = b.lid;
  if (lid !== slvId(b.slv)) problems.push(lid + ': lid tidak cocok slv ' + b.slv);
  if (b.pelajaran.length !== 12) problems.push(lid + ': pelajaran != 12 (' + b.pelajaran.length + ')');
  if (b.grammer.length !== 16) problems.push(lid + ': grammer != 16 (' + b.grammer.length + ')');
  const pel = b.pelajaran.map((x) => chkSoal(x, lid, EXC_PEL, fqtId()));
  const grm = b.grammer.map((x) => chkSoal(x, lid, EXC_GRM, fqtId()));
  const nDrag = grm.filter((g) => g.t === 'drag').length;
  if (nDrag !== 2) problems.push(lid + ': grammer drag != 2 (' + nDrag + ')');
  manifest.exams.push({ slv: b.slv, lid, pelajaran: pel, grammer: grm });
}

const totalSoal = manifest.exams.reduce((n, e) => n + e.pelajaran.length + e.grammer.length, 0);
console.log('=== LEVEL 6 — UJIAN PELAJARAN (12) + TATA BAHASA (16) per sublevel ===');
manifest.exams.forEach((e) => {
  const g = e.grammer.filter((x) => x.t === 'drag').length;
  console.log(' ' + e.lid + ' | pelajaran ' + e.pelajaran.length + ' option | grammer ' + e.grammer.length + ' (14 option + ' + g + ' drag)');
});
console.log('Total soal final_exam baru:', totalSoal);
console.log('Masalah:', problems.length ? '\n  ' + problems.join('\n  ') : '0 \u2713');
if (problems.length) { console.log('\nBatal tulis SQL.'); return; }

// ---- SQL ----
const HEAD = (t) => `-- ============================================
-- ${t}
-- Path A: semua teks Arab via CONVERT(0x... USING utf8mb4).
-- File 100% ASCII. CARA IMPORT: phpMyAdmin -> Import -> file ini.
-- ============================================

SET NAMES utf8mb4;

`;

const INSERT_FEX = 'INSERT INTO final_exam(id, question, type, lid, excerpt, options, image, correct_option, question_en, options_en, correct_option_en, created, updated) VALUES\n';

const row = (x) => {
  const corr = wrapC(x.corr), corrE = wrapC(x.corrE);
  const opts = 'CONVERT(0x' + hexM(phpser(x.opts)) + ' USING utf8mb4)';
  const optsE = 'CONVERT(0x' + hexM(phpser(x.optsE)) + ' USING utf8mb4)';
  return `('${x.id}',${wrapC(x.q)},'${x.t}','${x.lid}','${x.excerpt}',${opts},'',${corr},${wrapC(x.qe)},${optsE},${corrE},'${NOW}','${NOW}')`;
};

if (FINAL) {
  fs.mkdirSync(l6dir, { recursive: true });
  const all = [];
  for (const e of manifest.exams) {
    all.push(...e.pelajaran.map(row));
    all.push(...e.grammer.map(row));
  }
  const sql = HEAD('INSERT LEVEL 6 - ' + all.length + ' SOAL UJIAN (final_exam, prefix FQT blok 9000000000+)')
    + '-- Hanya soal ujian final_exam L6 baru. TIDAK menyentuh soal materi / level lain.\n'
    + INSERT_FEX + all.join(',\n') + ';\n';
  const out = path.join(l6dir, 'zz_ujian1_level6_v1.sql');
  fs.writeFileSync(out, sql, 'utf8');

  fs.writeFileSync(path.join(l6dir, 'rows-ujian.json'), JSON.stringify(manifest, null, 1), 'utf8');

  let bad = 0;
  const b = fs.readFileSync(out);
  for (const c of b) if (c > 127) bad++;
  console.log('\nFile ditulis :', out);
  console.log('Non-ASCII    :', bad === 0 ? '0 (ASCII)' : 'ADA MASALAH (' + bad + ')');
  console.log('Total        : ' + all.length + ' INSERT final_exam');
} else {
  console.log('\n(PREVIEW ONLY — FINAL=1 untuk menulis file SQL.)');
}