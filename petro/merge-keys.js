// Merge hasil generate ulang (--keys) ke output/soal_all.json.
// Pemakaian: node merge-keys.js [file-full] [file-keys]
// Default: output/soal_all.json + output/soal_all_keys.json
const fs = require('fs');
const path = require('path');

const fullFile = process.argv[2] || path.join(__dirname, 'output', 'soal_all.json');
const keysFile = process.argv[3] || path.join(__dirname, 'output', 'soal_all_keys.json');

const full = JSON.parse(fs.readFileSync(fullFile, 'utf8'));
const keys = JSON.parse(fs.readFileSync(keysFile, 'utf8'));

let ganti = 0;
for (const kg of keys) {
  const idx = full.findIndex(f => f.group === kg.group && f.key === kg.key);
  if (idx === -1) {
    console.log(`TAMBAH baru: ${kg.group} ${kg.key} (${kg.soal.length} soal)`);
    full.push(kg);
  } else {
    console.log(`GANTI: ${kg.group} ${kg.key} ${full[idx].soal.length} -> ${kg.soal.length} soal`);
    full[idx] = kg;
  }
  ganti++;
}

fs.writeFileSync(fullFile, JSON.stringify(full, null, 2), 'utf8');
const total = full.reduce((a, g) => a + g.jumlah, 0);
console.log(`\n${ganti} grup dimerge. Total ${full.length} grup, ${total} soal -> ${fullFile}`);