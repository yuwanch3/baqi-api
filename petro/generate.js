// Generator soal Petrofisika & CEOR untuk Baqi Apps.
// Membaca kurikulum.json, meminta Gemini menghasilkan soal format Baqi
// (type option/multi, Bahasa Indonesia, tanpa huruf jawaban, dengan kolom _en),
// lalu menulis output JSON siap konversi ke SQL.
//
// Pemakaian:
//   node generate.js --scope=bab --bab=1        # hanya satu bab (sample)
//   node generate.js --scope=all                # semua 12 bab
//   node generate.js --scope=materi --bab=1,2   # hanya ujian per materi untuk bab tsb
//   node generate.js --scope=subexam --bab=8    # hanya Ujian Pelajaran untuk bab tsb
//   node generate.js --scope=finex   --bab=8    # hanya Final Test untuk bab tsb
//
// Output: output/soal_<scope>_<bab>.json (atau output/soal_all.json utk scope=all)

const fs = require('fs');
const path = require('path');

// --- Konfigurasi -------------------------------------------------------------
const KURIKULUM = path.join(__dirname, 'kurikulum.json');
const OUT_DIR = path.join(__dirname, 'output');
const ENV_FILE = 'C:/Users/User/ambativasi-backend/ambativasi-api-app-test-voice/.env';
const GEMINI_MODEL = 'gemini-3.1-flash-lite';
const GEMINI_ENDPOINT = 'https://generativelanguage.googleapis.com/v1beta/models/' +
  GEMINI_MODEL + ':generateContent';
const MAX_RETRY = 3;

// Baca API key dari .env (tanpa menyimpan ulang di file baru)
function getApiKey() {
  const txt = fs.readFileSync(ENV_FILE, 'utf8');
  const m = txt.match(/^\s*GEMINI_API_KEY\s*=\s*(.+)\s*$/m);
  if (!m) throw new Error('GEMINI_API_KEY tidak ditemukan di ' + ENV_FILE);
  return m[1].replace(/^["']|["']$/g, '');
}

const GEMINI_API_KEY = getApiKey();

// --- Argumen -----------------------------------------------------------------
function parseArgs() {
  const args = {};
  process.argv.slice(2).forEach(a => {
    const m = a.match(/^--([^=]+)=(.*)$/);
    if (m) args[m[1]] = m[2];
  });
  return args;
}

// --- Helpers -----------------------------------------------------------------
const sleep = ms => new Promise(r => setTimeout(r, ms));

async function callGemini(promptSoal, jumlah, instruksiMateri) {
  const sys = `
Anda adalah guru pakar kurikulum Petrofisika dan Enhanced Oil Recovery (CEOR) untuk aplikasi kuis "Baqi Apps".
Tugas Anda: buat tepat ${jumlah} soal pilihan ganda bermutu tinggi dalam BAHASA INDONESIA.

ATURAN WAJIB:
1. Bahasa soal, opsi, dan kunci jawaban: BAHASA INDONESIA. Gunakan istilah teknis yang lazim (porositas, permeabilitas, saturasi air, gamma ray, resistivitas, Hukum Darcy, polymer flooding, Interfacial Tension, recovery factor, dll).
2. JANGAN menulis huruf jawaban (A, B, C, D) di dalam teks opsi maupun pertanyaan. Opsi hanya berisi teks jawaban.
3. JANGAN menuliskan nomor urut ("1.", "2.") di awal teks pertanyaan.
4. SETIAP soal harus punya 4 opsi pilihan.
5. Variasi tipe:
   - "option": satu jawaban benar. correct_option = string (teks opsi yang benar).
   - "multi": lebih dari satu jawaban benar (2-3 opsi). correct_option = array dari teks-teks opsi yang benar, contoh: ["porositas", "saturasi air"].
   Sebarkan tipe secara acak; mayoritas (kira-kira 80%) bertipe "option".
6. Untuk tiap soal sertakan juga versi (artinya) dalam BAHASA INGGRIS: question_en, options_en (array 4), correct_option_en (string utk option, array utk multi). Terjemahan opsi harus tetap berpasangan satu-satu urutannya.
7. Materi soal WAJIB sesuai ringkasan topik yang diberikan, tidak boleh melenceng ke topik lain.
8. Kunci jawaban harus benar secara sains/teknik.
9. Gunakan angka dan satuan yang benar (mis. porositas dalam %, permeabilitas dalam mD, tekanan kapiler dalam psi, viskositas dalam cP).

PANDUAN MATERI:
${instruksiMateri}

STRUKTUR OUTPUT (GUARDRAIL):
Output HARUS berupa JSON Array murni (tanpa teks pembungkus) dari objek dengan skema:
{
  "question": "...",            // Bahasa Indonesia, tanpa nomor & tanpa huruf jawaban
  "type": "option" | "multi",
  "options": ["...", "...", "...", "..."],   // 4 opsi, Bahasa Indonesia
  "correct_option": "..." | ["...", "..."],  // string utk option; array utk multi
  "question_en": "...",
  "options_en": ["...", "...", "...", "..."],
  "correct_option_en": "..." | ["...", "..."]
}`;

  const payload = {
    contents: [{ parts: [{ text: promptSoal }] }],
    systemInstruction: { parts: [{ text: sys }] },
    generationConfig: { responseMimeType: 'application/json', temperature: 0.85 }
  };

  let lastErr = null;
  for (let attempt = 1; attempt <= MAX_RETRY; attempt++) {
    try {
      const resp = await fetch(GEMINI_ENDPOINT + '?key=' + GEMINI_API_KEY, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(payload)
      });
      if (!resp.ok) {
        const body = await resp.text();
        lastErr = new Error('HTTP ' + resp.status + ': ' + body.slice(0, 300));
      } else {
        const data = await resp.json();
        const raw = data?.candidates?.[0]?.content?.parts?.[0]?.text;
        if (!raw) throw new Error('Respons Gemini kosong (finishReason: ' + (data?.candidates?.[0]?.finishReason || '?') + ')');
        let parsed = JSON.parse(raw);
        if (!Array.isArray(parsed)) {
          parsed = parsed?.soal || parsed?.data || parsed?.questions || null;
        }
        if (!Array.isArray(parsed)) throw new Error('Hasil bukan array JSON');
        return parsed;
      }
    } catch (e) {
      lastErr = e;
    }
    await sleep(3000 * attempt);
  }
  throw lastErr || new Error('Gagal memanggil Gemini setelah ' + MAX_RETRY + ' percobaan');
}

// Ubah kunci jawaban huruf/teks menjadi teks opsi yang cocok
function mapAnswer(correct, options) {
  const LETTERS = ['a', 'b', 'c', 'd'];
  const toText = c => {
    const str = String(c).trim();
    const low = str.toLowerCase();
    const idx = LETTERS.indexOf(low.replace(/^\(|\)$/g, ''));
    if (idx >= 0 && options[idx]) return options[idx];
    const found = options.find(o => o.toLowerCase() === low);
    if (found) return found;
    // cari opsi yang terkandung di dalam jawaban teks
    return options.find(o => o.length > 2 && low.includes(o.toLowerCase())) || null;
  };
  if (Array.isArray(correct)) {
    return correct.map(toText).filter(Boolean);
  }
  return toText(correct);
}

// Normalisasi & validasi hasil
function normalizeSoal(raw, expectedCount) {
  const hasil = [];
  for (const s of raw) {
    if (!s || typeof s !== 'object') continue;
    const type = (s.type === 'multi') ? 'multi' : 'option';
    const options = Array.isArray(s.options) && s.options.length === 4
      ? s.options.map(o => String(o).trim())
      : null;
    if (!options) continue;
    const correct = mapAnswer(s.correct_option || s.correct, options);
    if (type === 'multi') {
      if (!Array.isArray(correct) || correct.length < 2) continue;
    } else {
      if (Array.isArray(correct)) {
        if (correct.length !== 1) continue;
      }
      if (!correct) continue;
      // pastikan option hanya 1 jawaban
      const tunggal = Array.isArray(correct) ? correct[0] : correct;
      if (!tunggal) continue;
    }
    const options_en = Array.isArray(s.options_en) && s.options_en.length === 4
      ? s.options_en.map(o => String(o).trim())
      : options;
    let correct_en = type === 'multi'
      ? mapAnswer(s.correct_option_en || s.correct_en || correct, options_en)
      : mapAnswer(s.correct_option_en || s.correct_en || correct, options_en);
    if (type === 'multi') {
      if (!Array.isArray(correct_en) || correct_en.length < 2) correct_en = correct; // fallback pakai versi id
    } else {
      correct_en = Array.isArray(correct_en) ? correct_en[0] : correct_en;
      if (!correct_en) correct_en = (Array.isArray(correct) ? correct[0] : correct);
    }
    const q = String(s.question || '').replace(/^\d+[\.\s]+/, '').trim();
    const qen = String(s.question_en || s.question || '').replace(/^\d+[\.\s]+/, '').trim();
    hasil.push({
      question: q,
      type,
      options,
      correct_option: (type === 'multi') ? correct : (Array.isArray(correct) ? correct[0] : correct),
      question_en: qen,
      options_en,
      correct_option_en: correct_en
    });
  }
  if (hasil.length < expectedCount) {
    console.warn(`  [warn] hanya ${hasil.length}/${expectedCount} soal valid dari Gemini`);
  }
  return hasil;
}

// --- Build prompt ------------------------------------------------------------
function promptUntukMateri(bab, sub, materi) {
  return `Buatkan 5 soal untuk materi "${materi.topik}" (Bab: ${bab.nama}). Ringkasan materi: ${materi.ringkasan}.`;
}
function promptUntukSubexam(bab, sub) {
  return `Buatkan 10 soal untuk Ujian Pelajaran sub-bab "${sub.nama}" (Bab: ${bab.nama}). Cakupan materi sub-bab: ${sub.topik}. Soal merata untuk seluruh topik sub-bab tersebut.`;
}
function promptUntukFinex(bab) {
  return `Buatkan 20 soal untuk Final Test bab "${bab.nama}". Cakupan bab: ${bab.topik}. Soal merata mencakup seluruh sub-bab pada bab ini, dari konsep dasar sampai aplikasi.`;
}

// --- Alur utama --------------------------------------------------------------
async function main() {
  const args = parseArgs();
  const scope = args.scope || 'all'; // bab | all | materi | subexam | finex
  const babFilter = args.bab ? args.bab.split(',').map(Number) : null;

  const kurikulum = JSON.parse(fs.readFileSync(KURIKULUM, 'utf8'));
  let daftarBab = kurikulum.bab;
  if (babFilter) daftarBab = daftarBab.filter(b => babFilter.includes(b.no));
  const keysFilter = args.keys ? args.keys.split(',').map(s => s.trim()) : null;

  if (!fs.existsSync(OUT_DIR)) fs.mkdirSync(OUT_DIR, { recursive: true });

  const semuaSoal = []; // { group, lid/mid, jumlah, soalnya }

  for (const bab of daftarBab) {
    console.log(`\n=== Bab ${bab.no}: ${bab.nama} ===`);

    if (scope === 'all' || scope === 'materi') {
      for (const sub of bab.sub_bab) {
        for (const materi of sub.materi) {
          if (keysFilter && !keysFilter.includes(materi.id)) continue;
          process.stdout.write(`  [materi ${materi.id}] ${materi.topik} ... `);
          const raw = await callGemini(promptUntukMateri(bab, sub, materi), 5,
            `Judul materi: ${materi.topik}\nRingkasan: ${materi.ringkasan}`);
          const soal = normalizeSoal(raw, 5);
          semuaSoal.push({ group: 'materi', key: materi.id, nama: materi.topik, jumlah: soal.length, soal });
          console.log(`${soal.length} soal OK`);
          await sleep(1500);
        }
      }
    }

    if (scope === 'all' || scope === 'subexam') {
      for (const sub of bab.sub_bab) {
        if (keysFilter && !keysFilter.includes(sub.id)) continue;
        process.stdout.write(`  [subexam ${sub.id}] ${sub.nama} ... `);
        const raw = await callGemini(promptUntukSubexam(bab, sub), 10,
          `Sub-bab: ${sub.nama}\nTopik: ${sub.topik}`);
        const soal = normalizeSoal(raw, 10);
        semuaSoal.push({ group: 'subexam', key: sub.id, nama: sub.nama, jumlah: soal.length, soal });
        console.log(`${soal.length} soal OK`);
        await sleep(1500);
      }
    }

    if (scope === 'all' || scope === 'finex') {
      if (keysFilter && !keysFilter.includes(bab.id)) continue;
      process.stdout.write(`  [finex ${bab.id}] ${bab.nama} ... `);
      const raw = await callGemini(promptUntukFinex(bab), 20,
        `Bab: ${bab.nama}\nTopik: ${bab.topik}`);
      const soal = normalizeSoal(raw, 20);
      semuaSoal.push({ group: 'finex', key: bab.id, nama: bab.nama, jumlah: soal.length, soal });
      console.log(`${soal.length} soal OK`);
      await sleep(1500);
    }
  }

  let namaFile;
  if (keysFilter) {
    namaFile = `soal_${scope}_keys.json`;
  } else {
    const tag = bb => bb ? `bab${babFilter.join('-')}` : 'all';
    namaFile = `soal_${scope}${babFilter ? '_' + tag() : ''}.json`;
  }
  const fileOut = path.join(OUT_DIR, namaFile);
  fs.writeFileSync(fileOut, JSON.stringify(semuaSoal, null, 2), 'utf8');
  const total = semuaSoal.reduce((a, g) => a + g.jumlah, 0);
  console.log(`\nSelesai! ${semuaSoal.length} grup, ${total} soal -> ${fileOut}`);
}

main().catch(e => { console.error('\nERROR:', e.message); process.exit(1); });