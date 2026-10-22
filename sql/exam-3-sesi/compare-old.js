const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');

const dir = __dirname;
const files = fs.readdirSync(dir).filter(f => /^bab-\d+.*\.json$/.test(f)).sort();

function show(rev, file) {
  return execSync(`git show ${rev}:sql/exam-3-sesi/${file}`, { cwd: path.join(dir, '..', '..'), encoding: 'utf8' });
}

for (const f of files) {
  let old;
  try { old = JSON.parse(show('17be009^', f).replace(/^\uFEFF/, '')); } catch (e) { console.log(f, 'SKIP', e.message.slice(0, 60)); continue; }
  const cur = JSON.parse(fs.readFileSync(path.join(dir, f), 'utf8'));
  for (const sec of ['inisialisasi', 'advanced']) {
    old[sec].forEach((oq, i) => {
      const cq = cur[sec][i];
      const fields = ['q', 'qe'];
      fields.forEach(k => {
        if (oq[k] !== cq[k]) console.log(`${f}/${sec}/${i} ${k}\n  OLD: ${oq[k]}\n  NEW: ${cq[k]}`);
      });
      ['o', 'oe'].forEach(k => {
        (oq[k] || []).forEach((v, j) => {
          if (!(cq[k] || []).includes(v)) console.log(`${f}/${sec}/${i} ${k}[${j}] hilang\n  OLD: ${v}`);
        });
      });
      const oc = Array.isArray(oq.c) ? oq.c : [oq.c];
      const cc = Array.isArray(cq.c) ? cq.c : [cq.c];
      oc.forEach(v => { if (!cc.includes(v)) console.log(`${f}/${sec}/${i} c hilang\n  OLD: ${v}`); });
    });
  }
}
