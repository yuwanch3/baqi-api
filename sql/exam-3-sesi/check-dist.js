const fs=require('fs');
const files=fs.readdirSync('.').filter(f=>/^bab-\d+.*\.json$/.test(f)).sort();
let bad=0;
for(const f of files){
  const j=JSON.parse(fs.readFileSync(f,'utf8'));
  for(const k of ['inisialisasi','advanced']){
    const c={option:0,multi:0,drag:0,yesorno:0};
    j[k].forEach(q=>c[q.t]++);
    const tot=j[k].length;
    console.log(`${f} ${k}: total=${tot} | ${JSON.stringify(c)}`);
    const exp = k==='inisialisasi'?{option:7,multi:1,drag:1,yesorno:1}:{option:12,multi:4,drag:2,yesorno:2};
    if(JSON.stringify(c)!==JSON.stringify(exp)){ console.log('   !! TIDAK SESUAI target', JSON.stringify(exp)); bad++; }
  }
}
console.log(bad? 'ADA MASALAH: '+bad : 'SEMUA DISTRIBUSI SESUAI');
