const fs=require('fs');
const files=fs.readdirSync('.').filter(f=>/^bab-\d+.*\.json$/.test(f)).sort();
let maxQ=0, maxQe=0, maxOpt=0, maxCe=0, maxItem=0, worstQ='';
for(const f of files){
  const j=JSON.parse(fs.readFileSync(f,'utf8'));
  for(const k of ['inisialisasi','advanced']){
    for(const q of j[k]){
      maxQ=Math.max(maxQ,q.q.length); if(q.q.length>maxQ-0){} 
      if(q.q.length>=maxQ){worstQ=q.q;}
      maxQe=Math.max(maxQe,q.qe.length);
      q.o.forEach(o=>maxOpt=Math.max(maxOpt,o.length));
      const cArr = Array.isArray(q.c)?q.c:[q.c];
      cArr.forEach(c=>maxCe=Math.max(maxCe,String(c).length));
    }
  }
}
console.log('max panjang question (varchar 300) :', maxQ);
console.log('max panjang question_en            :', maxQe);
console.log('max panjang satu opsi              :', maxOpt);
console.log('max panjang jawaban                :', maxCe);
console.log('contoh terpanjang:', worstQ);
