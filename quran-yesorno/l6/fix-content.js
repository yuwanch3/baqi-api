// Fix + scan konten L6 (s1..s4). Jalankan: node l6/fix-content.js
// 1) hapus \" (kutip ganda ter-escape) pada teks soal -> mengikuti pola DB (tanpa kutip ganda)
// 2) perbaiki \\' -> \' (escape apostrof yang benar)
// 3) require ulang + scan validasi struktur (safeChar, duplikat, jumlah opsi, counts)
const fs = require('fs');
const path = require('path');

const files = ['content-s1.js', 'content-s2.js', 'content-s3.js', 'content-s4.js', 'content-s5.js'];

for (const f of files) {
  const p = 'l6/' + f;
  let s = fs.readFileSync(p, 'utf8');
  const o = s;
  // 1) hapus \"  (file berisi backslash + doublequote)
  s = s.split('\\"').join('');
  // 2) \\' -> \'   (file berisi 2 backslash + apostrophe -> 1 backslash + apostrophe)
  s = s.split("\\\\'").join("\\'");
  // 3) hapus sisa kutip ganda polos (pola DB: teks soal tanpa kutip ganda)
  s = s.replace(/"/g, '');
  if (s !== o) fs.writeFileSync(p, s, 'utf8');
  // cek sisa: dua backslash berurutan
  const re = s.match(/\\\\/g);
  if (re) console.log(f, 'SISA DOUBLE BACKSLASH:', re.length);
}

const safeChar = (ch) => ch < '\x80' || /[\u0600-\u06FF\u061C\u061F]/.test(ch) || /[\u0640-\u0652\u0670\u06D6-\u06ED]/.test(ch);
const allSafe = (s) => [...String(s)].every(safeChar);

const problems = [];
const mods = [];
for (const f of files) {
  let m;
  try { m = require(path.join(__dirname, f.replace('.js', ''))); }
  catch (e) { problems.push(f + ': SYNTAX ERROR ' + e.message.split('\n')[0]); continue; }
  m.forEach((mat, i) => {
    const tag = f + '#' + (i + 1) + '[' + mat.type + ']';
    const nSoal = mat.soal.length;
    if (mat.type === 'quran' && nSoal !== 6) problems.push(tag + ': quran harus 6 soal, ada ' + nSoal);
    if (mat.type === 'grammar' && nSoal !== 8) problems.push(tag + ': grammar harus 8 soal, ada ' + nSoal);
    if (mat.type === 'quran' && !mat.range) problems.push(tag + ': quran wajib punya range');
    const nOpt = mat.soal.filter((x) => x.t === 'option').length;
    const nMulti = mat.soal.filter((x) => x.t === 'multi').length;
    const nYn = mat.soal.filter((x) => x.t === 'yesorno').length;
    if (mat.type === 'quran' && (nOpt !== 5 || nYn !== 1)) problems.push(tag + ': quran 5 option+1 yesorno, dpt ' + nOpt + '+' + nYn);
    if (mat.type === 'grammar' && (nOpt + nMulti + nYn !== 8)) problems.push(tag + ': grammar total soal != 8 (' + nOpt + ' op + ' + nMulti + ' multi + ' + nYn + ' yesorno)');
    mat.soal.forEach((x, qi) => {
      const qtag = tag + ' Q' + (qi + 1);
      if (!x.q.trim() || !x.qe.trim()) problems.push(qtag + ': teks kosong');
      for (const s of [x.q, x.qe, mat.title || '', mat.range || '']) {
        if (/["\\]/.test(s)) problems.push(qtag + ': kutip ganda/backslash di teks');
        if (!allSafe(s)) problems.push(qtag + ': non-ASCII non-Arab di teks -> ' + JSON.stringify([...s].find((c) => !safeChar(c))));
      }
      if (x.t === 'yesorno') {
        if (x.opts.join(',') !== 'Yes,No') problems.push(qtag + ': yesorno options != Yes,No');
      } else {
        for (const k of ['opts', 'optsE']) {
          if (!Array.isArray(x[k]) || x[k].length < 4) problems.push(qtag + ': ' + k + ' < 4 opsi');
          const set = x[k].map((s) => String(s).trim().toLowerCase());
          if (new Set(set).size !== set.length) problems.push(qtag + ': duplikat di ' + k);
          for (const s of x[k]) {
            if (/["\\]/.test(s)) problems.push(qtag + ': kutip ganda/backslash di opsi ' + k);
            if (!allSafe(s)) problems.push(qtag + ': non-ASCII non-Arab di ' + k + ' -> ' + JSON.stringify([...s].find((c) => !safeChar(c))));
          }
        }
        const c = Array.isArray(x.corr) ? x.corr : [x.corr];
        const ce = Array.isArray(x.corrE) ? x.corrE : [x.corrE];
        const oi = x.opts.map((s) => String(s).trim().toLowerCase());
        const oei = x.optsE.map((s) => String(s).trim().toLowerCase());
        if (!c.length || c.some((s) => !oi.includes(String(s).trim().toLowerCase()))) problems.push(qtag + ': corr ID tidak ada di opts');
        if (!ce.length || ce.some((s) => !oei.includes(String(s).trim().toLowerCase()))) problems.push(qtag + ': corr EN tidak ada di optsE');
        if (x.t === 'multi' && c.length < 2) problems.push(qtag + ': multi tapi 1 benar');
      }
    });
  });
  mods.push(f);
}
console.log('Dimuat:', mods.join(', '));
console.log('Masalah:', problems.length ? '\n  ' + problems.join('\n  ') : '0 ^');