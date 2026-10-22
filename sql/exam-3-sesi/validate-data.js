const fs = require('fs');
const path = require('path');
const dir = __dirname;
const files = fs.readdirSync(dir).filter(f => /^bab-\d+.*\.json$/.test(f)).sort();

let errors = [];
let optTotal = 0, optAtA = 0, posCount = [0, 0, 0, 0, 0, 0];
let multiTotal = 0, dragTotal = 0;
let nonAscii = 0;

for (const f of files) {
  const d = JSON.parse(fs.readFileSync(path.join(dir, f), 'utf8'));
  for (const sec of ['inisialisasi', 'advanced']) {
    const dist = {};
    for (const q of d[sec]) {
      dist[q.t] = (dist[q.t] || 0) + 1;
      for (const s of [q.q, q.qe, ...q.o, ...q.oe, ...(Array.isArray(q.c) ? q.c : [q.c]), ...(Array.isArray(q.ce) ? q.ce : [q.ce])]) {
        if ([...String(s)].some(c => c.codePointAt(0) > 126)) { nonAscii++; errors.push(`${f}/${sec} non-ascii: ${s}`); }
      }
      if (q.t === 'option') {
        optTotal++;
        const i = q.o.indexOf(q.c);
        if (i < 0) errors.push(`${f}/${sec} jawaban tidak ada di opsi: ${q.q.slice(0, 40)}`);
        if (i === 0) optAtA++;
        if (i >= 0 && i < posCount.length) posCount[i]++;
      }
      if (q.t === 'multi') {
        multiTotal++;
        for (const c of q.c) if (!q.o.includes(c)) errors.push(`${f}/${sec} multi jawaban tidak ada di opsi`);
        if (q.o.length !== q.oe.length) errors.push(`${f}/${sec} multi o/oe beda panjang`);
      }
      if (q.t === 'drag') {
        dragTotal++;
        if (q.o.length !== q.c.length + 1) errors.push(`${f}/${sec} drag opts=${q.o.length} blanks=${q.c.length}`);
        for (const c of q.c) if (!q.o.includes(c)) errors.push(`${f}/${sec} drag jawaban tidak ada di opsi`);
        if (q.o.length !== new Set(q.o).size) errors.push(`${f}/${sec} drag opsi duplikat`);
      }
      if (q.o.length !== q.oe.length) errors.push(`${f}/${sec} jumlah o (${q.o.length}) != oe (${q.oe.length})`);
    }
    console.log(`${f} ${sec}: total=${d[sec].length} ${JSON.stringify(dist)}`);
    if (sec === 'inisialisasi' && d[sec].length !== 10) errors.push(`${f} inisialisasi != 10`);
    if (sec === 'advanced' && d[sec].length !== 20) errors.push(`${f} advanced != 20`);
  }
}
console.log('\noption total', optTotal, '| jawaban di posisi A:', optAtA, '| distribusi posisi:', posCount);
console.log('multi total', multiTotal, '| drag total', dragTotal);
console.log('non-ascii chars:', nonAscii);
console.log(errors.length ? '\nERRORS:\n' + errors.join('\n') : '\nSEMUA VALIDASI LULUS');
