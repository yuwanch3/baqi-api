// ============================================
// shuffle-opsi-l6.js — Acak posisi opsi (kunci jawaban) 280 soal non-drag Level 6
// (soal tipe 'drag' 40 soal SKIP: posisi opsi tetap urutan naskah, tidak di-UPDATE)
// Mirip petro/shuffle-keys.js:
//   - HANYA mengubah urutan kolom options & options_en.
//   - correct_option / correct_option_en TIDAK diubah (teks jawaban benar
//     tetap sama, hanya berpindah posisi — jadi hasil jawab tidak berubah).
//   - option & multi: permutasi 4 posisi [0..3].
//   - yesorno: permutasi 2 posisi [0,1] (Yes/No) supaya tidak semua di A.
//   - PRNG deterministik mulberry32; seed dipilih agar distribusi posisi kunci
//     "merata": option+multi ~25% per A/B/C/D; yesorno ~50/50 per index 0/1.
// Output (Path A, 100% ASCII):
//   - output/l6/zz_shuffle_opsi_level6_v1.sql  -> UPDATE per id (import phpMyAdmin)
//   - output/l6/rows.json                      -> manifest diperbarui agar verify-l6
//                                                 (local & api) tetap cocok dgn DB.
// Run: node l6/shuffle-opsi-l6.js
// ============================================
const fs = require('fs');
const path = require('path');

const DIR = path.join(__dirname, 'output', 'l6');
const MANIFEST = path.join(DIR, 'rows.json');
const OUT = path.join(DIR, 'zz_shuffle_opsi_level6_v1.sql');

// ---- helpers identik generate-l6.js (Path A) ----
const cp1252dec = new TextDecoder('windows-1252');
const byteToChar = new Map();
for (let b = 0; b < 256; b++) byteToChar.set(b, cp1252dec.decode(Uint8Array.of(b)));
const charToByte = new Map();
for (let b = 0; b < 256; b++) charToByte.set(byteToChar.get(b), b);
const toM = (s) => cp1252dec.decode(Buffer.from(s, 'utf8'));
const hexM = (s) => Buffer.from(toM(s), 'utf8').toString('hex');
const phpser = (arr) => 'a:' + arr.length + ':{' + arr.map((s, i) => `i:${i};s:${Buffer.byteLength(s, 'utf8')}:"${s}"`).join(';') + ';}';
const norm = (s) => String(s).trim().toLowerCase();

// PRNG deterministik (mulberry32)
function mulberry32(a) {
  return function () {
    a |= 0; a = (a + 0x6D2B79F5) | 0;
    let t = Math.imul(a ^ (a >>> 15), 1 | a);
    t = (t + Math.imul(t ^ (t >>> 7), 61 | t)) ^ t;
    return ((t ^ (t >>> 14)) >>> 0) / 4294967296;
  };
}
function shuffleArr(arr, rnd) {
  for (let i = arr.length - 1; i > 0; i--) {
    const j = Math.floor(rnd() * (i + 1));
    [arr[i], arr[j]] = [arr[j], arr[i]];
  }
  return arr;
}

// ---- muat manifest (sumber kebenaran saat ini) ----
const manifest = JSON.parse(fs.readFileSync(MANIFEST, 'utf8'));
const soal = manifest.soal;
if (soal.length !== 320) throw new Error('Manifest soal harus 320, dapat ' + soal.length);

// kunci tiap soal: teks-teks jawaban benar dalam urutan database (opts)
function kunciTeks(s) {
  const arr = Array.isArray(s.corr) ? s.corr : [s.corr];
  return arr;
}
function posKunci(s, perm) {
  // posisi baru tiap teks kunci (kurang-lebih: perm menyatakan kemana index lama pindah:
  // perm[i] = posisi baru utk index lama i -> posisi baru = perm.indexOf(i))
  return kunciTeks(s).map((t) => {
    let i = s.opts.findIndex((o) => String(o) === String(t));
    if (i < 0) i = s.opts.findIndex((o) => norm(o) === norm(t));
    return { i, k: i >= 0 ? perm.indexOf(i) : -1 };
  });
}

// hitung distribusi utk sebuah seed (mengikuti alur pembangkitan yang sama dgn generator)
function hitungDistribusi(seed) {
  const rnd = mulberry32(seed);
  const c4 = { 0: 0, 1: 0, 2: 0, 3: 0 };
  const c2 = { 0: 0, 1: 0 };
  for (const s of soal) {
    if (s.t === 'yesorno') {
      const perm = shuffleArr([0, 1].slice(), rnd);
      for (const pk of posKunci(s, perm)) if (pk.k >= 0) c2[pk.k]++;
    } else {
      const perm = shuffleArr([0, 1, 2, 3].slice(), rnd);
      for (const pk of posKunci(s, perm)) if (pk.k >= 0) c4[pk.k]++;
    }
  }
  const t4 = Object.values(c4).reduce((a, b) => a + b, 0);
  const t2 = Object.values(c2).reduce((a, b) => a + b, 0);
  return { c4, c2, t4, t2, p4: Object.values(c4).map((c) => +(c / t4 * 100).toFixed(1)), p2: Object.values(c2).map((c) => +(c / t2 * 100).toFixed(1)) };
}

// ---- cari seed dgn distribusi merata ----
let bestSeed = 1, bestScore = Infinity, best = null;
for (let seed = 1; seed <= 20000; seed++) {
  const d = hitungDistribusi(seed);
  const score = d.p4.reduce((a, x) => a + Math.abs(x - 25), 0) + d.p2.reduce((a, x) => a + Math.abs(x - 50), 0);
  if (score < bestScore) { bestScore = score; bestSeed = seed; best = d; }
}
console.log('Seed terpilih :', bestSeed);
console.log('Distribusi klunci option+multi (n=' + best.t4 + '): A=' + best.p4[0] + '% B=' + best.p4[1] + '% C=' + best.p4[2] + '% D=' + best.p4[3] + '%');
console.log('Distribusi klunci yesorno    (n=' + best.t2 + '): idx0(A)=' + best.p2[0] + '% idx1(B)=' + best.p2[1] + '%');

// ---- generate UPDATE SQL dgn seed terpilih ----
const rnd = mulberry32(bestSeed);
let sql = '';
const newSoal = [];
let problems = [];
for (const s of soal) {
  if (s.t === 'drag') { newSoal.push(s); continue; }  // drag: posisi opsi tetap (tidak diacak, tidak di-UPDATE)
  const perm = s.t === 'yesorno' ? shuffleArr([0, 1].slice(), rnd) : shuffleArr([0, 1, 2, 3].slice(), rnd);
  const optBaru = perm.map((i) => s.opts[i]);
  const optEnBaru = perm.map((i) => s.optsE[i]);
  // validasi: semua teks kunci tetap ada di opsi baru, tanpa duplikat
  for (const t of kunciTeks(s)) {
    if (!optBaru.some((o) => String(o) === String(t) || norm(o) === norm(t))) problems.push(s.id + ': kunci hilang setelah acak');
  }
  for (const [k, arr] of [['options', optBaru], ['options_en', optEnBaru]]) {
    const set = arr.map(norm);
    if (new Set(set).size !== set.length) problems.push(s.id + ': duplikat di ' + k + ' setelah acak');
  }
  const optsH = 'CONVERT(0x' + hexM(phpser(optBaru)) + ' USING utf8mb4)';
  const optsEH = 'CONVERT(0x' + hexM(phpser(optEnBaru)) + ' USING utf8mb4)';
  sql += `UPDATE soal SET options=${optsH}, options_en=${optsEH} WHERE id='${s.id}';\n`;
  newSoal.push({ ...s, opts: optBaru, optsE: optEnBaru });
}

const head = `-- ============================================
-- SHUFFLE OPSI LEVEL 6 (280 soal non-drag; 40 soal drag TIDAK di-shuffle)
-- HANYA mengubah urutan kolom options & options_en (correct_option/correct_option_en
-- TIDAK berubah: teks jawaban benar tetap sama, hanya berpindah posisi opsi).
-- Distribusi posisi klunci SETELAH acak (seed ${bestSeed}):
--   option+multi (n=${best.t4}): A=${best.p4[0]}% B=${best.p4[1]}% C=${best.p4[2]}% D=${best.p4[3]}%
--   yesorno      (n=${best.t2}): index0(A)=${best.p2[0]}% index1(B)=${best.p2[1]}%
-- Patuh Path A: opsi ber-Arab di-encode HEX (CONVERT 0x.. USING utf8mb4), file 100% ASCII.
-- CARA IMPORT: phpMyAdmin -> tab Import -> pilih file ini (target DB = DB app).
-- ============================================

SET NAMES utf8mb4;

`;

fs.writeFileSync(OUT, head + sql);
fs.writeFileSync(MANIFEST, JSON.stringify({ ...manifest, soal: newSoal }, null, 1), 'utf8');

// ---- verifikasi: file 100% ASCII ----
let na = 0;
for (const c of fs.readFileSync(OUT)) if (c > 127) na++;
console.log('\nFile ditulis :', OUT);
console.log('Non-ASCII    :', na === 0 ? '0 \u2713 (ASCII murni)' : 'ADA ' + na);

// ---- ringkasan tipe & distribusi akhir (dari array hasil shuffle: newSoal) ----
const types = {};
for (const s of newSoal) types[s.t] = (types[s.t] || 0) + 1;
const total = newSoal.length;
console.log('\n=== TIPE SOAL LEVEL 6 (n=' + total + ') ===');
for (const [t, c] of Object.entries(types)) console.log('  ' + t.padEnd(8) + c.toString().padStart(4) + ' (' + (c / total * 100).toFixed(1) + '%)');

const optSoal = newSoal.filter((x) => x.t !== 'yesorno');
const ynSoal = newSoal.filter((x) => x.t === 'yesorno');
const pos = { 0: 0, 1: 0, 2: 0, 3: 0 };
for (const s of optSoal) {
  for (const t of kunciTeks(s)) {
    let i = s.opts.findIndex((o) => String(o) === String(t));
    if (i < 0) i = s.opts.findIndex((o) => norm(o) === norm(t));
    if (i >= 0) pos[i]++;
  }
}
const nOpt = Object.values(pos).reduce((a, b) => a + b, 0);
console.log('\n=== POSISI KUNCI SETELAH ACAK (seperti tampil di app) ===');
console.log('  option+multi (' + nOpt + ' klunci): A=' + (pos[0] / nOpt * 100).toFixed(1) + '% B=' + (pos[1] / nOpt * 100).toFixed(1) + '% C=' + (pos[2] / nOpt * 100).toFixed(1) + '% D=' + (pos[3] / nOpt * 100).toFixed(1) + '%');
const yCount = { 0: 0, 1: 0 };
for (const s of ynSoal) {
  const t = String(s.corr);
  let i = s.opts.findIndex((o) => String(o) === t);
  if (i < 0) i = s.opts.findIndex((o) => norm(o) === norm(t));
  if (i >= 0) yCount[i]++;
}
console.log('  yesorno (' + ynSoal.length + '): Posisi A=' + (yCount[0] / ynSoal.length * 100).toFixed(1) + '% Posisi B=' + (yCount[1] / ynSoal.length * 100).toFixed(1) + '%  |  isi teks Yes=' + ynSoal.filter((s) => String(s.corr) === 'Yes').length + ' No=' + ynSoal.filter((s) => String(s.corr) === 'No').length);

console.log('\nMasalah:', problems.length ? '\n  ' + problems.join('\n  ') : '0 \u2713');