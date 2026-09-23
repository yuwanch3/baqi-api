// generate-txt.js — Ekspor 960 soal Petrofisika & CEOR ke file .txt (bukan JSON)
// Output: 12 file per bab + 1 file gabungan, di folder Downloads user.
const fs = require('fs');
const path = require('path');

const KUR = path.join(__dirname, 'kurikulum.json');
const SOAL = path.join(__dirname, 'output', 'soal_all.json');
const OUT_DIR = 'C:\\Users\\User\\Downloads';

const kurikulum = JSON.parse(fs.readFileSync(KUR, 'utf8'));
const semua = JSON.parse(fs.readFileSync(SOAL, 'utf8'));

// index grup soal berdasarkan (group, key)
const byKey = {};
for (const g of semua) byKey[g.group + '::' + g.key] = g;

const HURUF = ['A', 'B', 'C', 'D', 'E'];

// Cari label huruf untuk teks opsi (fallback: teks polos)
function labelOpsi(options, teks) {
  if (!Array.isArray(options)) return '';
  const i = options.findIndex(o => String(o).trim() === String(teks).trim());
  return i >= 0 ? HURUF[i] || '' : '';
}

// Format satu soal: pertanyaan + opsi + jawaban di bawah
function formatSoal(no, s) {
  const lines = [];
  lines.push(`Soal ${no}.`);
  lines.push(`${String(s.question || '').trim()}`);
  const opts = Array.isArray(s.options) ? s.options : [];
  opts.forEach((o, i) => {
    lines.push(`${HURUF[i] || '?'}. ${String(o).trim()}`);
  });
  // Jawaban
  let jwb = '';
  if (s.type === 'multi' && Array.isArray(s.correct_option)) {
    const parts = s.correct_option.map(t => {
      const L = labelOpsi(opts, t);
      return L ? `${L}. ${String(t).trim()}` : String(t).trim();
    });
    jwb = parts.join(' | ');
  } else {
    const t = String(s.correct_option || '').trim();
    const L = labelOpsi(opts, t);
    jwb = L ? `${L}. ${t}` : t;
  }
  lines.push(`Jawaban: ${jwb}`);
  lines.push('');
  return lines.join('\n');
}

function buatFileBab(bab) {
  const L = [];
  const nama = bab.nama;
  const line = '='.repeat(70);
  L.push(line);
  L.push(`BAB ${bab.no}: ${nama}`);
  L.push(line);
  L.push('');

  let counter = 0;

  // 1) Soal per materi
  for (const sub of bab.sub_bab) {
    for (const m of sub.materi) {
      const g = byKey['materi::' + m.id];
      if (!g || !g.soal) continue;
      counter++;
      L.push(`\n--- MATERI (${counter === 1 ? 1 : counter}) : ${m.topik} — ${g.soal.length} soal ---\n`);
      g.soal.forEach((s, i) => {
        L.push(formatSoal(i + 1, s));
      });
    }
  }

  // 2) Ujian Pelajaran per sub-bab
  for (const sub of bab.sub_bab) {
    const g = byKey['subexam::' + sub.id];
    if (!g || !g.soal) continue;
    L.push(`\n--- UJIAN PELAJARAN : ${g.nama} — ${g.soal.length} soal ---\n`);
    g.soal.forEach((s, i) => {
      L.push(formatSoal(i + 1, s));
    });
  }

  // 3) Final Test per bab
  const f = byKey['finex::' + bab.id];
  if (f && f.soal) {
    L.push(`\n--- FINAL TEST : ${f.nama} — ${f.soal.length} soal ---\n`);
    f.soal.forEach((s, i) => {
      L.push(formatSoal(i + 1, s));
    });
  }

  return L.join('\n');
}

if (!fs.existsSync(OUT_DIR)) fs.mkdirSync(OUT_DIR, { recursive: true });

let totalSoal = 0;
const semuaBagian = [];
for (const bab of kurikulum.bab) {
  const txt = buatFileBab(bab);
  const namaFile = `PetroCEOR_Bab${String(bab.no).padStart(2, '0')}.txt`;
  fs.writeFileSync(path.join(OUT_DIR, namaFile), txt, 'utf8');

  // hitung soal per bab dari grup
  let jml = 0;
  for (const sub of bab.sub_bab) {
    for (const m of sub.materi) jml += (byKey['materi::' + m.id]?.soal || []).length;
    jml += (byKey['subexam::' + sub.id]?.soal || []).length;
  }
  jml += (byKey['finex::' + bab.id]?.soal || []).length;
  totalSoal += jml;
  semuaBagian.push(`\n\n${txt}`);
  console.log(`${namaFile} -> ${jml} soal`);
}

// File gabungan semua bab
fs.writeFileSync(path.join(OUT_DIR, 'PetroCEOR_SEMUA_960Soal.txt'), semuaBagian.join(''), 'utf8');
console.log('PetroCEOR_SEMUA_960Soal.txt -> gabungan');
console.log(`\nTOTAL: ${totalSoal} soal di ${OUT_DIR}`);