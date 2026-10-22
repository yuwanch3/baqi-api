const fs = require('fs');
const path = require('path');
const dir = __dirname;
const files = fs.readdirSync(dir).filter(f => /^bab-.*\.json$/.test(f)).sort();
const map = new Map();
function scan(s, where) {
  if (typeof s !== 'string') return;
  for (const ch of s) {
    const cp = ch.codePointAt(0);
    if (cp > 126) {
      if (!map.has(ch)) map.set(ch, { cp, count: 0, samples: [] });
      const e = map.get(ch);
      e.count++;
      if (e.samples.length < 4) e.samples.push(where + ': ' + s.slice(0, 90));
    }
  }
}
for (const f of files) {
  const d = JSON.parse(fs.readFileSync(path.join(dir, f), 'utf8').replace(/^\uFEFF/, ''));
  for (const sec of ['inisialisasi', 'advanced']) {
    d[sec].forEach((q, i) => {
      const w = `${f}/${sec}/${i}`;
      scan(q.q, w); scan(q.qe, w);
      (q.o || []).forEach(x => scan(x, w));
      (q.oe || []).forEach(x => scan(x, w));
      if (typeof q.c === 'string') scan(q.c, w); else (q.c || []).forEach(x => scan(x, w));
      if (typeof q.ce === 'string') scan(q.ce, w); else (q.ce || []).forEach(x => scan(x, w));
    });
  }
}
const rows = [...map.entries()].sort((a, b) => b[1].count - a[1].count);
for (const [ch, e] of rows) {
  console.log(`'${ch}' U+${e.cp.toString(16).toUpperCase().padStart(4, '0')} count=${e.count}`);
  e.samples.forEach(s => console.log('    ' + s));
}
console.log('distinct non-ascii chars:', rows.length);
