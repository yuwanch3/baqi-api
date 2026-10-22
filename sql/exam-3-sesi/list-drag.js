const fs = require('fs');
const path = require('path');
const dir = __dirname;
const files = fs.readdirSync(dir).filter(f => /^bab-.*\.json$/.test(f)).sort();
let n = 0;
for (const f of files) {
  const d = JSON.parse(fs.readFileSync(path.join(dir, f), 'utf8').replace(/^\uFEFF/, ''));
  for (const sec of ['inisialisasi', 'advanced']) {
    d[sec].forEach((q, i) => {
      if (q.t !== 'drag') return;
      n++;
      console.log(`--- ${f} | ${sec} | idx ${i} | blanks=${q.c.length} opts=${q.o.length}`);
      console.log('Q :', q.q);
      console.log('QE:', q.qe);
      console.log('SEQ ID:', q.c.join(' -> '));
      console.log('SEQ EN:', q.ce.join(' -> '));
      console.log('OPTS ID:', q.o.join(' | '));
    });
  }
}
console.log('TOTAL DRAG', n);
