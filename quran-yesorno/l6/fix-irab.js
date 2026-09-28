// Perbaikan kecil: teks Q2/Q3 Gr25a (content-s5.js) mengandung backslash hasil typo.
const fs = require('fs');
const p = require('path').join(__dirname, 'content-s5.js');
let s = fs.readFileSync(p, 'utf8');
const re = /menjadikan (mubtada \(ism\)|khabar) beri(\\{1,4})'/g;
const n = (s.match(re) || []).length;
s = s.replace(re, 'menjadikan $1 dalam keadaan');
fs.writeFileSync(p, s, 'utf8');
console.log('Diganti:', n);