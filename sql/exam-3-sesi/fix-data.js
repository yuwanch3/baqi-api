/**
 * Perbaikan data soal 3 sesi (Inisialisasi & Final Advanced)
 * ---------------------------------------------------------
 * 1. Semua teks dijadikan ASCII (DB final_exam memakai kolom latin1,
 *    karakter non-ASCII membuat json_encode gagal -> respons kosong,
 *    dan panjang serialize() tidak cocok -> options=false).
 * 2. Opsi jawaban tipe `option`/`multi` diacak (jawaban benar tidak selalu A).
 * 3. Soal tipe `drag`: jumlah opsi = jumlah slot + 1 (tambah 1 pengecoh).
 *
 * Jalankan: node fix-data.js
 */
const fs = require('fs');
const path = require('path');

const DIR = __dirname;

/* ---------- ASCII normalize ---------- */
function toAscii(s) {
  if (typeof s !== 'string') return s;
  let out = s
    // koreksi hasil penggantian lama yang salah (minus jadi x / kata terpotong)
    .replace(/\(Soi x Sor\) \/ Soi/g, '(Soi - Sor) / Soi')
    .replace(/\(Sor x Soi\) \/ Sor/g, '(Sor - Soi) / Sor')
    .replace(/kirxkira/g, 'kira-kira')
    .replace(/Î¼/g, 'mu')     // μ yang ter-encode ganda
    .replace(/Ã—/g, 'x')      // × yang ter-encode ganda
    .replace(/Â°/g, '°')
    .replace(/[µμ]m/g, 'um')  // µm -> um
    .replace(/³/g, '3')
    .replace(/²/g, '2')
    .replace(/¹/g, '1')
    .replace(/⁹/g, '9')
    .replace(/⁵/g, '5')
    .replace(/⁻/g, '-')
    .replace(/×/g, 'x')
    .replace(/°API/g, 'API')
    .replace(/°C/g, 'C')
    .replace(/°/g, 'deg')
    .replace(/µ/g, 'u')
    .replace(/μ/g, 'mu')
    .replace(/φ/g, ' phi ')
    .replace(/σ/g, ' sigma ')
    .replace(/θ/g, ' theta ')
    .replace(/Δ/g, ' delta ')
    .replace(/ρ/g, ' rho ')
    .replace(/—/g, '-')
    .replace(/–/g, '-');
  // rapikan spasi hasil penggantian simbol
  out = out
    .replace(/ {2,}/g, ' ')
    .replace(/\( /g, '(')
    .replace(/ \)/g, ')')
    .replace(/ ,/g, ',')
    .trim();
  const bad = [...out].filter(c => c.codePointAt(0) > 126);
  if (bad.length) throw new Error('masih ada karakter non-ASCII: ' + JSON.stringify(bad.join('')) + ' pada: ' + s);
  return out;
}

/* ---------- PRNG deterministik ---------- */
function hash(str) {
  let h = 2166136261;
  for (let i = 0; i < str.length; i++) {
    h ^= str.charCodeAt(i);
    h = Math.imul(h, 16777619);
  }
  return h >>> 0;
}
function mulberry32(a) {
  return function () {
    a |= 0; a = (a + 0x6D2B79F5) | 0;
    let t = Math.imul(a ^ (a >>> 15), 1 | a);
    t = (t + Math.imul(t ^ (t >>> 7), 61 | t)) ^ t;
    return ((t ^ (t >>> 14)) >>> 0) / 4294967296;
  };
}

/* ---------- pengecoh untuk soal drag (id, en) ---------- */
const DRAG_DISTRACTOR = {
  'bab-01-petrofisika.json|advanced|16': ['Autigenesis mineral lempung', 'Clay mineral authigenesis'],
  'bab-01-petrofisika.json|advanced|17': ['Rekahan (> 1 cm)', 'Fracture (> 1 cm)'],
  'bab-02-petrofisika.json|inisialisasi|8': ['Batuan dasar (bedrock)', 'Bedrock'],
  'bab-02-petrofisika.json|advanced|16': ['Pengukuran porositas dengan helium', 'Porosity measurement with helium'],
  'bab-02-petrofisika.json|advanced|17': ['Sangat tinggi (> 1 D)', 'Very high (> 1 D)'],
  'bab-03-petrofisika.json|inisialisasi|8': ['Kondensat (API > 45)', 'Condensate (API > 45)'],
  'bab-03-petrofisika.json|advanced|16': ['Gas terlarut kembali ke minyak (repressurization)', 'Dissolved gas returns to oil (repressurization)'],
  'bab-03-petrofisika.json|advanced|17': ['Batuan penutup (cap rock)', 'Cap rock'],
  'bab-04-petrofisika.json|inisialisasi|8': ['Formasi batubara (coal)', 'Coal formation'],
  'bab-04-petrofisika.json|advanced|16': ['Perforasi dan stimulasi sumur', 'Well perforation and stimulation'],
  'bab-04-petrofisika.json|advanced|17': ['Zona semen (cement annulus)', 'Cement annulus'],
  'bab-05-petrofisika.json|inisialisasi|8': ['Perforasi dan uji produksi', 'Perforation and production test'],
  'bab-05-petrofisika.json|advanced|16': ['Pengukuran laju alir sumur', 'Well flow rate measurement'],
  'bab-05-petrofisika.json|advanced|17': ['Sw negatif (-10%)', 'Negative Sw (-10%)'],
  'bab-06-petrofisika.json|inisialisasi|8': ['Injeksi surfaktan untuk menurunkan IFT', 'Surfactant injection to lower IFT'],
  'bab-06-petrofisika.json|advanced|16': ['Pengukuran permeabilitas absolut', 'Absolute permeability measurement'],
  'bab-06-petrofisika.json|advanced|17': ['Sw meningkat kembali (imbibisi)', 'Sw increases again (imbibition)'],
  'bab-07-petrofisika.json|inisialisasi|8': ['Perhitungan NPV dan IRR', 'NPV and IRR calculation'],
  'bab-07-petrofisika.json|advanced|16': ['Sumber daya kontingen (contingent resources)', 'Contingent resources'],
  'bab-07-petrofisika.json|advanced|17': ['Pembongkaran fasilitas (abandonment)', 'Facility decommissioning (abandonment)'],
  'bab-08-ceor.json|inisialisasi|8': ['Injeksi CO2 untuk penyimpanan (CCS)', 'CO2 injection for storage (CCS)'],
  'bab-08-ceor.json|advanced|16': ['Penutupan sumur dan abandonment', 'Well abandonment'],
  'bab-08-ceor.json|advanced|17': ['MEOR (microbial EOR)', 'MEOR (microbial EOR)'],
  'bab-09-ceor.json|inisialisasi|8': ['Pembakaran in-situ', 'In-situ combustion'],
  'bab-09-ceor.json|advanced|16': ['Analisis ekonomi proyek', 'Project economic analysis'],
  'bab-09-ceor.json|advanced|17': ['Penyuntikan bubuk polimer kering ke sumur', 'Dry polymer powder injection into the well'],
  'bab-10-ceor.json|inisialisasi|8': ['Slug busa (foam)', 'Foam slug'],
  'bab-10-ceor.json|advanced|16': ['Analisis ekonomi dan NPV', 'Economic and NPV analysis'],
  'bab-10-ceor.json|advanced|17': ['Winsor IV (mikroemulsi satu fasa)', 'Winsor IV (single-phase microemulsion)'],
  'bab-11-ceor.json|inisialisasi|8': ['Injeksi polimer', 'Polymer injection'],
  'bab-11-ceor.json|advanced|16': ['Zona air formasi', 'Formation water zone'],
  'bab-11-ceor.json|advanced|17': ['Injeksi surfaktan', 'Surfactant injection'],
  'bab-12-ceor.json|inisialisasi|8': ['Pembongkaran fasilitas', 'Facility decommissioning'],
  'bab-12-ceor.json|advanced|16': ['Perhitungan OOIP', 'OOIP calculation'],
  'bab-12-ceor.json|advanced|17': ['Abandonment dan reklamasi', 'Abandonment and reclamation']
};

const files = fs.readdirSync(DIR).filter(f => /^bab-\d+.*\.json$/.test(f)).sort();
let stat = { questions: 0, shuffled: 0, distractor: 0, ascii: 0 };

for (const file of files) {
  const p = path.join(DIR, file);
  const raw = JSON.parse(fs.readFileSync(p, 'utf8').replace(/^\uFEFF/, ''));
  const before = JSON.stringify(raw);

  for (const sec of ['inisialisasi', 'advanced']) {
    raw[sec].forEach((q, idx) => {
      stat.questions++;

      // 1) ASCII
      q.q = toAscii(q.q);
      q.qe = toAscii(q.qe);
      q.o = (q.o || []).map(toAscii);
      q.oe = (q.oe || []).map(toAscii);
      q.c = Array.isArray(q.c) ? q.c.map(toAscii) : toAscii(q.c);
      q.ce = Array.isArray(q.ce) ? q.ce.map(toAscii) : toAscii(q.ce);

      // 2) drag: pastikan jumlah opsi = slot + 1
      if (q.t === 'drag') {
        while (q.o.length < q.c.length + 1) {
          const key = `${file}|${sec}|${idx}`;
          const d = DRAG_DISTRACTOR[key];
          if (!d) throw new Error('pengecoh belum didefinisikan untuk ' + key);
          if (q.o.includes(d[0]) || q.c.includes(d[0])) throw new Error('pengecoh duplikat di ' + key);
          const rnd = mulberry32(hash(key + '|distractor'))();
          const pos = Math.floor(rnd * (q.o.length + 1));
          q.o.splice(pos, 0, d[0]);
          q.oe.splice(pos, 0, d[1]);
          stat.distractor++;
        }
      }

      // 3) acak opsi (option & multi), permutasi sama untuk o dan oe
      if ((q.t === 'option' || q.t === 'multi') && q.o.length > 1) {
        const order = q.o.map((_, i) => i);
        for (let i = order.length - 1; i > 0; i--) {
          const j = Math.floor(Math.random() * (i + 1));
          [order[i], order[j]] = [order[j], order[i]];
        }
        // (pengacakan murni / uniform: posisi jawaban benar tersebar merata)
        q.o = order.map(i => q.o[i]);
        q.oe = order.map(i => q.oe[i]);
        stat.shuffled++;
      }
    });
  }

  if (JSON.stringify(raw) !== before) {
    fs.writeFileSync(p, JSON.stringify(raw, null, 2) + '\n', 'utf8');
    stat.ascii++;
  }
  console.log('processed', file);
}

console.log('\n=== RINGKASAN ===');
console.log(stat);
