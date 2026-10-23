# Batch 40 soal - perbaikan opsi & kunci jawaban

File SQL: `sql/fix-opsi-quran/fix-opsi-quran-batch40.sql`

Cakupan: **hanya 40 ID** (31 di `final_exam`, 9 di `soal`). Tidak ada perubahan pada level, sublevel, materi, exam, atau soal lain.

## Cara import

1. **Backup** tabel `final_exam` dan `soal` (minimal export 40 baris ini) sebelum import.
2. Import `fix-opsi-quran-batch40.sql` lewat phpMyAdmin/MySQL client.
3. Jalankan verifikasi di bagian bawah file SQL, lalu cek API dengan `verify_batch40.js`.
4. Setelah import, jalankan audit ulang: seharusnya **0 opsi tambahan** dan **0 mismatch multi/drag** untuk seluruh 4.080 soal.

## Ringkasan perubahan

- 19 kunci kosong diisi dari opsi yang benar.
- 1 kunci serialized skalar (`s:8:"Salahnya";`) dijadikan teks biasa.
- 6 kunci yang tidak ada di opsi diselaraskan.
- 13 soal multi/drag diperbaiki (kunci/opsi EN atau ID).
- 1 soal multi rusak total (FQT 0271) dipulihkan dari sumber `soal_all.json`.
- 1 soal (QST 01153) opsinya diperbaiki dari "kirim" menjadi "tunduk" dan stem dilengkapi `لَا`.

## Daftar 40 soal

| No | ID | Tabel | Tipe | Perbaikan |
|---:|---|---|---|---|
| 1 | `FQT00000000000000000091` | final_exam | drag | Opsi EN ke-2 punya spasi di awal (" أَنَا...") sehingga tidak sama dengan kunci. Spasi dihapus. |
| 2 | `FQT00000000000000000092` | final_exam | drag | Kunci EN "who?" tidak sama dengan opsi "Who?" (huruf besar). Diselaraskan. |
| 3 | `FQT00000000000000000115` | final_exam | multi | Kunci EN ke-2 "He will plot" tidak ada di opsi; diganti "I plot evil plan" (sesuai kunci Indonesia). |
| 4 | `FQT00000000000000000206` | final_exam | option | Opsi C salah/duplikat; diganti dengan kunci yang benar "نَعَمْ، شِئْنَا خَيْرًا". |
| 5 | `FQT00000000000000000474` | final_exam | multi | Kunci EN ke-4 "Read the biography..." tidak ada di opsi; diselaraskan ke opsi EN ke-4 "earnings Halal" (sama dengan kunci Indonesia). |
| 6 | `FQT00000000000000000506` | final_exam | option | Kunci tersimpan sebagai serialized skalar s:8:"Salahnya";. Dijadikan teks biasa "Salahnya". |
| 7 | `FQT00000000000000000522` | final_exam | multi | Kunci EN ke-2 "we will glorify" tidak ada di opsi; diganti "He will migrate" (sesuai kunci Indonesia). |
| 8 | `FQT00000000000000000531` | final_exam | option | Kunci kosong; diisi opsi D "dan biarkan wanitamu hidup". |
| 9 | `FQT00000000000000000532` | final_exam | option | Kunci kosong; diisi opsi C "Kami memisahkan laut untukmu". |
| 10 | `FQT00000000000000000533` | final_exam | option | Kunci kosong; diisi opsi A "يَفْرُقُ". |
| 11 | `FQT00000000000000000534` | final_exam | option | Kunci kosong; diisi opsi C "مُذَبَّح" (ism maf'ul dari ذَبَّحَ). |
| 12 | `FQT00000000000000000536` | final_exam | option | Kunci kosong; diisi opsi D "selama empat puluh malam". |
| 13 | `FQT00000000000000000537` | final_exam | option | Kunci kosong; diisi opsi B "kalian semua mengambil [untuk disembah] anak sapi itu". |
| 14 | `FQT00000000000000000538` | final_exam | option | Kunci kosong; diisi opsi B "لَيَالِيْ". |
| 15 | `FQT00000000000000000540` | final_exam | option | Kunci kosong; diisi opsi B "menerima bimbingan darinya". |
| 16 | `FQT00000000000000000541` | final_exam | option | Kunci kosong; diisi opsi C "dengan Anda mengambil anak sapi". |
| 17 | `FQT00000000000000000542` | final_exam | option | Kunci kosong; diisi opsi D "dan bunuh dirimu". |
| 18 | `FQT00000000000000000543` | final_exam | option | Kunci kosong; diisi opsi A "تُبْ". |
| 19 | `FQT00000000000000000544` | final_exam | option | Kunci kosong; diisi opsi D "api neraka abadi". |
| 20 | `FQT00000000000000000545` | final_exam | option | Kunci kosong; diisi opsi A "dengan membunuh mereka yang melakukan syirik". |
| 21 | `FQT00000000000000000546` | final_exam | option | Kunci kosong; diisi opsi D "Kemudian Kami menghidupkanmu kembali". |
| 22 | `FQT00000000000000000547` | final_exam | option | Kunci kosong; diisi opsi B "setelah kematianmu". |
| 23 | `FQT00000000000000000548` | final_exam | option | Kunci kosong; diisi opsi B "مُؤْمَن". |
| 24 | `FQT00000000000000000688` | final_exam | multi | Kunci ke-2 "فَاقِعٌ" berasal dari soal lain; diganti "Dia akan mengungkapkan" (sesuai versi Inggris). |
| 25 | `FQT00000000000000000830` | final_exam | option | Kunci kosong; diisi opsi D (jawaban yang sama dengan versi Inggris). |
| 26 | `FQT00000000000000000831` | final_exam | option | Opsi D berisi jawaban soal nomor 23. Diganti dengan kunci "Setan tidak akan pernah disesatkan". |
| 27 | `FQT00000000000000001180` | final_exam | multi | Kunci ke-4 "berguna" tidak persis sama dengan opsi "Sangat berguna dalam menghafal Al-Qur'an". Diselaraskan. |
| 28 | `FQT00000000000000001351` | final_exam | multi | Kunci ke-2 "وَعْد" tidak ada di opsi; diganti dengan opsi C "Dimulai dengan \"اَلْ\"" (sesuai versi Inggris). |
| 29 | `FQT00000000000000001363` | final_exam | option | Kunci tidak ada di opsi. Jawaban benar "فِيْ سَبِيْلِ اللهِ" (opsi B), sama dengan versi Inggris. |
| 30 | `FQT00000000000000001384` | final_exam | option | Kunci tidak ada di opsi. Jawaban benar "mereka membuka" (opsi B), sama dengan versi Inggris "they open". |
| 31 | `FQT00000000009200000271` | final_exam | multi | Serialized array rusak karena karakter μ tidak terbaca (panjang byte tidak cocok). Dipulihkan dari sumber soal_all.json. |
| 32 | `QST00000000000000000381` | soal | multi | Opsi EN ke-2 dan ke-4 salah terjemahan; diselaraskan dengan kunci EN (mixed truth / hid the predictions of Torah). |
| 33 | `QST00000000000000000551` | soal | option | Kunci "dan ketika Musa meminta air" tidak persis ada di opsi; dipakai opsi D yang benar "dan ketika Musa telah meminta air". |
| 34 | `QST00000000000000001115` | soal | drag | Kunci "اُمْنِيّ" bukan jamak dari أُمْنِيَّة; jamak yang benar "أَمَانِيّ" (opsi D). Kunci EN "كَسْب" juga dari soal lain. |
| 35 | `QST00000000000000001153` | soal | option | Kunci kosong dan opsi Indonesia salah (kirim = send, seharusnya tunduk/submit). Stem juga dilengkapi لَا agar sama dengan versi Inggris. |
| 36 | `QST00000000000000001154` | soal | option | Kunci kosong; diisi opsi D "تُسْلِمِيْنَ". |
| 37 | `QST00000000000000001263` | soal | drag | Opsi C "يَكْرُمُوْنَ" bukan ism fa'il; diganti "كَرِيْم" (sesuai kunci dan versi Inggris). |
| 38 | `QST00000000000000001314` | soal | option | Kunci 4 tidak ada di opsi Indonesia dan faktanya jenis jamak ada 3. Kunci ID & EN diselaraskan ke "3". |
| 39 | `QST00000000000000001324` | soal | drag | Opsi C "بَصَل" dari soal lain dan opsi D belum memuat jawaban; diselaraskan dengan versi Inggris (سُنَة / سَنِيْن). |
| 40 | `QST00000000000000001596` | soal | multi | Tulisan sama tetapi urutan Unicode shadda/fatha berbeda. Opsi diselaraskan dengan kunci (fatha lalu shadda). |


## Catatan khusus (bukan bagian dari 40)

- `FQT...00534`: pertanyaan Indonesia (ism maf'ul) dan Inggris (plural ساجد) berbeda topik. Masing-masing konsisten; **tidak diubah**.
- `FQT...00547`: pertanyaan Indonesia (terjemahan) dan Inggris (ism maf'ul) berbeda topik. Masing-masing konsisten; **tidak diubah**.
- `FQT...00688`: stem Indonesia tertulis `وْحِيْ` (kurang awalan), versi Inggris `يُوْحِيْ`. Kunci/opsi sudah diperbaiki; **stem tidak diubah**.
- `QST...01314`: kunci diubah dari 4 menjadi 3 karena jenis jamak dalam bahasa Arab memang 3.
- `QST...01115`: kunci diubah menjadi `أَمَانِيّ` (jamak yang benar), bukan `اُمْنِيّ`.
- `QST...01153`: opsi Indonesia sebelumnya menerjemahkan "kirim" (send), padahal soalnya "tunduk/submit"; opsi dan stem diperbaiki.
- `FQT...00831`: opsi D sebelumnya berisi jawaban soal nomor 23; diganti dengan kunci yang benar.
- `QST...01596`: tulisan `عَفَّان` sama, tetapi urutan Unicode shadda/fatha berbeda; opsi diselaraskan dengan kunci.

## Verifikasi setelah import

```bash
node C:\Users\User\AppData\Local\Temp\opencode\verify_batch40.js
```

Harus menghasilkan `LOLOS: 40/40` dan `SEMUA 40 SOAL BERSIH`.
