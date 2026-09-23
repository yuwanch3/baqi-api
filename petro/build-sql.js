// Builder SQL: mengubah output generate.js (JSON) + kurikulum.json menjadi
// file SQL INSERT siap-import di phpMyAdmin produksi.
//
// Pemakaian:
//   node build-sql.js [path-output-json] [path-kurikulum]
// Default: output/soal_all.json dan kurikulum.json
//
// Output file (di output/sql/):
//   01_levels.sql        -> INSERT INTO levels       (12 bab, PFC...)
//   02_sublevels.sql     -> INSERT INTO sub_levels   (36 sub-bab, PFS...)
//   03_materi.sql        -> INSERT INTO materi       (72 materi, PFM...)
//   04_soal_materi.sql   -> INSERT INTO soal         (ujian per materi, QST..., mid=PFM...)
//   05_final_subexam.sql -> INSERT INTO final_exam   (Ujian Pelajaran, FQT..., lid=PFS..., excerpt='Ujian Pelajaran')
//   06_final_finex.sql   -> INSERT INTO final_exam   (Final Test, FQT..., lid=PFC..., excerpt='Final Test')
//   00_gabungan.sql      -> seluruh INSERT di atas (urutan aman)
//
// Catatan kolom = skema produksi yang terverifikasi via API (ada kolom _en & updated).

const fs = require('fs');
const path = require('path');

const DIR = __dirname;
const OUT = path.join(DIR, 'output');
const SQL_DIR = path.join(OUT, 'sql');

const argJson = process.argv[2] || path.join(OUT, 'soal_all.json');
const argKur  = process.argv[3] || path.join(DIR, 'kurikulum.json');

const kurikulum = JSON.parse(fs.readFileSync(argKur, 'utf8'));
const dataSoal  = JSON.parse(fs.readFileSync(argJson, 'utf8'));

// ---------- Helpers ----------
const NOW = new Date().toISOString().slice(0, 19).replace('T', ' ');

function esc(v) {
  return String(v)
    .replace(/\\/g, '\\\\')
    .replace(/'/g, "''");
}

// PHP serialize() untuk array list bertipe string (cukup untuk options/correct_option)
function phpSerialize(arr) {
  const n = arr.length;
  let out = `a:${n}:{`;
  for (let i = 0; i < n; i++) {
    const s = String(arr[i]);
    out += `i:${i};s:${Buffer.byteLength(s, 'utf8')}:"${s}";`;
  }
  out += '}';
  return out;
}

// Build nilai kolom options / correct_option sesuai type
function optSer(options) { return phpSerialize(options); }
function corSer(type, correct) {
  return type === 'multi' ? phpSerialize(correct) : String(correct);
}
function corEnSer(type, correct_en) {
  if (type === 'multi') {
    return Array.isArray(correct_en) && correct_en.length ? phpSerialize(correct_en) : phpSerialize([]);
  }
  return String(correct_en || '');
}

// ---------- Mapping ----------
const babById = {};
const subById = {};
const materiById = {};
for (const bab of kurikulum.bab) {
  babById[bab.id] = bab;
  for (const sub of bab.sub_bab) {
    subById[sub.id] = sub;
    for (const m of sub.materi) materiById[m.id] = m;
  }
}

// Kumpulkan soal per grup dari output generate
const soalMateri = dataSoal.filter(g => g.group === 'materi');
const soalSubexam = dataSoal.filter(g => g.group === 'subexam');
const soalFinex = dataSoal.filter(g => g.group === 'finex');

function fmtErr(msg) { return `-- ${msg}\n`; }

let s01 = '', s02 = '', s03 = '', s04 = '', s05 = '', s06 = '';
let n04 = 0, n05 = 0, n06 = 0;

// Counter ID QST / FQT (hindari bentrok dengan produksi:
// QST/FQT produksi masih ratusan; mulai dari 9e9. MAX_SAFE_INTEGER aman.)
let qstNum = 9000000000;
let fqtNum = 9200000000;
const qstId = () => 'QST' + String(qstNum++).padStart(20, '0');
const fqtId = () => 'FQT' + String(fqtNum++).padStart(20, '0');

// ---------- 1. levels ----------
// CATATAN: tabel levels produksi TANPA kolom updated (terverifikasi via SELECT * fetch_object)
for (const bab of kurikulum.bab) {
  s01 += `INSERT INTO levels(id, name, backgroundColor, state_exam, final_exam_grammer, final_exam_quran, created) VALUES ('${esc(bab.id)}','${esc(bab.nama)}','${esc(bab.warna)}','yes','','','${NOW}');\n`;
}

// ---------- 2. sub_levels ----------
for (const bab of kurikulum.bab) {
  for (const sub of bab.sub_bab) {
    s02 += `INSERT INTO sub_levels(id, name, level, state_exam, ujian_grammer, ujian_pelajaran, backgroundColor, created, updated) VALUES ('${esc(sub.id)}','${esc(sub.nama)}','${esc(bab.nama)}','yes','','','${esc(sub.warna)}','${NOW}','${NOW}');\n`;
  }
}

// ---------- 3. materi ----------
for (const bab of kurikulum.bab) {
  for (const sub of bab.sub_bab) {
    for (const m of sub.materi) {
      s03 += `INSERT INTO materi(id, level, sub_levels, doc, doc_en, test, watch, information, information_en, description, state_exam, created, updated) VALUES ('${esc(m.id)}','${esc(bab.nama)}','${esc(sub.nama)}','','','','','${esc(m.topik)}','','','yes','${NOW}','${NOW}');\n`;
    }
  }
}

// ---------- 4. soal (ujian per materi) ----------
for (const g of soalMateri) {
  const mid = g.key; // PFM...
  if (!materiById[mid]) { s04 += fmtErr(`SKIP materi tidak dikenal: ${mid} (${g.nama})`); continue; }
  g.soal.forEach((s, idx) => {
    s04 += `INSERT INTO soal(id, question, type, mid, options, image, correct_option, question_en, options_en, correct_option_en, created, updated) VALUES (` +
      `'${esc(qstId())}','${esc(s.question)}','${esc(s.type)}','${esc(mid)}','${esc(optSer(s.options))}','','${esc(corSer(s.type, s.correct_option))}',` +
      `'${esc(s.question_en)}','${esc(optSer(s.options_en))}','${esc(corEnSer(s.type, s.correct_option_en))}','${NOW}','${NOW}');\n`;
    n04++;
  });
}

// ---------- 5. final_exam: Ujian Pelajaran (sub-bab) ----------
for (const g of soalSubexam) {
  const lid = g.key; // PFS...
  if (!subById[lid]) { s05 += fmtErr(`SKIP sub-bab tidak dikenal: ${lid} (${g.nama})`); continue; }
  g.soal.forEach((s, idx) => {
    s05 += `INSERT INTO final_exam(id, question, type, lid, excerpt, options, image, correct_option, question_en, options_en, correct_option_en, created, updated) VALUES (` +
      `'${esc(fqtId())}','${esc(s.question)}','${esc(s.type)}','${esc(lid)}','Ujian Pelajaran','${esc(optSer(s.options))}','','${esc(corSer(s.type, s.correct_option))}',` +
      `'${esc(s.question_en)}','${esc(optSer(s.options_en))}','${esc(corEnSer(s.type, s.correct_option_en))}','${NOW}','${NOW}');\n`;
    n05++;
  });
}

// ---------- 6. final_exam: Final Test (bab / finex) ----------
for (const g of soalFinex) {
  const lid = g.key; // PFC...
  if (!babById[lid]) { s06 += fmtErr(`SKIP bab tidak dikenal: ${lid} (${g.nama})`); continue; }
  g.soal.forEach((s, idx) => {
    s06 += `INSERT INTO final_exam(id, question, type, lid, excerpt, options, image, correct_option, question_en, options_en, correct_option_en, created, updated) VALUES (` +
      `'${esc(fqtId())}','${esc(s.question)}','${esc(s.type)}','${esc(lid)}','Final Test','${esc(optSer(s.options))}','','${esc(corSer(s.type, s.correct_option))}',` +
      `'${esc(s.question_en)}','${esc(optSer(s.options_en))}','${esc(corEnSer(s.type, s.correct_option_en))}','${NOW}','${NOW}');\n`;
    n06++;
  });
}

// ---------- Tulis file ----------
if (!fs.existsSync(SQL_DIR)) fs.mkdirSync(SQL_DIR, { recursive: true });

const head = (t) => `-- ============================================\n-- ${t}\n-- Dibuat: ${NOW}\n-- ============================================\n`;

fs.writeFileSync(path.join(SQL_DIR, '01_levels.sql'),        head('LEVELS (12 bab Petro/CEOR, prefix PFC)') + s01);
fs.writeFileSync(path.join(SQL_DIR, '02_sublevels.sql'),     head('SUB_LEVELS (36 sub-bab, prefix PFS)') + s02);
fs.writeFileSync(path.join(SQL_DIR, '03_materi.sql'),        head('MATERI (72 materi, prefix PFM, doc/test/watch kosong)') + s03);
fs.writeFileSync(path.join(SQL_DIR, '04_soal_materi.sql'),   head(`SOAL ujian per materi (${n04} soal, mid=PFM, prefix QST)`) + s04);
fs.writeFileSync(path.join(SQL_DIR, '05_final_subexam.sql'), head(`FINAL_EXAM Ujian Pelajaran per sub-bab (${n05} soal, lid=PFS, prefix FQT)`) + s05);
fs.writeFileSync(path.join(SQL_DIR, '06_final_finex.sql'),   head(`FINAL_EXAM Final Test per bab (${n06} soal, lid=PFC, prefix FQT)`) + s06);

const gab = head('GABUNGAN SEMUA INSERT') +
  '-- Urutan aman: levels -> sub_levels -> materi -> soal -> final_exam\n\n' +
  s01 + '\n' + s02 + '\n' + s03 + '\n' + s04 + '\n' + s05 + '\n' + s06;
fs.writeFileSync(path.join(SQL_DIR, '00_gabungan.sql'), gab);

console.log(`Sel ${n04} soal materi | ${n05} subexam | ${n06} finex`);
console.log('Ditulis ke:', SQL_DIR);