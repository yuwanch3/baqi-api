# Proposal Pengisian Level 6 (Memahami Qur'an) — v1

> Status: **USULAN — belum ada perubahan DB/PHP/kode apa pun.**
> Branch kerja: `feat/l6-isi-kurikulum-quran`
> Motto: *JANGAN ADA YANG DIUBAH SELAIN YANG KU MINTA!*

---

## 1. Ringkasan

Level 6 (`LVC000000006`) saat ini **kosong total** (0 sublevel, 0 materi, 0 soal).
Berdasarkan analisis pola kurikulum terhadap sumber resmi **understandquran.com** (seri *Understand Al-Qur'an - the Easy Way* karya Dr. Abdulazeez Abdulraheem), kami mengusulkan pengisian Level 6 sebagai **kelanjutan seri = "Course 6"**: mushaf halaman **21–25 = Surah Al-Baqarah 142–176**.

Format mengikuti pola baku level 2–5: **5 sublevel × 8 materi = 40 materi**
(4 pelajaran Qur'an/pointer + 4 pelajaran Nahw/grammar per halaman).

---

## 2. Konfirmasi pola kurikulum (DB ↔ sumber UQ) — VERIFIED

| Level DB | Sumber UQ | Isi | Struktur |
|---|---|---|---|
| Level 1 | Course 1 (Salah + 50% kata Qur'an) | Fatihah, 6 surah pendek, shalat, dasar kata | 4 sublevel |
| Level 2 | Course 2 | Baqarah 1–37 (hal. 1–5) | 5 sublevel × 8 materi |
| Level 3 | Course 3 | Baqarah 38–76 (hal. 6–10) | 5 sublevel × 8 materi |
| Level 4 | Course 4 | Baqarah 77–105 (hal. 11–15) | 5 sublevel × 8 materi |
| Level 5 | Course 5 | Baqarah 106–141 (hal. 16–20) | 5 sublevel × 8 materi |
| **Level 6** | **(kelanjutan: hal. 21–25)** | **Baqarah 142–176** | **5 sublevel × 8 materi** |

Bukti kecocokan 1:1 (contoh, memakai judul pelajaran UQ resmi):
- C5 16a *Abrogation… (106–107)* = materi DB *"Pencabutan..."* (MTR…163)
- C5 Gr16a *Verbal Sentence* = materi DB *"Kalimat Verbal جُمْلَةٌ فِعْلِيَّةٌ"* (MTR…164)
- C5 20d *Most unjust hides testimony (140–141)* = materi DB *"Paling tidak adil membunyikan kesaksian"*
- dst.

Pola per sublevel: **1 sublevel = 1 halaman mushaf = 8 materi** (urutan: Qur'an a, Grammar a, Qur'an b, Grammar b, Qur'an c, Grammar c, Qur'an d, Grammar d).

> Catatan sumber: UQ Academy **tidak menerbitkan "Course 6"** (seri bebas berhenti di Course 5 = hal. 20 = ay. 141, akhir Juz 1). Kelanjutan resminya adalah kursus berbayar *"Understand Al-Qur'an 100%"*. Karena itu **konten L6 dibangun mengikuti pola UQ**, bukan menyalin PDF/video/kuis dari sumber.

---

## 3. Peta halaman & ayat Level 6 (TERVERIFIKASI)

Anchor: buku Course 5 UQ memastikan hal. 20 = ay. 135–141. Peta mushaf selanjutnya (cocok dgn percabangan halaman mushaf Madani, dicek via API):

| Sublevel | Halaman UQA | Ayat | Jumlah | Tema |
|---|---|---|---|---|
| Sublevel 1 | 21 | 142–145 | 4 | Perubahan kiblat |
| Sublevel 2 | 22 | 146–153 | 8 | Kiblat, hujjah, hubungan dgn Allah |
| Sublevel 3 | 23 | 154–163 | 10 | Sabar, haji, menyembunyikan kebenaran |
| Sublevel 4 | 24 | 164–169 | 6 | Tanda kuasa Allah, syirik, halal-haram |
| Sublevel 5 | 25 | 170–176 | 7 | Taqlid, perumpamaan kafir, makanan haram |

Total: **35 ayat (142–176)** — sepadan dengan Course 4 (29) & Course 5 (36).

---

## 4. Daftar 40 materi L6

### Sublevel 1 — Halaman 21 (2:142–145) — Perubahan Kiblat

| # | ID Materi | Pelajaran | Rentang | Judul (usulan) |
|---|---|---|---|---|
| 1 | MTR…206 | Qur'an 21a | 142 | Pertanyaan Orang-Orang Bodoh: Apa yang Memalingkan Kiblat? |
| 2 | MTR…207 | Grammar 21a | — | فعل الأمر: Kalimat Perintah (قُلْ، فَوَلِّ، فَوَلُّوا) |
| 3 | MTR…208 | Qur'an 21b | 143 | Umat Pertengahan & Hikmah Perubahan Kiblat |
| 4 | MTR…209 | Grammar 21b | — | حروف الجر: Kata Depan (عَنْ، عَلَى، مِنْ، إِلَى) |
| 5 | MTR…210 | Qur'an 21c | 144 | Menghadap ke Masjidil Haram |
| 6 | MTR…211 | Grammar 21c | — | جملة فِعْلِيَّة: فِعْل + فَاعِل + مَفْعُول |
| 7 | MTR…212 | Qur'an 21d | 145 | Ahlul Kitab Tidak Akan Mengikuti Kiblatmu |
| 8 | MTR…213 | Grammar 21d | — | Ulangan: Tanda-Tanda I'rab dalam Ayat Kiblat |

### Sublevel 2 — Halaman 22 (2:146–153) — Kiblat & Hubungan dengan Allah

| # | ID Materi | Pelajaran | Rentang | Judul |
|---|---|---|---|---|
| 9 | MTR…214 | Qur'an 22a | 146–147 | Ahlul Kitab Mengenalnya Seperti Anak Mereka |
| 10 | MTR…215 | Grammar 22a | — | فعل أمر (Mazeed): فَاسْتَبِقُوا، فَاذْكُرُونِي، اشْكُرُوا، اسْتَعِينُوا |
| 11 | MTR…216 | Qur'an 22b | 148–149 | Setiap Umat Punya Kiblat: Berlomba dalam Kebaikan |
| 12 | MTR…217 | Grammar 22b | — | الضمائر المتصلة: Kata Ganti Sandar (يَعْرِفُونَهُ، آتَيْنَاهُمُ، جَعَلْنَاكُمْ) |
| 13 | MTR…218 | Qur'an 22c | 150–151 | Agar Manusia Tak Punya Hujjah; Rasul Menjadi Saksi |
| 14 | MTR…219 | Grammar 22c | — | لا الناهية: Larangan & جزم المضارع (وَلَا تَكْفُرُونِ) |
| 15 | MTR…220 | Qur'an 22d | 152–153 | Ingatlah Aku; Minta Tolong dengan Sabar & Shalat |
| 16 | MTR…221 | Grammar 22d | — | أدوات الشرط: Kata Syarat (أَيْنَ مَا تَكُونُوا يَأْتِ بِكُمُ اللَّهُ) |

### Sublevel 3 — Halaman 23 (2:154–163) — Sabar, Ibadah, & Peringatan

| # | ID Materi | Pelajaran | Rentang | Judul |
|---|---|---|---|---|
| 17 | MTR…222 | Qur'an 23a | 154–155 | Jangan Katakan "Mati" Bagi yang Gugur; Ujian & Kabar Baik |
| 18 | MTR…223 | Grammar 23a | — | لا النافية: Negasi (لَا إِلَهَ إِلَّا هُوَ) |
| 19 | MTR…224 | Qur'an 23b | 156–157 | إِنَّا لِلَّهِ وَإِنَّا إِلَيْهِ رَاجِعُونَ; Shalawat & Rahmat |
| 20 | MTR…225 | Grammar 23b | — | إِلَّا: Pengecualian (إِلَّا الَّذِينَ تَابُوا وَأَصْلَحُوا) |
| 21 | MTR…226 | Qur'an 23c | 158–159 | Safa & Marwah Syi'ar Allah; Ancaman Menyembunyikan Kebenaran |
| 22 | MTR…227 | Grammar 23c | — | حروف العطف: Kata Sambung (وَ، فَ، أَوْ) |
| 23 | MTR…228 | Qur'an 23d | 160–163 | Taubat Para Penyembunyi; Laknat bagi Kafir; Allah Satu-Satunya |
| 24 | MTR…229 | Grammar 23d | — | جملة اسمية: مُبْتَدَأ + خَبَر (أُولَئِكَ عَلَيْهِمْ صَلَوَاتٌ) |

### Sublevel 4 — Halaman 24 (2:164–169) — Tanda Kuasa Allah & Syirik

| # | ID Materi | Pelajaran | Rentang | Judul |
|---|---|---|---|---|
| 25 | MTR…230 | Qur'an 24a | 164 | Tanda-Tanda Kekuasaan Allah di Alam |
| 26 | MTR…231 | Grammar 24a | — | المَصْدَر: Kata Benda Kerja (خَلْقِ، اخْتِلَافِ، تَصْرِيفِ) |
| 27 | MTR…232 | Qur'an 24b | 165 | Menjadikan Tandingan Selain Allah; Cinta yang Paling Dahsyat |
| 28 | MTR…233 | Grammar 24b | — | مفعول به & جار ومجرور (مَا أَنْزَلَ اللَّهُ مِنَ السَّمَاءِ مِنْ مَاءٍ) |
| 29 | MTR…234 | Qur'an 24c | 166–167 | Berlepas Diri pada Hari Kiamat |
| 30 | MTR…235 | Grammar 24c | — | جملة فعلية + ضمير متصل objek (يُحِبُّونَهُمْ، يَرَوْنَ الْعَذَابَ) |
| 31 | MTR…236 | Qur'an 24d | 168–169 | Makan yang Halal & Baik; Jangan Ikuti Langkah Setan |
| 32 | MTR…237 | Grammar 24d | — | نفي & شَرْط: لَوْ / لَوْ أَنَّ (وَلَوْ يَرَى الَّذِينَ ظَلَمُوا) |

### Sublevel 5 — Halaman 25 (2:170–176) — Taqlid, Perumpamaan, Makanan Haram

| # | ID Materi | Pelajaran | Rentang | Judul |
|---|---|---|---|---|
| 33 | MTR…238 | Qur'an 25a | 170–171 | "Kami Mengikuti Nenek Moyang"; Perumpamaan Orang Kafir |
| 34 | MTR…239 | Grammar 25a | — | كان + خبر dgn نفي/استفهام (أَوَلَوْ كَانَ آبَاؤُهُمْ لَا يَعْقِلُونَ) |
| 35 | MTR…240 | Qur'an 25b | 172–173 | Makan yang Thayyib; Makanan yang Diharamkan |
| 36 | MTR…241 | Grammar 25b | — | التشبيه: Perumpamaan (كَمَثَلِ الَّذِي يَنْعِقُ، صُمٌّ بُكْمٌ عُمْيٌ) |
| 37 | MTR…242 | Qur'an 25c | 174–175 | Ancaman Menyembunyikan Kitab Allah; Menukar Petunjuk |
| 38 | MTR…243 | Grammar 25c | — | إِنَّمَا: Pembatasan (إِنَّمَا حَرَّمَ عَلَيْكُمُ...) |
| 39 | MTR…244 | Qur'an 25d | 176 | Al-Qur'an Turun dengan Kebenaran; Akibat Perselisihan |
| 40 | MTR…245 | Grammar 25d | — | مراجعة: Ulangan & Rangkuman Struktur (142–176) |

> Catatan: judul di atas usulan gaya UQ (pendek & tematik). Bisa disesuaikan sebelum generate.

---

## 5. Struktur soal per materi (mengikuti pola existing)

Pola terverifikasi dari level existing (dicek langsung ke API):

**Materi Qur'an (pointer):**
- **6 soal** = 5 `option` + 1 `yesorno` (mirror L5)
- Tipe soal: (1) terjemahan frasa Arab→ID, (2) arti kata kunci ayat, (3) pilih jamak/masdar dari kata, (4) konsep pointer (apa yang direnungkan), (5) pasangan kata, (6) yesorno verifikasi terjemahan.

Contoh nyata (MTR…163 "Pencabutan"):
1. `option` — Terjemahan مَا نَنْسَخْ → *Apa yang Kami batalkan?*
2. `option` — Pilih jamak dari اٰيَة → *اٰيَات*
3. `option` — Nama tindakan dari نَسَخَ → *نَسْخ*
4. `yesorno` — Apakah مَا نَنْسَخْ berarti "Apa yang Kami batalkan?" → *Yes*

**Materi Grammar:**
- **8 soal** = 7 `option` + 1 `yesorno`; sebagian materi + 1 `multi` (pilih semua) — mirror L4/L5.
- Tipe soal: identifikasi contoh kaidah, transformasi (jamak/feminin/أمر), terjemahan kalimat, pilih pola yang benar, konsep, yesorno.

Contoh nyata (MTR…164 "Kalimat Verbal"):
1. `option` — Untuk contoh apa حَفِظَ الْمُسْلِمُ الْقُرْاٰنَ? → *Kalimat verbal*
2. `option` — Apa yang akan menjadi jamak dari حَفِظَ الْمُسْلِمُ الْقُرْاٰنَ? → *حَفِظَ الْمُسْلِمُوْنَ الْقُرْاٰنَ*
3. `option` — Jadikan feminin فعل dan فاعل… → *تَقْرَأُ الْمُسْلِمَةُ الْحَدِيْثَ*
4. `yesorno` → *Yes*

**Estimasi total soal: 20×6 + 20×8 = 280 (+ beberapa multi) ≈ 285–300 soal.**

---

## 6. Rencana ID baru (semua sudah diverifikasi kosong)

| Objek | Jumlah | Blok ID | Contoh |
|---|---|---|---|
| Sublevel | 5 | SLV…037–041 | SLV000000000000000037 |
| Materi | 40 | MTR…206–245 | MTR000000000000000206 |
| Soal | ±300 | QST…4000–4419 | QST00000000000000004000 |

Verifikasi: inventaris menyeluruh seluruh 18 level → max yang terpakai SLV=36, MTR=205; rentang QST 3300–4999 **kosong** (max blok QST yang dipakai s.d. 3299 + blok 9xxxx petro/ceor).

Field sublevel mengikuti pola existing:
`name = "Sublevel 1..5"`, `level = "Level 6"`, `state_exam = "yes"`, `ujian_grammer = ""`, `ujian_pelajaran = ""`, `backgroundColor` mengikuti siklus warna level lain.

Field materi mengikuti pola existing:
`level = "Level 6"`, `sub_levels = "Sublevel n"`, `information` = judul, `information_en`, `description` = teks baku ("Setelah melihat video diatas, silahkan lanjutkan ke step selanjutnya : Baca atau Ujian"), `state_exam = "yes"`.

---

## 7. Keputusan yang dibutuhkan (poin penting sebelum eksekusi)

### 7a. Field `doc`, `doc_en`, `watch`, `test`
Karena tidak ada PDF/video publik UQ untuk halaman 21–25, usulan:
- **`test`** → boleh dikosongkan (`''`): tombol **Ujian tetap berfungsi normal** karena soal kuis diambil dari DB (`questions/mid/{mid}`), bukan dari link. *(Alternatif: isi link Google Form bikinan sendiri jika kamu mau — butuh pembuatan form.)*
- **`watch`** → usulan dikosongkan **atau** diisi video tilawah/surah untuk halaman tsb (opsional).
- **`doc`/`doc_en`** → usulan dikosongkan.

Perilaku app saat field kosong (dicek di kode app, tidak merusak DB):
- Tombol **Tonton**: layar Watch → `videoId` kosong → player tidak tampil (video kosong). App tidak crash.
- Tombol **Baca / Unduh**: layar Read/Download → WebView kosong (blank). App tidak crash.
- **Tidak ada perubahan kode app/PHP.**

### 7b. Jumlah & tipe soal
- Usulan default: **6 soal (Qur'an) & 8 soal (grammar)** — mirror L5 (level sebelum L6).
- Alternatif: **11 soal** ala L2/L3 (lebih kaya; 10 option + 1 yesorno + multi). Total jadi ±440 soal.

### 7c. Proses eksekusi (aman, bertahap)
1. Generator SQL memakai **Path A** (`CONVERT(0x… USING utf8mb4)` untuk semua teks Arab/EN), **file 100% ASCII** (tanpa karakter non-ASCII di luar hex), mengikuti pola yang sudah terbukti pada batch أَسْلَمَ & Pembunuh.
2. SQL dipecah **per sublevel** (5 file) agar verifikasi ketat tiap langkah:
   - File 0: 5 sublevel
   - File 1–5: 8 materi + soal per sublevel
3. Tiap file diverifikasi lokal: ID unik vs seluruh DB, jumlah row, teks cocok, `correct_option` benar.
4. **Kamu import sendiri via phpMyAdmin**; lalu aku verifikasi via API (read-only): tiap materi punya sublevel, soal tampil, yesorno/multi jalan.
5. Tidak menyentuh PHP/app/kode; tidak mengubah materi/soal yang ada.

---

## 8. Yang akan dikerjakan setelah persetujuan

1. Tulis generator `generate-l6.js` (FINAL) + skrip verifikasi `verify-l6.js`.
2. Buat konten 40 materi + ±300 soal (frasa Arab dari ayat 142–176 + pola kaidah grammar L6).
3. Generate 6 file SQL ASCII.
4. Verifikasi loop lokal → kirim daftar file siap import.
5. Setelah kamu import: verifikasi API & laporan pass/fail.

---

*Dokumen ini disusun di branch `feat/l6-isi-kurikulum-quran`. Belum ada perubahan DB.*