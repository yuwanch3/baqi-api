// Validasi output generate.js sebelum dibangun ke SQL.
// Pemakaian: node validate.js [output/soal_all.json]
const fs = require('fs');
const path = require('path');

const file = process.argv[2] || path.join(__dirname, 'output', 'soal_all.json');
if (!fs.existsSync(file)) { console.error('File tidak ada:', file); process.exit(1); }

const data = JSON.parse(fs.readFileSync(file, 'utf8'));
if (!Array.isArray(data)) { console.error('Bukan array!'); process.exit(1); }

const total = { materi: 0, subexam: 0, finex: 0 };
const masalah = [];
let ok = 0;

for (const g of data) {
  const key = g.key, group = g.group;
  const list = g.soal || [];
  total[group] = (total[group] || 0) + list.length;
  for (const s of list) {
    ok++;
    if (typeof s.question !== 'string' || !s.question.trim()) masalah.push(`${group}:${key}: question kosong`);
    if (typeof s.question_en !== 'string' || !s.question_en.trim()) masalah.push(`${group}:${key}: question_en kosong`);
    if (s.type !== 'option' && s.type !== 'multi') masalah.push(`${group}:${key}: type aneh '${s.type}'`);
    if (!Array.isArray(s.options) || s.options.length < 2) masalah.push(`${group}:${key}: options kurang (${s.options?.length})`);
    if (!Array.isArray(s.options_en) || s.options_en.length !== (s.options || []).length) masalah.push(`${group}:${key}: options_en jumlah beda`);
    if (s.type === 'multi') {
      if (!Array.isArray(s.correct_option) || s.correct_option.length < 1) masalah.push(`${group}:${key}: correct_option multi kosong`);
    } else {
      if (!s.correct_option || typeof s.correct_option !== 'string') masalah.push(`${group}:${key}: correct_option option bukan string`);
    }
    // correct_option_en untuk multi boleh kosong? cek kesamaan jumlah bila ada
    if (s.type === 'multi' && Array.isArray(s.correct_option_en) && s.correct_option_en.length !== s.correct_option.length) masalah.push(`${group}:${key}: correct_option_en beda jumlah`);
  }
}

console.log(`Grup: materi=${total.materi} subexam=${total.subexam} finex=${total.finex} total=${ok}`);
// Target: materi=72*5=360, subexam=36*10=360, finex=12*20=240 => 960
console.log(`Target: 360 / 360 / 240 -> 960`);
for (const grp of ['materi','subexam','finex']) {
  const want = grp === 'materi' ? 360 : grp === 'subexam' ? 360 : 240;
  console.log(`  ${grp}: ${total[grp]} ${total[grp] === want ? 'OK' : `!= ${want} MISSING`}`);
}
if (masalah.length) {
  console.log(`\n${masalah.length} MASALAH:`);
  for (const m of masalah.slice(0, 50)) console.log(' -', m);
  if (masalah.length > 50) console.log(`  ... dan ${masalah.length - 50} lainnya`);
} else {
  console.log('\nSemua soal lolos cek format dasar ✅');
}