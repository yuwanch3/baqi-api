/**
 * Generator SQL soal ujian 3 sesi (Petrofisika & CEOR)
 * ------------------------------------------------------------------
 * Membaca file bab-*.json lalu menghasilkan INSERT ke tabel `final_exam`
 * dengan format kolom persis seperti data yang sudah ada di server:
 *   - options / options_en        : PHP serialize(array)
 *   - correct_option              : string biasa (option/yesorno),
 *                                   PHP serialize(array) untuk multi/drag
 *
 * Jalankan: node gen-sql.js
 */
const fs = require('fs');
const path = require('path');

const DIR = __dirname;
const OUT = path.join(DIR, 'output');

/* id soal lama berakhir di FQT00000000009200000599 -> mulai dari 600 */
const ID_PREFIX = 'FQT000000000092';
let idCounter = 600;

const SESI = {
  inisialisasi: 'Soal Inisialisasi',
  advanced: 'Final Test Advanced'
};

const CREATED = '2026-10-21 10:00:00';

/* ---------- PHP serialize ---------- */
function phpSerialize(value) {
  if (typeof value === 'string') {
    return `s:${Buffer.byteLength(value, 'utf8')}:"${value}";`;
  }
  if (Array.isArray(value)) {
    let s = `a:${value.length}:{`;
    value.forEach((v, i) => { s += `i:${i};` + phpSerialize(v); });
    return s + '}';
  }
  throw new Error('tipe tidak didukung: ' + typeof value);
}

/* ---------- PHP unserialize (untuk self-test) ---------- */
function phpUnserialize(input) {
  const buf = Buffer.from(input, 'utf8');
  let pos = 0;
  const matchAt = (re) => {
    const rest = buf.toString('utf8', pos);
    const m = re.exec(rest);
    if (!m) throw new Error('parse gagal di posisi ' + pos);
    pos += Buffer.byteLength(m[0], 'utf8');
    return m;
  };
  const readStr = (n) => {
    const s = buf.toString('utf8', pos, pos + n);
    pos += n;
    return s;
  };
  function read() {
    const t = String.fromCharCode(buf[pos]);
    if (t === 'a') {
      const m = matchAt(/^a:(\d+):\{/);
      const n = parseInt(m[1], 10);
      const out = [];
      for (let k = 0; k < n; k++) {
        matchAt(/^i:\d+;/);
        out.push(read());
      }
      matchAt(/^\}/);
      return out;
    }
    if (t === 's') {
      const m = matchAt(/^s:(\d+):"/);
      const val = readStr(parseInt(m[1], 10));
      matchAt(/^";/);
      return val;
    }
    throw new Error('token tidak dikenal: ' + t);
  }
  const v = read();
  if (pos !== buf.length) throw new Error('sisa karakter di posisi ' + pos);
  return v;
}

/* ---------- SQL escape ---------- */
function q(v) {
  return "'" + String(v).replace(/\\/g, '\\\\').replace(/'/g, "''") + "'";
}

function nextId() {
  const id = ID_PREFIX + String(idCounter).padStart(8, '0');
  idCounter++;
  return id;
}

function normalize(item, file, idx) {
  const jenis = item.t;
  if (!['option', 'multi', 'drag', 'yesorno'].includes(jenis)) {
    throw new Error(`${file} #${idx}: tipe "${jenis}" tidak dikenal`);
  }
  if (!item.q || !item.qe) throw new Error(`${file} #${idx}: q/qe kosong`);
  if (!Array.isArray(item.o) || !Array.isArray(item.oe)) {
    throw new Error(`${file} #${idx}: o/oe harus array`);
  }
  if (item.o.length !== item.oe.length) {
    throw new Error(`${file} #${idx}: jumlah o (${item.o.length}) != oe (${item.oe.length})`);
  }
  if (jenis === 'option' || jenis === 'yesorno') {
    if (typeof item.c !== 'string' || typeof item.ce !== 'string') {
      throw new Error(`${file} #${idx}: c/ce harus string`);
    }
    if (!item.o.includes(item.c)) throw new Error(`${file} #${idx}: jawaban "${item.c}" tidak ada di opsi`);
    if (!item.oe.includes(item.ce)) throw new Error(`${file} #${idx}: jawaban EN "${item.ce}" tidak ada di opsi EN`);
  } else {
    if (!Array.isArray(item.c) || !Array.isArray(item.ce)) {
      throw new Error(`${file} #${idx}: c/ce harus array`);
    }
    item.c.forEach(j => { if (!item.o.includes(j)) throw new Error(`${file} #${idx}: jawaban "${j}" tidak ada di opsi`); });
    item.ce.forEach(j => { if (!item.oe.includes(j)) throw new Error(`${file} #${idx}: jawaban EN "${j}" tidak ada di opsi EN`); });
    if (item.c.length !== item.ce.length) throw new Error(`${file} #${idx}: jumlah jawaban ID != EN`);
    if (jenis === 'drag' && item.c.length < 2) throw new Error(`${file} #${idx}: drag minimal 2 slot`);
  }
  return item;
}

function buildRow(item, lid, excerpt, id) {
  const isArrayAnswer = item.t === 'multi' || item.t === 'drag';
  const options = phpSerialize(item.o);
  const optionsEn = phpSerialize(item.oe);
  const correct = isArrayAnswer ? phpSerialize(item.c) : item.c;
  const correctEn = isArrayAnswer ? phpSerialize(item.ce) : item.ce;

  return 'INSERT INTO final_exam (id, question, question_en, type, lid, excerpt, options, options_en, image, correct_option, correct_option_en, created, updated) VALUES (' +
    [
      q(id), q(item.q), q(item.qe), q(item.t), q(lid), q(excerpt),
      q(options), q(optionsEn), q(''),
      q(correct), q(correctEn), q(CREATED), q(CREATED)
    ].join(', ') + ');';
}

/* ---------- main ---------- */
const files = fs.readdirSync(DIR).filter(f => /^bab-\d+.*\.json$/.test(f)).sort();
if (!files.length) {
  console.error('Tidak ada file bab-*.json');
  process.exit(1);
}

let semua = [];
let laporan = [];

for (const file of files) {
  const raw = JSON.parse(fs.readFileSync(path.join(DIR, file), 'utf8'));
  const rows = [];
  const perSesi = {};

  for (const key of ['inisialisasi', 'advanced']) {
    const list = raw[key];
    if (!Array.isArray(list)) throw new Error(`${file}: bagian "${key}" tidak ada`);
    perSesi[SESI[key]] = list.length;
    list.forEach((item, idx) => {
      const it = normalize(item, file + ':' + key, idx + 1);
      const id = nextId();
      rows.push({ id, sesi: SESI[key], sql: buildRow(it, raw.lid, SESI[key], id) });
    });
  }

  const sql = [
    `-- ${file} : ${raw.nama} (${raw.lid})`,
    ...rows.map(r => r.sql),
    ''
  ].join('\n');

  fs.writeFileSync(path.join(OUT, file.replace(/\.json$/, '.sql')), sql, 'utf8');
  semua.push(sql);
  laporan.push({ file, lid: raw.lid, nama: raw.nama, sesi: perSesi, total: rows.length, idAwal: rows[0].id, idAkhir: rows[rows.length - 1].id });
}

const header = [
  '-- =====================================================================',
  '-- SOAL UJIAN 3 SESI - PETROFISIKA & CEOR',
  `-- dibuat: ${new Date().toISOString()}`,
  '-- Tabel: final_exam (tanpa ALTER TABLE, tanpa menyentuh 20 soal Final Test lama)',
  '-- =====================================================================',
  ''
].join('\n');

fs.writeFileSync(path.join(OUT, 'insert-semua-bab.sql'), header + semua.join('\n'), 'utf8');

/* ---------- self-test serialisasi ---------- */
(function selfTest() {
  const samples = [
    ['Yes', 'No'],
    ['Ukuran butir', 'Pemilahan', 'Kebulatan', 'Salinitas'],
    ['Porositas "efektif" \\ 100% — uji', "Tanda 'kutip'"]
  ];
  samples.forEach(a => {
    const s = phpSerialize(a);
    const back = phpUnserialize(s);
    if (JSON.stringify(back) !== JSON.stringify(a)) throw new Error('self-test gagal: ' + s);
  });
  console.log('self-test serialisasi: OK');
})();

console.log('\n=== LAPORAN ===');
let total = 0;
laporan.forEach(l => {
  total += l.total;
  console.log(`${l.file} | ${l.lid} | ${l.sesi['Soal Inisialisasi']} + ${l.sesi['Final Test Advanced']} = ${l.total} | ${l.idAwal} .. ${l.idAkhir}`);
});
console.log('TOTAL SOAL BARU: ' + total);
console.log('ID terakhir    : ' + (ID_PREFIX + String(idCounter - 1).padStart(8, '0')));
