/**
 * Membuat file UPDATE untuk memperbaiki 360 soal 3 sesi (ID tidak berubah).
 * Jalankan setelah fix-data.js:  node gen-update.js
 */
const fs = require('fs');
const path = require('path');

const DIR = __dirname;
const OUT = path.join(DIR, 'output');
const ID_PREFIX = 'FQT000000000092';
let idCounter = 600;
const UPDATED = '2026-10-22 10:00:00';

function phpSerialize(value) {
  if (typeof value === 'string') return `s:${Buffer.byteLength(value, 'utf8')}:"${value}";`;
  if (Array.isArray(value)) {
    let s = `a:${value.length}:{`;
    value.forEach((v, i) => { s += `i:${i};` + phpSerialize(v); });
    return s + '}';
  }
  throw new Error('tipe tidak didukung: ' + typeof value);
}

function q(v) {
  return "'" + String(v).replace(/\\/g, '\\\\').replace(/'/g, "''") + "'";
}

function nextId() {
  const id = ID_PREFIX + String(idCounter).padStart(8, '0');
  idCounter++;
  return id;
}

function buildUpdate(item, lid, excerpt, id) {
  const isArrayAnswer = item.t === 'multi' || item.t === 'drag';
  const options = phpSerialize(item.o);
  const optionsEn = phpSerialize(item.oe);
  const correct = isArrayAnswer ? phpSerialize(item.c) : item.c;
  const correctEn = isArrayAnswer ? phpSerialize(item.ce) : item.ce;

  return 'UPDATE final_exam SET ' +
    [
      'question = ' + q(item.q),
      'question_en = ' + q(item.qe),
      'type = ' + q(item.t),
      'lid = ' + q(lid),
      'excerpt = ' + q(excerpt),
      'options = ' + q(options),
      'options_en = ' + q(optionsEn),
      'correct_option = ' + q(correct),
      'correct_option_en = ' + q(correctEn),
      'updated = ' + q(UPDATED)
    ].join(', ') +
    ' WHERE id = ' + q(id) + ';';
}

const SESI = { inisialisasi: 'Inisialisasi', advanced: 'Final Advanced' };
const files = fs.readdirSync(DIR).filter(f => /^bab-\d+.*\.json$/.test(f)).sort();

const out = [
  '-- =====================================================================',
  '-- PERBAIKAN SOAL UJIAN 3 SESI - PETROFISIKA & CEOR',
  '-- - teks ASCII (tanpa karakter yang merusak serialize/json di kolom latin1)',
  '-- - opsi jawaban tipe option/multi sudah diacak',
  '-- - soal drag: jumlah opsi = jumlah slot + 1',
  '-- ID soal TIDAK berubah (hanya isi baris yang di-update)',
  '-- =====================================================================',
  ''
];

let total = 0;
for (const file of files) {
  const raw = JSON.parse(fs.readFileSync(path.join(DIR, file), 'utf8'));
  out.push(`-- ${file} : ${raw.nama} (${raw.lid})`);
  for (const key of ['inisialisasi', 'advanced']) {
    raw[key].forEach(item => {
      const id = nextId();
      out.push(buildUpdate(item, raw.lid, SESI[key], id));
      total++;
    });
  }
  out.push('');
}

fs.writeFileSync(path.join(OUT, 'update-3-sesi.sql'), out.join('\n'), 'utf8');

/* ---- perbaikan 1 soal lama Final Test bab-02 (multi, options=false) ---- */
const oldRow = {
  t: 'multi',
  o: ['Laju alir (Q)', 'Tipe sementasi', 'Viskositas fluida (mu)', 'Panjang sampel (L)'],
  oe: ['Flow rate (Q)', 'Cementation type', 'Fluid viscosity (mu)', 'Sample length (L)'],
  c: ['Laju alir (Q)', 'Viskositas fluida (mu)', 'Panjang sampel (L)'],
  ce: ['Flow rate (Q)', 'Fluid viscosity (mu)', 'Sample length (L)']
};
const fixOld = [
  '-- =====================================================================',
  '-- Perbaikan 1 soal lama "Final Test" Bab 2 Petrofisika (multi)',
  '-- ID: FQT00000000009200000389 - sebelumnya options & correct_option = false',
  '-- (karakter mu tidak bisa disimpan di kolom latin1, panjang serialize rusak)',
  '-- =====================================================================',
  'UPDATE final_exam SET ' +
    [
      'options = ' + q(phpSerialize(oldRow.o)),
      'options_en = ' + q(phpSerialize(oldRow.oe)),
      'correct_option = ' + q(phpSerialize(oldRow.c)),
      'correct_option_en = ' + q(phpSerialize(oldRow.ce)),
      'updated = ' + q(UPDATED)
    ].join(', ') +
    " WHERE id = 'FQT00000000009200000389';",
  ''
].join('\n');
fs.writeFileSync(path.join(OUT, 'fix-final-test-bab02.sql'), fixOld, 'utf8');

/* ---- file gabungan: cukup import 1 file ---- */
fs.writeFileSync(
  path.join(OUT, 'import-perbaikan.sql'),
  ['-- =====================================================================',
   '-- IMPORT PERBAIKAN UJIAN 3 SESI (jalankan 1 file ini saja)',
   '-- 1) update 360 soal Inisialisasi + Final Advanced',
   '-- 2) perbaiki 1 soal lama Final Test Bab 2',
   '-- ID soal tidak berubah.',
   '-- =====================================================================',
   '',
   ...out,
   fixOld].join('\n'),
  'utf8'
);

console.log('update-3-sesi.sql     :', total, 'UPDATE');
console.log('fix-final-test-bab02  : 1 UPDATE');
console.log('import-perbaikan.sql  :', total + 1, 'UPDATE (gabungan)');
console.log('ID terakhir           :', ID_PREFIX + String(idCounter - 1).padStart(8, '0'));
