const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');

function toAscii(s) {
  if (typeof s !== 'string') return s;
  let out = s
    .replace(/Î¼/g, 'mu').replace(/Ã—/g, 'x').replace(/Â°/g, '°')
    .replace(/[µμ]m/g, 'um')
    .replace(/³/g, '3').replace(/²/g, '2').replace(/¹/g, '1')
    .replace(/⁹/g, '9').replace(/⁵/g, '5').replace(/⁻/g, '-')
    .replace(/×/g, 'x')
    .replace(/°API/g, 'API').replace(/°C/g, 'C').replace(/°/g, 'deg')
    .replace(/µ/g, 'u').replace(/μ/g, 'mu')
    .replace(/φ/g, ' phi ').replace(/σ/g, ' sigma ').replace(/θ/g, ' theta ')
    .replace(/Δ/g, ' delta ').replace(/ρ/g, ' rho ')
    .replace(/—/g, '-').replace(/–/g, '-');
  return out.replace(/ {2,}/g, ' ').replace(/\( /g, '(').replace(/ \)/g, ')').replace(/ ,/g, ',').trim();
}

const dir = __dirname;
const files = fs.readdirSync(dir).filter(f => /^bab-\d+.*\.json$/.test(f)).sort();

for (const f of files) {
  let old;
  try {
    old = JSON.parse(execSync('git show 17be009^:sql/exam-3-sesi/' + f, { cwd: path.join(dir, '..', '..'), encoding: 'utf8' }).replace(/^\uFEFF/, ''));
  } catch (e) { continue; }
  const cur = JSON.parse(fs.readFileSync(path.join(dir, f), 'utf8'));
  for (const sec of ['inisialisasi', 'advanced']) {
    old[sec].forEach((oq, i) => {
      const cq = cur[sec][i];
      (oq.o || []).forEach(v => {
        const nv = toAscii(v);
        if (!(cq.o || []).includes(nv)) console.log(`${f}/${sec}/${i} OPSI BERUBAH\n  OLD: ${v}\n  NEW-normal: ${nv}`);
      });
      const oc = Array.isArray(oq.c) ? oq.c : [oq.c];
      const cc = Array.isArray(cq.c) ? cq.c : [cq.c];
      oc.forEach(v => {
        const nv = toAscii(v);
        if (!cc.includes(nv)) console.log(`${f}/${sec}/${i} JAWABAN BERUBAH\n  OLD: ${v}\n  NEW-normal: ${nv}`);
      });
    });
  }
}
console.log('selesai');
