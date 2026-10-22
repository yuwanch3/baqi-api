// ============================================
// GENERATOR SQL LEVEL 6 — UJIAN 1 PELAJARAN + UJIAN 1 TATA BAHASA
// Tabel final_exam (prefix FQT), excerpt 'Ujian Pelajaran' / 'Ujian Grammer',
// lid = SLV000000000037..041 (Level 6).
// Pola tipe per sublevel:
//   Pelajaran 12 : 8 option + 2 multi + 2 yesorno
//   Grammer 16   : 8 option + 2 drag + 3 multi + 3 yesorno
//   Total : option 80, multi 25, yesorno 25, drag 10 = 140.
// Urutan opsi option & multi DIACAK seeded (mulberry32, seed = id FQT)
// sebelum SQL/manifest ditulis -> posisi jawaban benar tidak selalu A.
// yesorno & drag tidak diacak (opsi tetap Yes/No atau pasangan kunci).
//  ID blok FQT: 90000000000.. (jauh dari produksi ~1051 & blok petro 92e9).
//  Path A: Arab via CONVERT(0x... USING utf8mb4); file 100% ASCII.
//  SQL pakai REPLACE INTO (idempoten: re-import menimpa 140 baris lama).
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

// ---- seeded shuffle (mulberry32) ----
const mulberry32 = (a) => () => {
  a |= 0; a = (a + 0x6D2B79F5) | 0;
  let t = Math.imul(a ^ (a >>> 15), 1 | a);
  t = (t + Math.imul(t ^ (t >>> 7), 61 | t)) ^ t;
  return ((t ^ (t >>> 14)) >>> 0) / 4294967296;
};
const seededPerm = (n, seed) => {
  const rnd = mulberry32(seed);
  const idx = Array.from({ length: n }, (_, i) => i);
  for (let i = n - 1; i > 0; i--) {
    const j = Math.floor(rnd() * (i + 1));
    [idx[i], idx[j]] = [idx[j], idx[i]];
  }
  return idx;
};
// acak urutan opts & optsE dengan permutasi identik (seed = id FQT)
const shuffleOpts = (x, seed) => {
  const p = seededPerm(x.opts.length, seed);
  x.opts = p.map((k) => x.opts[k]);
  x.optsE = p.map((k) => x.optsE[k]);
};

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
  if (!['option', 'drag', 'multi', 'yesorno'].includes(x.t)) problems.push(qid + ': tipe tidak dikenal ' + x.t);
  const wantOpts = x.t === 'yesorno' ? 2 : 4;
  if (x.opts.length !== wantOpts || x.optsE.length !== wantOpts) problems.push(qid + ': opsi harus ' + wantOpts);
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
  if (x.t === 'multi' && (!Array.isArray(x.corr) || c.length < 2)) problems.push(qid + ': multi harus array minimal 2 benar');
  if (x.t === 'option' && (Array.isArray(x.corr) || Array.isArray(x.corrE))) problems.push(qid + ': option koran tidak boleh array');
  if (x.t === 'yesorno') {
    if (JSON.stringify(x.opts) !== '["Yes","No"]' || JSON.stringify(x.optsE) !== '["Yes","No"]') problems.push(qid + ': yesorno opsi harus Yes,No');
    if (!['Yes', 'No'].includes(String(x.corr)) || !['Yes', 'No'].includes(String(x.corrE))) problems.push(qid + ': yesorno corr harus Yes/No');
    if (Array.isArray(x.corr) || Array.isArray(x.corrE)) problems.push(qid + ': yesorno corr tidak boleh array');
  }
  return { id: qid, lid, excerpt, ...x };
};

const cnt = (arr, t) => arr.filter((x) => x.t === t).length;

for (const b of banks) {
  const lid = b.lid;
  if (lid !== slvId(b.slv)) problems.push(lid + ': lid tidak cocok slv ' + b.slv);
  if (b.pelajaran.length !== 12) problems.push(lid + ': pelajaran != 12 (' + b.pelajaran.length + ')');
  if (b.grammer.length !== 16) problems.push(lid + ': grammer != 16 (' + b.grammer.length + ')');
  const pel = b.pelajaran.map((x) => chkSoal(x, lid, EXC_PEL, fqtId()));
  const grm = b.grammer.map((x) => chkSoal(x, lid, EXC_GRM, fqtId()));
  // komposisi per sublevel
  if (cnt(pel, 'option') !== 8 || cnt(pel, 'multi') !== 2 || cnt(pel, 'yesorno') !== 2) {
    problems.push(lid + ': pelajaran harus 8 option + 2 multi + 2 yesorno (dpt ' + cnt(pel, 'option') + '/' + cnt(pel, 'multi') + '/' + cnt(pel, 'yesorno') + ')');
  }
  if (cnt(grm, 'option') !== 8 || cnt(grm, 'drag') !== 2 || cnt(grm, 'multi') !== 3 || cnt(grm, 'yesorno') !== 3) {
    problems.push(lid + ': grammer harus 8 option + 2 drag + 3 multi + 3 yesorno (dpt ' + cnt(grm, 'option') + '/' + cnt(grm, 'drag') + '/' + cnt(grm, 'multi') + '/' + cnt(grm, 'yesorno') + ')');
  }
  // acak urutan opsi option & multi (seed = id FQT) -> SQL & manifest dari hasil acak
  for (const x of [...pel, ...grm]) {
    if (x.t === 'option' || x.t === 'multi') shuffleOpts(x, Number(x.id.slice(3)));
  }
  manifest.exams.push({ slv: b.slv, lid, pelajaran: pel, grammer: grm });
}

const totalSoal = manifest.exams.reduce((n, e) => n + e.pelajaran.length + e.grammer.length, 0);
console.log('=== LEVEL 6 — UJIAN PELAJARAN (12) + TATA BAHASA (16) per sublevel ===');
manifest.exams.forEach((e) => {
  const cp = cnt(e.pelajaran, 'option') + '/' + cnt(e.pelajaran, 'multi') + '/' + cnt(e.pelajaran, 'yesorno');
  const cg = cnt(e.grammer, 'option') + '/' + cnt(e.grammer, 'drag') + '/' + cnt(e.grammer, 'multi') + '/' + cnt(e.grammer, 'yesorno');
  console.log(' ' + e.lid + ' | pelajaran ' + e.pelajaran.length + ' (opt/multi/yorno ' + cp + ') | grammer ' + e.grammer.length + ' (opt/drag/multi/yorno ' + cg + ')');
});
const allS = manifest.exams.flatMap((e) => [...e.pelajaran, ...e.grammer]);
const dist = { option: cnt(allS, 'option'), multi: cnt(allS, 'multi'), yesorno: cnt(allS, 'yesorno'), drag: cnt(allS, 'drag') };
const posIdx = { 0: 0, 1: 0, 2: 0, 3: 0 };
for (const s of allS) {
  if (s.t !== 'option' && s.t !== 'multi') continue;
  const cs = Array.isArray(s.corr) ? s.corr : [s.corr];
  for (const cv of cs) posIdx[s.opts.findIndex((o) => norm(o) === norm(cv))]++;
}
console.log('Total soal final_exam baru:', totalSoal, '(' + Object.entries(dist).map(([k, v]) => k + ' ' + v).join(', ') + ')');
console.log('Posisi jawaban benar (option & multi): index ' + Object.entries(posIdx).map(([k, v]) => k + ': ' + v).join(' | '));
console.log('Masalah:', problems.length ? '\n  ' + problems.join('\n  ') : '0 \u2713');
if (problems.length) { console.log('\nBatal tulis SQL.'); return; }

// ---- SQL ----
const HEAD = (t) => `-- ============================================
-- ${t}
-- Path A: semua teks Arab via CONVERT(0x... USING utf8mb4).
-- File 100% ASCII. CARA IMPORT: phpMyAdmin -> Import -> file ini.
-- REPLACE INTO: impor ulang menimpa 140 baris lama (id Abu).
-- ============================================

SET NAMES utf8mb4;

`;

const REPLACE_FEX = 'REPLACE INTO final_exam(id, question, type, lid, excerpt, options, image, correct_option, question_en, options_en, correct_option_en, created, updated) VALUES\n';

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
  const sql = HEAD('REPLACE LEVEL 6 - ' + all.length + ' SOAL UJIAN (final_exam, prefix FQT blok 9000000000+)')
    + '-- Hanya soal ujian final_exam L6 baru. TIDAK menyentuh soal materi / level lain.\n'
    + REPLACE_FEX + all.join(',\n') + ';\n';
  const out = path.join(l6dir, 'zz_ujian1_level6_v1.sql');
  fs.writeFileSync(out, sql, 'utf8');

  fs.writeFileSync(path.join(l6dir, 'rows-ujian.json'), JSON.stringify(manifest, null, 1), 'utf8');

  let bad = 0;
  const b = fs.readFileSync(out);
  for (const c of b) if (c > 127) bad++;
  console.log('\nFile ditulis :', out);
  console.log('Non-ASCII    :', bad === 0 ? '0 (ASCII)' : 'ADA MASALAH (' + bad + ')');
  console.log('Total        : ' + all.length + ' REPLACE final_exam');
} else {
  console.log('\n(PREVIEW ONLY — FINAL=1 untuk menulis file SQL.)');
}