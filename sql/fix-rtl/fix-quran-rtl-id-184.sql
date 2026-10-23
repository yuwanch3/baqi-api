-- ============================================================
-- BAQI - Perbaikan arah teks pertanyaan (RTL) - Quran Level 1-5
-- ============================================================
-- Dibuat: 2026-10-23
-- Cakupan: 184 soal (82 final_exam + 102 soal)
--
-- Masalah: pertanyaan dimulai angka lalu huruf Arab, sehingga paragraf
-- mengikuti arah RTL. Perbaikan: LRM (U+200E) di awal field question.
--
-- HANYA field `question` (versi Indonesia) yang diubah.
-- TIDAK diubah: question_en, options, options_en, correct_option,
-- correct_option_en, type, dan soal lain.
--
-- Tidak termasuk: 7 soal yang sudah diawali LRM (Q42 + 6 batch Level 3),
-- 2 kasus EN-only, dan seluruh soal Arab murni / yang sudah LTR.
--
-- Semua nilai ditulis hex UTF-8 + CONVERT(... USING latin1) agar byte
-- tersimpan persis, tidak tergantung charset koneksi.
--
-- BACKUP tabel final_exam dan soal sebelum import.
-- Setelah import, jalankan query verifikasi di bagian bawah file.
-- ============================================================

START TRANSACTION;

-- ------------------------------------------------------------
-- [1/184] FQT00000000000000001393 | option | Level 1 | Grammer Test
-- Sebelum: 43. فَعَلَ، يَفْعَلُ، اِفْعَلْ adalah kunci...
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E34332E20D981D98ED8B9D98ED984D98ED88C20D98AD98ED981D992D8B9D98ED984D98FD88C20D8A7D990D981D992D8B9D98ED984D992206164616C6168206B756E63692E2E2E USING latin1)
WHERE `id` = 'FQT00000000000000001393';

-- ------------------------------------------------------------
-- [2/184] FQT00000000000000001394 | option | Level 1 | Grammer Test
-- Sebelum: 44. فَاعِل، مَفْعُوْل، فِعْل adalah kunci...
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E34342E20D981D98ED8A7D8B9D990D984D88C20D985D98ED981D992D8B9D98FD988D992D984D88C20D981D990D8B9D992D984206164616C6168206B756E63692E2E2E USING latin1)
WHERE `id` = 'FQT00000000000000001394';

-- ------------------------------------------------------------
-- [3/184] FQT00000000000000000173 | option | Level 1 / Sublevel 2 | Ujian Pelajaran
-- Sebelum: 16. صَلَّيْتَ artinya :
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E31362E20D8B5D98ED984D991D98ED98AD992D8AAD98E20617274696E7961203A USING latin1)
WHERE `id` = 'FQT00000000000000000173';

-- ------------------------------------------------------------
-- [4/184] FQT00000000000000000584 | drag | Level 2 | Final Test
-- Sebelum: 5. فعل ماضٍ dari نَعْبُدُ adalah… 
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E352E20D981D8B9D98420D985D8A7D8B6D98D206461726920D986D98ED8B9D992D8A8D98FD8AFD98F206164616C6168E280A620 USING latin1)
WHERE `id` = 'FQT00000000000000000584';

-- ------------------------------------------------------------
-- [5/184] FQT00000000000000000594 | option | Level 2 | Final Test
-- Sebelum: 12. اسم فاعل dari خَتَمَ adalah…
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E31322E20D8A7D8B3D98520D981D8A7D8B9D984206461726920D8AED98ED8AAD98ED985D98E206164616C6168E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000594';

-- ------------------------------------------------------------
-- [6/184] FQT00000000000000000596 | drag | Level 2 | Final Test
-- Sebelum: 14. فعل مضارع dari شَعَرْتُ adalah…
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E31342E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206461726920D8B4D98ED8B9D98ED8B1D992D8AAD98F206164616C6168E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000596';

-- ------------------------------------------------------------
-- [7/184] FQT00000000000000000611 | option | Level 2 | Final Test
-- Sebelum: 21. فعل ماضٍ dari يَتْرُكُ adalah…
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E32312E20D981D8B9D98420D985D8A7D8B6D98D206461726920D98AD98ED8AAD992D8B1D98FD983D98F206164616C6168E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000611';

-- ------------------------------------------------------------
-- [8/184] FQT00000000000000000010 | option | Level 2 / Sublevel 1 | Ujian Pelajaran
-- Sebelum: 7. فعل ماضٍ dari نَعْبُدُ adalah...
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E372E20D981D8B9D98420D985D8A7D8B6D98D206461726920D986D98ED8B9D992D8A8D98FD8AFD98F206164616C61682E2E2E USING latin1)
WHERE `id` = 'FQT00000000000000000010';

-- ------------------------------------------------------------
-- [9/184] FQT00000000000000000021 | option | Level 2 / Sublevel 1 | Ujian Pelajaran
-- Sebelum: 16. فعل امر dari رَزَقَ:
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E31362E20D981D8B9D98420D8A7D985D8B1206461726920D8B1D98ED8B2D98ED982D98E3A USING latin1)
WHERE `id` = 'FQT00000000000000000021';

-- ------------------------------------------------------------
-- [10/184] FQT00000000000000000067 | option | Level 2 / Sublevel 2 | Ujian Pelajaran
-- Sebelum: 4. اسم فاعل dari خَتَمَ adalah…
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E342E20D8A7D8B3D98520D981D8A7D8B9D984206461726920D8AED98ED8AAD98ED985D98E206164616C6168E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000067';

-- ------------------------------------------------------------
-- [11/184] FQT00000000000000000073 | option | Level 2 / Sublevel 2 | Ujian Pelajaran
-- Sebelum: 8. فعل مضارع dari شَعَرْتُ adalah...
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E382E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206461726920D8B4D98ED8B9D98ED8B1D992D8AAD98F206164616C61682E2E2E USING latin1)
WHERE `id` = 'FQT00000000000000000073';

-- ------------------------------------------------------------
-- [12/184] FQT00000000000000000079 | option | Level 2 / Sublevel 2 | Ujian Pelajaran
-- Sebelum: 13. فعل أمرdari قَالَ adalah...
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E31332E20D981D8B9D98420D8A3D985D8B16461726920D982D98ED8A7D984D98E206164616C61682E2E2E USING latin1)
WHERE `id` = 'FQT00000000000000000079';

-- ------------------------------------------------------------
-- [13/184] FQT00000000000000000136 | option | Level 2 / Sublevel 3 | Ujian Pelajaran
-- Sebelum: 3. فعل ماضٍ dari يَتْرُكُ adalah...
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E332E20D981D8B9D98420D985D8A7D8B6D98D206461726920D98AD98ED8AAD992D8B1D98FD983D98F206164616C61682E2E2E USING latin1)
WHERE `id` = 'FQT00000000000000000136';

-- ------------------------------------------------------------
-- [14/184] FQT00000000000000000141 | option | Level 2 / Sublevel 3 | Ujian Pelajaran
-- Sebelum: 8. اسم فاعل dari مَاتَ adalah...
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E382E20D8A7D8B3D98520D981D8A7D8B9D984206461726920D985D98ED8A7D8AAD98E206164616C61682E2E2E USING latin1)
WHERE `id` = 'FQT00000000000000000141';

-- ------------------------------------------------------------
-- [15/184] FQT00000000000000000146 | option | Level 2 / Sublevel 3 | Ujian Pelajaran
-- Sebelum: 13. فعل مضارع dari عَلِمَ adalah... 
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E31332E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206461726920D8B9D98ED984D990D985D98E206164616C61682E2E2E20 USING latin1)
WHERE `id` = 'FQT00000000000000000146';

-- ------------------------------------------------------------
-- [16/184] FQT00000000000000000156 | option | Level 2 / Sublevel 3 | Ujian Pelajaran
-- Sebelum: 17. دَعَا adalah...
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E31372E20D8AFD98ED8B9D98ED8A7206164616C61682E2E2E USING latin1)
WHERE `id` = 'FQT00000000000000000156';

-- ------------------------------------------------------------
-- [17/184] FQT00000000000000000223 | option | Level 2 / Sublevel 4 | Ujian Pelajaran
-- Sebelum: 10. فعل أمر dari قَالَ adalah...
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E31302E20D981D8B9D98420D8A3D985D8B1206461726920D982D98ED8A7D984D98E206164616C61682E2E2E USING latin1)
WHERE `id` = 'FQT00000000000000000223';

-- ------------------------------------------------------------
-- [18/184] FQT00000000000000000239 | option | Level 2 / Sublevel 4 | Ujian Pelajaran
-- Sebelum: 18. يَرْجِعُ berarti:
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E31382E20D98AD98ED8B1D992D8ACD990D8B9D98F20626572617274693A USING latin1)
WHERE `id` = 'FQT00000000000000000239';

-- ------------------------------------------------------------
-- [19/184] FQT00000000000000000294 | option | Level 2 / Sublevel 5 | Ujian Pelajaran
-- Sebelum: 2. فعل ماض dari سَفْك adalah:
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E322E20D981D8B9D98420D985D8A7D8B6206461726920D8B3D98ED981D992D983206164616C61683A USING latin1)
WHERE `id` = 'FQT00000000000000000294';

-- ------------------------------------------------------------
-- [20/184] FQT00000000000000000306 | option | Level 2 / Sublevel 5 | Ujian Pelajaran
-- Sebelum: 8. اسم فاعل dari صَدَقَ adalah... 
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E382E20D8A7D8B3D98520D981D8A7D8B9D984206461726920D8B5D98ED8AFD98ED982D98E206164616C61682E2E2E20 USING latin1)
WHERE `id` = 'FQT00000000000000000306';

-- ------------------------------------------------------------
-- [21/184] FQT00000000000000000315 | option | Level 2 / Sublevel 5 | Ujian Pelajaran
-- Sebelum: 13. فعل امر dari أَكَلَ adalah...
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E31332E20D981D8B9D98420D8A7D985D8B1206461726920D8A3D98ED983D98ED984D98E206164616C61682E2E2E USING latin1)
WHERE `id` = 'FQT00000000000000000315';

-- ------------------------------------------------------------
-- [22/184] FQT00000000000000000317 | option | Level 2 / Sublevel 5 | Ujian Pelajaran
-- Sebelum: 14. فعل مضارع dari أَبٰى adalah...
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E31342E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206461726920D8A3D98ED8A8D9B0D989206164616C61682E2E2E USING latin1)
WHERE `id` = 'FQT00000000000000000317';

-- ------------------------------------------------------------
-- [23/184] FQT00000000000000000323 | option | Level 2 / Sublevel 5 | Ujian Pelajaran
-- Sebelum: 17. فعل امر dari هَبَطَ adalah...
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E31372E20D981D8B9D98420D8A7D985D8B1206461726920D987D98ED8A8D98ED8B7D98E206164616C61682E2E2E USING latin1)
WHERE `id` = 'FQT00000000000000000323';

-- ------------------------------------------------------------
-- [24/184] QST00000000000000000228 | option | Level 2 / Sublevel 1 / Materi: Do'a untuk petunjuk
-- Sebelum: 6. فعل مضارع dari مَلَكَ adalah...
UPDATE `soal`
SET `question` = CONVERT(0xE2808E362E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206461726920D985D98ED984D98ED983D98E206164616C61682E2E2E USING latin1)
WHERE `id` = 'QST00000000000000000228';

-- ------------------------------------------------------------
-- [25/184] QST00000000000000000230 | option | Level 2 / Sublevel 1 / Materi: Do'a untuk petunjuk
-- Sebelum: 7. فعل ماضٍ dari نَعْبُدُ dari...
UPDATE `soal`
SET `question` = CONVERT(0xE2808E372E20D981D8B9D98420D985D8A7D8B6D98D206461726920D986D98ED8B9D992D8A8D98FD8AFD98F20646172692E2E2E USING latin1)
WHERE `id` = 'QST00000000000000000230';

-- ------------------------------------------------------------
-- [26/184] QST00000000000000000314 | option | Level 2 / Sublevel 1 / Materi: Sifat muttaqien
-- Sebelum: 6. فعل امر dari رَزَقَ adalah
UPDATE `soal`
SET `question` = CONVERT(0xE2808E362E20D981D8B9D98420D8A7D985D8B1206461726920D8B1D98ED8B2D98ED982D98E206164616C6168 USING latin1)
WHERE `id` = 'QST00000000000000000314';

-- ------------------------------------------------------------
-- [27/184] QST00000000000000000643 | option | Level 2 / Sublevel 2 / Materi: Bermuka Dua
-- Sebelum: 5. فعل ماض dari يَعْمَهُ adalah... 
UPDATE `soal`
SET `question` = CONVERT(0xE2808E352E20D981D8B9D98420D985D8A7D8B6206461726920D98AD98ED8B9D992D985D98ED987D98F206164616C61682E2E2E20 USING latin1)
WHERE `id` = 'QST00000000000000000643';

-- ------------------------------------------------------------
-- [28/184] QST00000000000000000645 | option | Level 2 / Sublevel 2 / Materi: Bermuka Dua
-- Sebelum: 6. يَخْلُو adalah...
UPDATE `soal`
SET `question` = CONVERT(0xE2808E362E20D98AD98ED8AED992D984D98FD988206164616C61682E2E2E USING latin1)
WHERE `id` = 'QST00000000000000000645';

-- ------------------------------------------------------------
-- [29/184] QST00000000000000000596 | option | Level 2 / Sublevel 2 / Materi: Korup dan Bodoh
-- Sebelum: 5. فعل ماض dari يَعْلَمُ adalah... 
UPDATE `soal`
SET `question` = CONVERT(0xE2808E352E20D981D8B9D98420D985D8A7D8B6206461726920D98AD98ED8B9D992D984D98ED985D98F206164616C61682E2E2E20 USING latin1)
WHERE `id` = 'QST00000000000000000596';

-- ------------------------------------------------------------
-- [30/184] QST00000000000000000598 | option | Level 2 / Sublevel 2 / Materi: Korup dan Bodoh
-- Sebelum: 6. فعل أمر dari قَالَ adalah... 
UPDATE `soal`
SET `question` = CONVERT(0xE2808E362E20D981D8B9D98420D8A3D985D8B1206461726920D982D98ED8A7D984D98E206164616C61682E2E2E20 USING latin1)
WHERE `id` = 'QST00000000000000000598';

-- ------------------------------------------------------------
-- [31/184] QST00000000000000000570 | option | Level 2 / Sublevel 2 / Materi: Tidak Ada Petunjuk Bagi Munafiqqeen
-- Sebelum: 6. فعل مضارع dari شَعَرْتُ adalah...
UPDATE `soal`
SET `question` = CONVERT(0xE2808E362E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206461726920D8B4D98ED8B9D98ED8B1D992D8AAD98F206164616C61682E2E2E USING latin1)
WHERE `id` = 'QST00000000000000000570';

-- ------------------------------------------------------------
-- [32/184] QST00000000000000000572 | option | Level 2 / Sublevel 2 / Materi: Tidak Ada Petunjuk Bagi Munafiqqeen
-- Sebelum: 7. اسم مَفْعُوْل dari كَاذِب adalah... 
UPDATE `soal`
SET `question` = CONVERT(0xE2808E372E20D8A7D8B3D98520D985D98ED981D992D8B9D98FD988D992D984206461726920D983D98ED8A7D8B0D990D8A8206164616C61682E2E2E20 USING latin1)
WHERE `id` = 'QST00000000000000000572';

-- ------------------------------------------------------------
-- [33/184] QST00000000000000000352 | option | Level 2 / Sublevel 2 / Materi: Tidak Ada Petunjuk Untuk Kafir
-- Sebelum: 6. اسم مفعول dari يَكْفُرُ adalah…
UPDATE `soal`
SET `question` = CONVERT(0xE2808E362E20D8A7D8B3D98520D985D981D8B9D988D984206461726920D98AD98ED983D992D981D98FD8B1D98F206164616C6168E280A6 USING latin1)
WHERE `id` = 'QST00000000000000000352';

-- ------------------------------------------------------------
-- [34/184] QST00000000000000000353 | option | Level 2 / Sublevel 2 / Materi: Tidak Ada Petunjuk Untuk Kafir
-- Sebelum: 7. اسم فاعل dari خَتَمَ adalah…
UPDATE `soal`
SET `question` = CONVERT(0xE2808E372E20D8A7D8B3D98520D981D8A7D8B9D984206461726920D8AED98ED8AAD98ED985D98E206164616C6168E280A6 USING latin1)
WHERE `id` = 'QST00000000000000000353';

-- ------------------------------------------------------------
-- [35/184] QST00000000000000000758 | option | Level 2 / Sublevel 3 / Materi: Al-Qur'an Memanggil
-- Sebelum: 5. فعل ماض dari نَعْبُدُ adalah… 
UPDATE `soal`
SET `question` = CONVERT(0xE2808E352E20D981D8B9D98420D985D8A7D8B6206461726920D986D98ED8B9D992D8A8D98FD8AFD98F206164616C6168E280A620 USING latin1)
WHERE `id` = 'QST00000000000000000758';

-- ------------------------------------------------------------
-- [36/184] QST00000000000000000759 | option | Level 2 / Sublevel 3 / Materi: Al-Qur'an Memanggil
-- Sebelum:  6. فعل مضارع dari عَلِمَ adalah…
UPDATE `soal`
SET `question` = CONVERT(0xE2808E20362E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206461726920D8B9D98ED984D990D985D98E206164616C6168E280A6 USING latin1)
WHERE `id` = 'QST00000000000000000759';

-- ------------------------------------------------------------
-- [37/184] QST00000000000000000712 | option | Level 2 / Sublevel 3 / Materi: Contoh Kedua : Hujan
-- Sebelum: 5. اسم فاعل dari مَاتَ adalah...
UPDATE `soal`
SET `question` = CONVERT(0xE2808E352E20D8A7D8B3D98520D981D8A7D8B9D984206461726920D985D98ED8A7D8AAD98E206164616C61682E2E2E USING latin1)
WHERE `id` = 'QST00000000000000000712';

-- ------------------------------------------------------------
-- [38/184] QST00000000000000000713 | option | Level 2 / Sublevel 3 / Materi: Contoh Kedua : Hujan
-- Sebelum: 6. اسم مفعول dari تَرَكَ adalah...
UPDATE `soal`
SET `question` = CONVERT(0xE2808E362E20D8A7D8B3D98520D985D981D8B9D988D984206461726920D8AAD98ED8B1D98ED983D98E206164616C61682E2E2E USING latin1)
WHERE `id` = 'QST00000000000000000713';

-- ------------------------------------------------------------
-- [39/184] QST00000000000000000680 | option | Level 2 / Sublevel 3 / Materi: Contoh Pertama Munafiqeen: Api
-- Sebelum: 5. فعل ماضٍ dari يَتْرُكُ adalah...
UPDATE `soal`
SET `question` = CONVERT(0xE2808E352E20D981D8B9D98420D985D8A7D8B6D98D206461726920D98AD98ED8AAD992D8B1D98FD983D98F206164616C61682E2E2E USING latin1)
WHERE `id` = 'QST00000000000000000680';

-- ------------------------------------------------------------
-- [40/184] QST00000000000000000681 | option | Level 2 / Sublevel 3 / Materi: Contoh Pertama Munafiqeen: Api
-- Sebelum: 6. فعل امر dari رَجَعَ adalah...
UPDATE `soal`
SET `question` = CONVERT(0xE2808E362E20D981D8B9D98420D8A7D985D8B1206461726920D8B1D98ED8ACD98ED8B9D98E206164616C61682E2E2E USING latin1)
WHERE `id` = 'QST00000000000000000681';

-- ------------------------------------------------------------
-- [41/184] QST00000000000000000798 | option | Level 2 / Sublevel 3 / Materi: Tantangan Al-Qur'an
-- Sebelum: 5. دَعَا adalah...
UPDATE `soal`
SET `question` = CONVERT(0xE2808E352E20D8AFD98ED8B9D98ED8A7206164616C61682E2E2E USING latin1)
WHERE `id` = 'QST00000000000000000798';

-- ------------------------------------------------------------
-- [42/184] QST00000000000000000799 | option | Level 2 / Sublevel 3 / Materi: Tantangan Al-Qur'an
-- Sebelum: 6. اسم مفعول dari صَدَقَ adalah: 
UPDATE `soal`
SET `question` = CONVERT(0xE2808E362E20D8A7D8B3D98520D985D981D8B9D988D984206461726920D8B5D98ED8AFD98ED982D98E206164616C61683A20 USING latin1)
WHERE `id` = 'QST00000000000000000799';

-- ------------------------------------------------------------
-- [43/184] QST00000000000000000885 | option | Level 2 / Sublevel 4 / Materi: Bagaimana Bisa Kafir ?
-- Sebelum: 6. يَرْجِعُ berarti :
UPDATE `soal`
SET `question` = CONVERT(0xE2808E362E20D98AD98ED8B1D992D8ACD990D8B9D98F2062657261727469203A USING latin1)
WHERE `id` = 'QST00000000000000000885';

-- ------------------------------------------------------------
-- [44/184] QST00000000000000000839 | option | Level 2 / Sublevel 4 / Materi: Contoh Nyamuk
-- Sebelum: 6. فعل أمر dari قَالَ adalah...
UPDATE `soal`
SET `question` = CONVERT(0xE2808E362E20D981D8B9D98420D8A3D985D8B1206461726920D982D98ED8A7D984D98E206164616C61682E2E2E USING latin1)
WHERE `id` = 'QST00000000000000000839';

-- ------------------------------------------------------------
-- [45/184] QST00000000000000000861 | option | Level 2 / Sublevel 4 / Materi: Siapa Yang Tersesat ?
-- Sebelum: 5. فعل مضارع dari نَقَضُوْا adalah 
UPDATE `soal`
SET `question` = CONVERT(0xE2808E352E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206461726920D986D98ED982D98ED8B6D98FD988D992D8A7206164616C616820 USING latin1)
WHERE `id` = 'QST00000000000000000861';

-- ------------------------------------------------------------
-- [46/184] QST00000000000000000935 | option | Level 2 / Sublevel 5 / Materi: Ajaran Nama-nama 
-- Sebelum: 5. اسم فاعل dari صَدَقَ adalah…
UPDATE `soal`
SET `question` = CONVERT(0xE2808E352E20D8A7D8B3D98520D981D8A7D8B9D984206461726920D8B5D98ED8AFD98ED982D98E206164616C6168E280A6 USING latin1)
WHERE `id` = 'QST00000000000000000935';

-- ------------------------------------------------------------
-- [47/184] QST00000000000000000936 | option | Level 2 / Sublevel 5 / Materi: Ajaran Nama-nama 
-- Sebelum: 6. فعل أمر dari عَرَضَ adalah… 
UPDATE `soal`
SET `question` = CONVERT(0xE2808E362E20D981D8B9D98420D8A3D985D8B1206461726920D8B9D98ED8B1D98ED8B6D98E206164616C6168E280A620 USING latin1)
WHERE `id` = 'QST00000000000000000936';

-- ------------------------------------------------------------
-- [48/184] QST00000000000000000915 | option | Level 2 / Sublevel 5 / Materi: Pertanyaan Tentang Khalifah 
-- Sebelum: 5. فعل ماض dari سَفْك adalah:
UPDATE `soal`
SET `question` = CONVERT(0xE2808E352E20D981D8B9D98420D985D8A7D8B6206461726920D8B3D98ED981D992D983206164616C61683A USING latin1)
WHERE `id` = 'QST00000000000000000915';

-- ------------------------------------------------------------
-- [49/184] QST00000000000000000955 | option | Level 2 / Sublevel 5 / Materi: Sajdah dan Iblis
-- Sebelum:  5. فعل امر dari أَكَلَ adalah… 
UPDATE `soal`
SET `question` = CONVERT(0xE2808E20352E20D981D8B9D98420D8A7D985D8B1206461726920D8A3D98ED983D98ED984D98E206164616C6168E280A620 USING latin1)
WHERE `id` = 'QST00000000000000000955';

-- ------------------------------------------------------------
-- [50/184] QST00000000000000000956 | option | Level 2 / Sublevel 5 / Materi: Sajdah dan Iblis
-- Sebelum: 6. فعل مضارع dari أَبٰى adalah…
UPDATE `soal`
SET `question` = CONVERT(0xE2808E362E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206461726920D8A3D98ED8A8D9B0D989206164616C6168E280A6 USING latin1)
WHERE `id` = 'QST00000000000000000956';

-- ------------------------------------------------------------
-- [51/184] QST00000000000000000982 | option | Level 2 / Sublevel 5 / Materi: Slip dan Tawbah
-- Sebelum: 5. فعل امر dari هَبَطَ adalah… 
UPDATE `soal`
SET `question` = CONVERT(0xE2808E352E20D981D8B9D98420D8A7D985D8B1206461726920D987D98ED8A8D98ED8B7D98E206164616C6168E280A620 USING latin1)
WHERE `id` = 'QST00000000000000000982';

-- ------------------------------------------------------------
-- [52/184] QST00000000000000000983 | option | Level 2 / Sublevel 5 / Materi: Slip dan Tawbah
-- Sebelum: 6. فعل مضارع dari تَابَ adalah…
UPDATE `soal`
SET `question` = CONVERT(0xE2808E362E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206461726920D8AAD98ED8A7D8A8D98E206164616C6168E280A6 USING latin1)
WHERE `id` = 'QST00000000000000000983';

-- ------------------------------------------------------------
-- [53/184] FQT00000000000000000495 | option | Level 3 / Sublevel 1 | Ujian Pelajaran
-- Sebelum: 4. فعل مضارع dari هَبَطَ adalah:
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E342E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206461726920D987D98ED8A8D98ED8B7D98E206164616C61683A USING latin1)
WHERE `id` = 'FQT00000000000000000495';

-- ------------------------------------------------------------
-- [54/184] FQT00000000000000000499 | option | Level 3 / Sublevel 1 | Ujian Pelajaran
-- Sebelum: 8. فعل أمر dari لَبَسَ adalah:
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E382E20D981D8B9D98420D8A3D985D8B1206461726920D984D98ED8A8D98ED8B3D98E206164616C61683A USING latin1)
WHERE `id` = 'FQT00000000000000000499';

-- ------------------------------------------------------------
-- [55/184] FQT00000000000000000504 | option | Level 3 / Sublevel 1 | Ujian Pelajaran
-- Sebelum: 13. فعل أمر dari تَلَا adalah...
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E31332E20D981D8B9D98420D8A3D985D8B1206461726920D8AAD98ED984D98ED8A7206164616C61682E2E2E USING latin1)
WHERE `id` = 'FQT00000000000000000504';

-- ------------------------------------------------------------
-- [56/184] FQT00000000000000000509 | option | Level 3 / Sublevel 1 | Ujian Pelajaran
-- Sebelum: 18. اسم مفعول dari فَضَّلَ adalah...
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E31382E20D8A7D8B3D98520D985D981D8B9D988D984206461726920D981D98ED8B6D991D98ED984D98E206164616C61682E2E2E USING latin1)
WHERE `id` = 'FQT00000000000000000509';

-- ------------------------------------------------------------
-- [57/184] FQT00000000000000000510 | option | Level 3 / Sublevel 1 | Ujian Pelajaran
-- Sebelum: 18. اسم مفعول dari فَضَّلَ adalah...
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E31382E20D8A7D8B3D98520D985D981D8B9D988D984206461726920D981D98ED8B6D991D98ED984D98E206164616C61682E2E2E USING latin1)
WHERE `id` = 'FQT00000000000000000510';

-- ------------------------------------------------------------
-- [58/184] FQT00000000000000000533 | option | Level 3 / Sublevel 2 | Ujian Pelajaran
-- Sebelum: 3. فعل مضارع dari فَرَقَ adalah:
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E332E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206461726920D981D98ED8B1D98ED982D98E206164616C61683A USING latin1)
WHERE `id` = 'FQT00000000000000000533';

-- ------------------------------------------------------------
-- [59/184] FQT00000000000000000534 | option | Level 3 / Sublevel 2 | Ujian Pelajaran
-- Sebelum: 4. مفعول اسم dari ذَبَّحَ adalah…
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E342E20D985D981D8B9D988D98420D8A7D8B3D985206461726920D8B0D98ED8A8D991D98ED8ADD98E206164616C6168E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000534';

-- ------------------------------------------------------------
-- [60/184] FQT00000000000000000539 | option | Level 3 / Sublevel 2 | Ujian Pelajaran
-- Sebelum: 9. فعل أمر dari وَاعَدَ adalah
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E392E20D981D8B9D98420D8A3D985D8B1206461726920D988D98ED8A7D8B9D98ED8AFD98E206164616C6168 USING latin1)
WHERE `id` = 'FQT00000000000000000539';

-- ------------------------------------------------------------
-- [61/184] FQT00000000000000000543 | option | Level 3 / Sublevel 2 | Ujian Pelajaran
-- Sebelum: 13. فعل امر dari تَابَ adalah…
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E31332E20D981D8B9D98420D8A7D985D8B1206461726920D8AAD98ED8A7D8A8D98E206164616C6168E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000543';

-- ------------------------------------------------------------
-- [62/184] FQT00000000000000000548 | option | Level 3 / Sublevel 2 | Ujian Pelajaran
-- Sebelum: 18. اسم مفعول dari اٰمَنَ adalah…
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E31382E20D8A7D8B3D98520D985D981D8B9D988D984206461726920D8A7D9B0D985D98ED986D98E206164616C6168E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000548';

-- ------------------------------------------------------------
-- [63/184] FQT00000000000000000579 | option | Level 3 / Sublevel 3 | Ujian Pelajaran
-- Sebelum: 3. فعل مضارع dari شَاءَ adalah ...
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E332E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206461726920D8B4D98ED8A7D8A1D98E206164616C6168202E2E2E USING latin1)
WHERE `id` = 'FQT00000000000000000579';

-- ------------------------------------------------------------
-- [64/184] FQT00000000000000000592 | option | Level 3 / Sublevel 3 | Ujian Pelajaran
-- Sebelum: 8. فعل امر dari أَكَلَ adalah ..
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E382E20D981D8B9D98420D8A7D985D8B1206461726920D8A3D98ED983D98ED984D98E206164616C6168202E2E USING latin1)
WHERE `id` = 'FQT00000000000000000592';

-- ------------------------------------------------------------
-- [65/184] FQT00000000000000000606 | option | Level 3 / Sublevel 3 | Ujian Pelajaran
-- Sebelum: 13. اسم مفعول dari طَعِمَ adalah ...
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E31332E20D8A7D8B3D98520D985D981D8B9D988D984206461726920D8B7D98ED8B9D990D985D98E206164616C6168202E2E2E USING latin1)
WHERE `id` = 'FQT00000000000000000606';

-- ------------------------------------------------------------
-- [66/184] FQT00000000000000000618 | option | Level 3 / Sublevel 3 | Ujian Pelajaran
-- Sebelum: 18. فعل امر dari ذَلَّ adalah ...
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E31382E20D981D8B9D98420D8A7D985D8B1206461726920D8B0D98ED984D991D98E206164616C6168202E2E2E USING latin1)
WHERE `id` = 'FQT00000000000000000618';

-- ------------------------------------------------------------
-- [67/184] FQT00000000000000000675 | option | Level 3 / Sublevel 4 | Ujian Pelajaran
-- Sebelum: 9. اسم فَاعِل dari ذَكَرَ adalah ....
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E392E20D8A7D8B3D98520D981D98ED8A7D8B9D990D984206461726920D8B0D98ED983D98ED8B1D98E206164616C6168202E2E2E2E USING latin1)
WHERE `id` = 'FQT00000000000000000675';

-- ------------------------------------------------------------
-- [68/184] FQT00000000000000000679 | option | Level 3 / Sublevel 4 | Ujian Pelajaran
-- Sebelum: 13. اسم فاعل dari خَسَأَ adalah: 
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E31332E20D8A7D8B3D98520D981D8A7D8B9D984206461726920D8AED98ED8B3D98ED8A3D98E206164616C61683A20 USING latin1)
WHERE `id` = 'FQT00000000000000000679';

-- ------------------------------------------------------------
-- [69/184] FQT00000000000000000684 | option | Level 3 / Sublevel 4 | Ujian Pelajaran
-- Sebelum: 18. فعل امر dari سَرَّ adalah...
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E31382E20D981D8B9D98420D8A7D985D8B1206461726920D8B3D98ED8B1D991D98E206164616C61682E2E2E USING latin1)
WHERE `id` = 'FQT00000000000000000684';

-- ------------------------------------------------------------
-- [70/184] FQT00000000000000001307 | option | Level 3 / Sublevel 5 | Ujian Pelajaran
-- Sebelum: 3. ل ارع dari ا adalah:
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E332E20D98420D8A7D8B1D8B9206461726920D8A7206164616C61683A USING latin1)
WHERE `id` = 'FQT00000000000000001307';

-- ------------------------------------------------------------
-- [71/184] FQT00000000000000001316 | option | Level 3 / Sublevel 5 | Ujian Pelajaran
-- Sebelum: 12. فعل مضارع dari غَفَل adalah:\n
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E31322E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206461726920D8BAD98ED981D98ED984206164616C61683A0A USING latin1)
WHERE `id` = 'FQT00000000000000001316';

-- ------------------------------------------------------------
-- [72/184] FQT00000000000000001322 | option | Level 3 / Sublevel 5 | Ujian Pelajaran
-- Sebelum: 18. فعل امر dari حَرَّفَ adalah:
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E31382E20D981D8B9D98420D8A7D985D8B1206461726920D8ADD98ED8B1D991D98ED981D98E206164616C61683A USING latin1)
WHERE `id` = 'FQT00000000000000001322';

-- ------------------------------------------------------------
-- [73/184] QST00000000000000000377 | option | Level 3 / Sublevel 1 / Materi: Dakwah Ke Bani Israel 
-- Sebelum: 4. فعل أمر of لَبَسَ adalah…
UPDATE `soal`
SET `question` = CONVERT(0xE2808E342E20D981D8B9D98420D8A3D985D8B1206F6620D984D98ED8A8D98ED8B3D98E206164616C6168E280A6 USING latin1)
WHERE `id` = 'QST00000000000000000377';

-- ------------------------------------------------------------
-- [74/184] QST00000000000000000378 | option | Level 3 / Sublevel 1 / Materi: Dakwah Ke Bani Israel 
-- Sebelum: 5. اسم فَاعِلof رَهِبَ adalah…
UPDATE `soal`
SET `question` = CONVERT(0xE2808E352E20D8A7D8B3D98520D981D98ED8A7D8B9D990D9846F6620D8B1D98ED987D990D8A8D98E206164616C6168E280A6 USING latin1)
WHERE `id` = 'QST00000000000000000378';

-- ------------------------------------------------------------
-- [75/184] QST00000000000000000396 | option | Level 3 / Sublevel 1 / Materi: Lakukan Perbuatan Baik!
-- Sebelum: 5. اسم مفعول dari نَسِيَ  adalah :
UPDATE `soal`
SET `question` = CONVERT(0xE2808E352E20D8A7D8B3D98520D985D981D8B9D988D984206461726920D986D98ED8B3D990D98AD98E20206164616C6168203A USING latin1)
WHERE `id` = 'QST00000000000000000396';

-- ------------------------------------------------------------
-- [76/184] QST00000000000000000397 | option | Level 3 / Sublevel 1 / Materi: Lakukan Perbuatan Baik!
-- Sebelum: 6. فعل أمر  dari تَلَا  adalah :
UPDATE `soal`
SET `question` = CONVERT(0xE2808E362E20D981D8B9D98420D8A3D985D8B120206461726920D8AAD98ED984D98ED8A720206164616C6168203A USING latin1)
WHERE `id` = 'QST00000000000000000397';

-- ------------------------------------------------------------
-- [77/184] QST00000000000000000362 | option | Level 3 / Sublevel 1 / Materi: Pengantar; Hasil Petunjuk
-- Sebelum: 5. فعل مضارع dari هَبَطَ adalah
UPDATE `soal`
SET `question` = CONVERT(0xE2808E352E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206461726920D987D98ED8A8D98ED8B7D98E206164616C6168 USING latin1)
WHERE `id` = 'QST00000000000000000362';

-- ------------------------------------------------------------
-- [78/184] QST00000000000000000363 | option | Level 3 / Sublevel 1 / Materi: Pengantar; Hasil Petunjuk
-- Sebelum: 6. اسم مفعول dari هَدٰى adalah
UPDATE `soal`
SET `question` = CONVERT(0xE2808E362E20D8A7D8B3D98520D985D981D8B9D988D984206461726920D987D98ED8AFD9B0D989206164616C6168 USING latin1)
WHERE `id` = 'QST00000000000000000363';

-- ------------------------------------------------------------
-- [79/184] QST00000000000000001615 | option | Level 3 / Sublevel 1 / Materi: Pengantar; مَزِيْدٌ فِيْه
-- Sebelum: 9. تَعْلِيم dan مُحَاسَبَة sangat penting ........
UPDATE `soal`
SET `question` = CONVERT(0xE2808E392E20D8AAD98ED8B9D992D984D990D98AD9852064616E20D985D98FD8ADD98ED8A7D8B3D98ED8A8D98ED8A92073616E6761742070656E74696E67202E2E2E2E2E2E2E2E USING latin1)
WHERE `id` = 'QST00000000000000001615';

-- ------------------------------------------------------------
-- [80/184] QST00000000000000000415 | option | Level 3 / Sublevel 1 / Materi: Takut Hari!
-- Sebelum: 6. اسم مفعول dari فَضَّلَ adalah:
UPDATE `soal`
SET `question` = CONVERT(0xE2808E362E20D8A7D8B3D98520D985D981D8B9D988D984206461726920D981D98ED8B6D991D98ED984D98E206164616C61683A USING latin1)
WHERE `id` = 'QST00000000000000000415';

-- ------------------------------------------------------------
-- [81/184] QST00000000000000000455 | option | Level 3 / Sublevel 2 / Materi: 40 Malam
-- Sebelum: 6. فعل أمر of وَاعَدَadalah…
UPDATE `soal`
SET `question` = CONVERT(0xE2808E362E20D981D8B9D98420D8A3D985D8B1206F6620D988D98ED8A7D8B9D98ED8AFD98E6164616C6168E280A6 USING latin1)
WHERE `id` = 'QST00000000000000000455';

-- ------------------------------------------------------------
-- [82/184] QST00000000000000000456 | option | Level 3 / Sublevel 2 / Materi: 40 Malam
-- Sebelum: 7. اسم فَاعِل dari ظَلَمَ adalah…
UPDATE `soal`
SET `question` = CONVERT(0xE2808E372E20D8A7D8B3D98520D981D98ED8A7D8B9D990D984206461726920D8B8D98ED984D98ED985D98E206164616C6168E280A6 USING latin1)
WHERE `id` = 'QST00000000000000000456';

-- ------------------------------------------------------------
-- [83/184] QST00000000000000000476 | option | Level 3 / Sublevel 2 / Materi: Bertobat dari Penyembahan Anak Sapi
-- Sebelum: 6. اسم مفعول dari  قَالَ  adalah:
UPDATE `soal`
SET `question` = CONVERT(0xE2808E362E20D8A7D8B3D98520D985D981D8B9D988D98420646172692020D982D98ED8A7D984D98E20206164616C61683A USING latin1)
WHERE `id` = 'QST00000000000000000476';

-- ------------------------------------------------------------
-- [84/184] QST00000000000000000478 | option | Level 3 / Sublevel 2 / Materi: Bertobat dari Penyembahan Anak Sapi
-- Sebelum: 7. فعل امر dari  تَابَ  adalah:
UPDATE `soal`
SET `question` = CONVERT(0xE2808E372E20D981D8B9D98420D8A7D985D8B120646172692020D8AAD98ED8A7D8A8D98E20206164616C61683A USING latin1)
WHERE `id` = 'QST00000000000000000478';

-- ------------------------------------------------------------
-- [85/184] QST00000000000000000434 | option | Level 3 / Sublevel 2 / Materi: Penyelamatan dari Fir'aun
-- Sebelum: 5. فعل مضارع dari فَرَقَ adalah:
UPDATE `soal`
SET `question` = CONVERT(0xE2808E352E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206461726920D981D98ED8B1D98ED982D98E206164616C61683A USING latin1)
WHERE `id` = 'QST00000000000000000434';

-- ------------------------------------------------------------
-- [86/184] QST00000000000000000435 | option | Level 3 / Sublevel 2 / Materi: Penyelamatan dari Fir'aun
-- Sebelum: 6. مفعول اسم dari ذَبَّحَ adalah:
UPDATE `soal`
SET `question` = CONVERT(0xE2808E362E20D985D981D8B9D988D98420D8A7D8B3D985206461726920D8B0D98ED8A8D991D98ED8ADD98E206164616C61683A USING latin1)
WHERE `id` = 'QST00000000000000000435';

-- ------------------------------------------------------------
-- [87/184] QST00000000000000000501 | option | Level 3 / Sublevel 2 / Materi: Tunjukan Pada Allah!
-- Sebelum: 5. فاعل اسم dari رَأٰى adalah:
UPDATE `soal`
SET `question` = CONVERT(0xE2808E352E20D981D8A7D8B9D98420D8A7D8B3D985206461726920D8B1D98ED8A3D9B0D989206164616C61683A USING latin1)
WHERE `id` = 'QST00000000000000000501';

-- ------------------------------------------------------------
-- [88/184] QST00000000000000000502 | option | Level 3 / Sublevel 2 / Materi: Tunjukan Pada Allah!
-- Sebelum: 6. اسم مفعول dari اٰمَنَ adalah:
UPDATE `soal`
SET `question` = CONVERT(0xE2808E362E20D8A7D8B3D98520D985D981D8B9D988D984206461726920D8A7D9B0D985D98ED986D98E206164616C61683A USING latin1)
WHERE `id` = 'QST00000000000000000502';

-- ------------------------------------------------------------
-- [89/184] QST00000000000000000561 | option | Level 3 / Sublevel 3 / Materi: Do'a Untuk Air
-- Sebelum: 6. فعل امر dari أَكَلَ adalah…
UPDATE `soal`
SET `question` = CONVERT(0xE2808E362E20D981D8B9D98420D8A7D985D8B1206461726920D8A3D98ED983D98ED984D98E206164616C6168E280A6 USING latin1)
WHERE `id` = 'QST00000000000000000561';

-- ------------------------------------------------------------
-- [90/184] QST00000000000000000562 | option | Level 3 / Sublevel 3 / Materi: Do'a Untuk Air
-- Sebelum: 7. اسم فَاعِل dari عَثِيَ adalah…
UPDATE `soal`
SET `question` = CONVERT(0xE2808E372E20D8A7D8B3D98520D981D98ED8A7D8B9D990D984206461726920D8B9D98ED8ABD990D98AD98E206164616C6168E280A6 USING latin1)
WHERE `id` = 'QST00000000000000000562';

-- ------------------------------------------------------------
-- [91/184] QST00000000000000000654 | option | Level 3 / Sublevel 3 / Materi: Hukuman 
-- Sebelum: 5. فعل امر dari ذَلَّ adalah:
UPDATE `soal`
SET `question` = CONVERT(0xE2808E352E20D981D8B9D98420D8A7D985D8B1206461726920D8B0D98ED984D991D98E206164616C61683A USING latin1)
WHERE `id` = 'QST00000000000000000654';

-- ------------------------------------------------------------
-- [92/184] QST00000000000000000656 | option | Level 3 / Sublevel 3 / Materi: Hukuman 
-- Sebelum: 6. اسم مفعول dari عَصٰى adalah:
UPDATE `soal`
SET `question` = CONVERT(0xE2808E362E20D8A7D8B3D98520D985D981D8B9D988D984206461726920D8B9D98ED8B5D9B0D989206164616C61683A USING latin1)
WHERE `id` = 'QST00000000000000000656';

-- ------------------------------------------------------------
-- [93/184] QST00000000000000000524 | option | Level 3 / Sublevel 3 / Materi: Masuk ke Kota
-- Sebelum: 5. فعل مضارع dari شَاءَ adalah:
UPDATE `soal`
SET `question` = CONVERT(0xE2808E352E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206461726920D8B4D98ED8A7D8A1D98E206164616C61683A USING latin1)
WHERE `id` = 'QST00000000000000000524';

-- ------------------------------------------------------------
-- [94/184] QST00000000000000000526 | option | Level 3 / Sublevel 3 / Materi: Masuk ke Kota
-- Sebelum: 6. مفعول اسم dari زَادَ adalah:
UPDATE `soal`
SET `question` = CONVERT(0xE2808E362E20D985D981D8B9D988D98420D8A7D8B3D985206461726920D8B2D98ED8A7D8AFD98E206164616C61683A USING latin1)
WHERE `id` = 'QST00000000000000000526';

-- ------------------------------------------------------------
-- [95/184] QST00000000000000000620 | option | Level 3 / Sublevel 3 / Materi: Permintaan Makanan 
-- Sebelum: 6. اسم فاعل dari سَأَلَ adalah:
UPDATE `soal`
SET `question` = CONVERT(0xE2808E362E20D8A7D8B3D98520D981D8A7D8B9D984206461726920D8B3D98ED8A3D98ED984D98E206164616C61683A USING latin1)
WHERE `id` = 'QST00000000000000000620';

-- ------------------------------------------------------------
-- [96/184] QST00000000000000000621 | option | Level 3 / Sublevel 3 / Materi: Permintaan Makanan 
-- Sebelum: 7. اسم مفعول dari طَعِمَ adalah:
UPDATE `soal`
SET `question` = CONVERT(0xE2808E372E20D8A7D8B3D98520D985D981D8B9D988D984206461726920D8B7D98ED8B9D990D985D98E206164616C61683A USING latin1)
WHERE `id` = 'QST00000000000000000621';

-- ------------------------------------------------------------
-- [97/184] QST00000000000000000696 | option | Level 3 / Sublevel 4 / Materi: Aturan Iman dan Perbuatan!
-- Sebelum: 6. فعل أمر dari خَافَ adalah…
UPDATE `soal`
SET `question` = CONVERT(0xE2808E362E20D981D8B9D98420D8A3D985D8B1206461726920D8AED98ED8A7D981D98E206164616C6168E280A6 USING latin1)
WHERE `id` = 'QST00000000000000000696';

-- ------------------------------------------------------------
-- [98/184] QST00000000000000001022 | option | Level 3 / Sublevel 4 / Materi: Cerita Sapi! 
-- Sebelum: 5. فعل مضارع dari هَزَأَ adalah:
UPDATE `soal`
SET `question` = CONVERT(0xE2808E352E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206461726920D987D98ED8B2D98ED8A3D98E206164616C61683A USING latin1)
WHERE `id` = 'QST00000000000000001022';

-- ------------------------------------------------------------
-- [99/184] QST00000000000000001023 | option | Level 3 / Sublevel 4 / Materi: Cerita Sapi! 
-- Sebelum: 6. فعل امر dari سَرَّ  adalah:
UPDATE `soal`
SET `question` = CONVERT(0xE2808E362E20D981D8B9D98420D8A7D985D8B1206461726920D8B3D98ED8B1D991D98E20206164616C61683A USING latin1)
WHERE `id` = 'QST00000000000000001023';

-- ------------------------------------------------------------
-- [100/184] QST00000000000000000746 | option | Level 3 / Sublevel 4 / Materi: Janji di bawah Gunung Tursina
-- Sebelum: 5. فعل امر dari كَانَ adalah:
UPDATE `soal`
SET `question` = CONVERT(0xE2808E352E20D981D8B9D98420D8A7D985D8B1206461726920D983D98ED8A7D986D98E206164616C61683A USING latin1)
WHERE `id` = 'QST00000000000000000746';

-- ------------------------------------------------------------
-- [101/184] QST00000000000000000748 | option | Level 3 / Sublevel 4 / Materi: Janji di bawah Gunung Tursina
-- Sebelum: 7. اسم فَاعِل dari ذَكَرَ adalah…
UPDATE `soal`
SET `question` = CONVERT(0xE2808E372E20D8A7D8B3D98520D981D98ED8A7D8B9D990D984206461726920D8B0D98ED983D98ED8B1D98E206164616C6168E280A6 USING latin1)
WHERE `id` = 'QST00000000000000000748';

-- ------------------------------------------------------------
-- [102/184] QST00000000000000000761 | option | Level 3 / Sublevel 4 / Materi: pelanggaran Hari Sabtu 
-- Sebelum: 6. اسم فاعل dari خَسَأَadalah i:
UPDATE `soal`
SET `question` = CONVERT(0xE2808E362E20D8A7D8B3D98520D981D8A7D8B9D984206461726920D8AED98ED8B3D98ED8A3D98E6164616C616820693A USING latin1)
WHERE `id` = 'QST00000000000000000761';

-- ------------------------------------------------------------
-- [103/184] QST00000000000000000762 | option | Level 3 / Sublevel 4 / Materi: pelanggaran Hari Sabtu 
-- Sebelum: 7. فعل امر dari جَعَلَ adalah:
UPDATE `soal`
SET `question` = CONVERT(0xE2808E372E20D981D8B9D98420D8A7D985D8B1206461726920D8ACD98ED8B9D98ED984D98E206164616C61683A USING latin1)
WHERE `id` = 'QST00000000000000000762';

-- ------------------------------------------------------------
-- [104/184] QST00000000000000001073 | option | Level 3 / Sublevel 5 / Materi: Hati Batu 
-- Sebelum: 5. فعل مضارع dari غَفَلَ adalah :
UPDATE `soal`
SET `question` = CONVERT(0xE2808E352E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206461726920D8BAD98ED981D98ED984D98E206164616C6168203A USING latin1)
WHERE `id` = 'QST00000000000000001073';

-- ------------------------------------------------------------
-- [105/184] QST00000000000000001074 | option | Level 3 / Sublevel 5 / Materi: Hati Batu 
-- Sebelum: 6. فعل امر dari تَفَجَّرَ adalah :
UPDATE `soal`
SET `question` = CONVERT(0xE2808E362E20D981D8B9D98420D8A7D985D8B1206461726920D8AAD98ED981D98ED8ACD991D98ED8B1D98E206164616C6168203A USING latin1)
WHERE `id` = 'QST00000000000000001074';

-- ------------------------------------------------------------
-- [106/184] QST00000000000000001093 | option | Level 3 / Sublevel 5 / Materi: Mereka Berubah dan Bersembunyi 
-- Sebelum: 5. فعل ماض dari يَطْمَعُ adalah:
UPDATE `soal`
SET `question` = CONVERT(0xE2808E352E20D981D8B9D98420D985D8A7D8B6206461726920D98AD98ED8B7D992D985D98ED8B9D98F206164616C61683A USING latin1)
WHERE `id` = 'QST00000000000000001093';

-- ------------------------------------------------------------
-- [107/184] QST00000000000000001094 | option | Level 3 / Sublevel 5 / Materi: Mereka Berubah dan Bersembunyi 
-- Sebelum: 6. اسم مفعول dari حَاجَّ adalah:
UPDATE `soal`
SET `question` = CONVERT(0xE2808E362E20D8A7D8B3D98520D985D981D8B9D988D984206461726920D8ADD98ED8A7D8ACD991D98E206164616C61683A USING latin1)
WHERE `id` = 'QST00000000000000001094';

-- ------------------------------------------------------------
-- [108/184] QST00000000000000001095 | option | Level 3 / Sublevel 5 / Materi: Mereka Berubah dan Bersembunyi 
-- Sebelum: 7. فعل امر dari حَرَّفَ adalah:
UPDATE `soal`
SET `question` = CONVERT(0xE2808E372E20D981D8B9D98420D8A7D985D8B1206461726920D8ADD98ED8B1D991D98ED981D98E206164616C61683A USING latin1)
WHERE `id` = 'QST00000000000000001095';

-- ------------------------------------------------------------
-- [109/184] QST00000000000000003205 | option | Level 3 / Sublevel 5 / Materi: Pembunuh
-- Sebelum: 5. فعل مضارع dari قَتَلَ adalah:
UPDATE `soal`
SET `question` = CONVERT(0xE2808E352E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206461726920D982D98ED8AAD98ED984D98E206164616C61683A USING latin1)
WHERE `id` = 'QST00000000000000003205';

-- ------------------------------------------------------------
-- [110/184] QST00000000000000003206 | option | Level 3 / Sublevel 5 / Materi: Pembunuh
-- Sebelum: 6. فعل مضارع dari كَتَمَ adalah:
UPDATE `soal`
SET `question` = CONVERT(0xE2808E362E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206461726920D983D98ED8AAD98ED985D98E206164616C61683A USING latin1)
WHERE `id` = 'QST00000000000000003206';

-- ------------------------------------------------------------
-- [111/184] QST00000000000000001043 | option | Level 3 / Sublevel 5 / Materi: Pertanyaan Ketiga
-- Sebelum: 5. فعل مضارع dari دَعَا iadalah:
UPDATE `soal`
SET `question` = CONVERT(0xE2808E352E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206461726920D8AFD98ED8B9D98ED8A720696164616C61683A USING latin1)
WHERE `id` = 'QST00000000000000001043';

-- ------------------------------------------------------------
-- [112/184] QST00000000000000001044 | option | Level 3 / Sublevel 5 / Materi: Pertanyaan Ketiga
-- Sebelum: 6. اسم مفعول dari سَقٰى iadalah:
UPDATE `soal`
SET `question` = CONVERT(0xE2808E362E20D8A7D8B3D98520D985D981D8B9D988D984206461726920D8B3D98ED982D9B0D98920696164616C61683A USING latin1)
WHERE `id` = 'QST00000000000000001044';

-- ------------------------------------------------------------
-- [113/184] FQT00000000000000001065 | drag | Level 4 | Final Test
-- Sebelum: 9. فعل مضارع dari خَلَدَ adalah...
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E392E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206461726920D8AED98ED984D98ED8AFD98E206164616C61682E2E2E USING latin1)
WHERE `id` = 'FQT00000000000000001065';

-- ------------------------------------------------------------
-- [114/184] FQT00000000000000001073 | drag | Level 4 | Final Test
-- Sebelum: 15. فعل أمر dari حَرَّمَ adalah...
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E31352E20D981D8B9D98420D8A3D985D8B1206461726920D8ADD98ED8B1D98ED991D985D98E206164616C61682E2E2E USING latin1)
WHERE `id` = 'FQT00000000000000001073';

-- ------------------------------------------------------------
-- [115/184] FQT00000000000000001078 | drag | Level 4 | Final Test
-- Sebelum: 20. فعل مضارع dari قَلَّ adalah...
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E32302E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206461726920D982D98ED984D98ED991206164616C61682E2E2E USING latin1)
WHERE `id` = 'FQT00000000000000001078';

-- ------------------------------------------------------------
-- [116/184] FQT00000000000000001086 | option | Level 4 | Final Test
-- Sebelum: 27. فعل مضارع dari اِتَّخَذَ adalah…
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E32372E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206461726920D8A7D990D8AAD991D98ED8AED98ED8B0D98E206164616C6168E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000001086';

-- ------------------------------------------------------------
-- [117/184] FQT00000000000000001097 | option | Level 4 | Final Test
-- Sebelum: 35. فعل أمر dari وَجَدَ adalah...
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E33352E20D981D8B9D98420D8A3D985D8B1206461726920D988D98ED8ACD98ED8AFD98E206164616C61682E2E2E USING latin1)
WHERE `id` = 'FQT00000000000000001097';

-- ------------------------------------------------------------
-- [118/184] FQT00000000000000001100 | option | Level 4 | Final Test
-- Sebelum: 38. فعل مضارع dari فَسَقَ adalah... 
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E33382E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206461726920D981D98ED8B3D98ED982D98E206164616C61682E2E2E20 USING latin1)
WHERE `id` = 'FQT00000000000000001100';

-- ------------------------------------------------------------
-- [119/184] FQT00000000000000001103 | option | Level 4 | Final Test
-- Sebelum: 40. فعل مضارع dari عَاهَدَ adalah...
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E34302E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206461726920D8B9D98ED8A7D987D98ED8AFD98E206164616C61682E2E2E USING latin1)
WHERE `id` = 'FQT00000000000000001103';

-- ------------------------------------------------------------
-- [120/184] FQT00000000000000001111 | option | Level 4 | Final Test
-- Sebelum: 45. فعل أمر dari تَعَلَّمَ adalah...
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E34352E20D981D8B9D98420D8A3D985D8B1206461726920D8AAD98ED8B9D98ED984D98ED991D985D98E206164616C61682E2E2E USING latin1)
WHERE `id` = 'FQT00000000000000001111';

-- ------------------------------------------------------------
-- [121/184] FQT00000000000000001114 | option | Level 4 | Final Test
-- Sebelum: 48. فعل مضارع dari اِتَّقٰى adalah... 
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E34382E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206461726920D8A7D990D8AAD98ED991D982D9B0D989206164616C61682E2E2E20 USING latin1)
WHERE `id` = 'FQT00000000000000001114';

-- ------------------------------------------------------------
-- [122/184] FQT00000000000000001116 | drag | Level 4 | Final Test
-- Sebelum: 50. فعل مضارع dari اِتَّقٰى adalah...
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E35302E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206461726920D8A7D990D8AAD98ED991D982D9B0D989206164616C61682E2E2E USING latin1)
WHERE `id` = 'FQT00000000000000001116';

-- ------------------------------------------------------------
-- [123/184] FQT00000000000000000827 | option | Level 4 / Sublevel 1 | Ujian Pelajaran
-- Sebelum: 9. فعل مضارع dari خَلَدَ adalah... 
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E392E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206461726920D8AED98ED984D98ED8AFD98E206164616C61682E2E2E20 USING latin1)
WHERE `id` = 'FQT00000000000000000827';

-- ------------------------------------------------------------
-- [124/184] FQT00000000000000000929 | drag | Level 4 / Sublevel 2 | Ujian Pelajaran
-- Sebelum: 6. فعل أمر dari حَرَّمَ adalah…
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E362E20D981D8B9D98420D8A3D985D8B1206461726920D8ADD98ED8B1D991D98ED985D98E206164616C6168E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000929';

-- ------------------------------------------------------------
-- [125/184] FQT00000000000000001304 | option | Level 4 / Sublevel 2 | Ujian Pelajaran
-- Sebelum: 12. فعل مضارع darif قَلَّ adalah…
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E31322E20D981D8B9D98420D985D8B6D8A7D8B1D8B920646172696620D982D98ED984D991D98E206164616C6168E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000001304';

-- ------------------------------------------------------------
-- [126/184] FQT00000000000000000973 | option | Level 4 / Sublevel 3 | Ujian Pelajaran
-- Sebelum: 9. فعل مضارع dari اِتَّخَذَ adalah...
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E392E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206461726920D8A7D990D8AAD98ED991D8AED98ED8B0D98E206164616C61682E2E2E USING latin1)
WHERE `id` = 'FQT00000000000000000973';

-- ------------------------------------------------------------
-- [127/184] FQT00000000000000001006 | option | Level 4 / Sublevel 4 | Ujian Pelajaran
-- Sebelum: 6. فعل أمر dari وَجَدَ adalah…
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E362E20D981D8B9D98420D8A3D985D8B1206461726920D988D98ED8ACD98ED8AFD98E206164616C6168E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000001006';

-- ------------------------------------------------------------
-- [128/184] FQT00000000000000001012 | option | Level 4 / Sublevel 4 | Ujian Pelajaran
-- Sebelum: 9. فعل مضارع dari فَسَقَ adalah... 
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E392E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206461726920D981D98ED8B3D98ED982D98E206164616C61682E2E2E20 USING latin1)
WHERE `id` = 'FQT00000000000000001012';

-- ------------------------------------------------------------
-- [129/184] FQT00000000000000001014 | option | Level 4 / Sublevel 4 | Ujian Pelajaran
-- Sebelum: 9. فعل مضارع dari فَسَقَ adalah... 
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E392E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206461726920D981D98ED8B3D98ED982D98E206164616C61682E2E2E20 USING latin1)
WHERE `id` = 'FQT00000000000000001014';

-- ------------------------------------------------------------
-- [130/184] FQT00000000000000001016 | option | Level 4 / Sublevel 4 | Ujian Pelajaran
-- Sebelum: 12. فعل مضارع dari عَاهَدَ adalah… 
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E31322E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206461726920D8B9D98ED8A7D987D98ED8AFD98E206164616C6168E280A620 USING latin1)
WHERE `id` = 'FQT00000000000000001016';

-- ------------------------------------------------------------
-- [131/184] FQT00000000000000000712 | option | Level 4 / Sublevel 5 | Ujian Pelajaran
-- Sebelum: 6. فعل أمر dari تَعَلَّمَ adalah....
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E362E20D981D8B9D98420D8A3D985D8B1206461726920D8AAD98ED8B9D98ED984D991D98ED985D98E206164616C61682E2E2E2E USING latin1)
WHERE `id` = 'FQT00000000000000000712';

-- ------------------------------------------------------------
-- [132/184] FQT00000000000000000715 | option | Level 4 / Sublevel 5 | Ujian Pelajaran
-- Sebelum: 9. فعل مضارع dari اِتَّقٰى adalah.......
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E392E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206461726920D8A7D990D8AAD991D98ED982D9B0D989206164616C61682E2E2E2E2E2E2E USING latin1)
WHERE `id` = 'FQT00000000000000000715';

-- ------------------------------------------------------------
-- [133/184] FQT00000000000000000718 | option | Level 4 / Sublevel 5 | Ujian Pelajaran
-- Sebelum: 12. فعل مضارع dari اِتَّقٰى adalah....
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E31322E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206461726920D8A7D990D8AAD991D98ED982D9B0D989206164616C61682E2E2E2E USING latin1)
WHERE `id` = 'FQT00000000000000000718';

-- ------------------------------------------------------------
-- [134/184] FQT00000000000000000897 | option | Level 4 / Sublevel 1 | Ujian Grammer
-- Sebelum: 1. أَنْتُمْ merupakan kata ?
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E312E20D8A3D98ED986D992D8AAD98FD985D992206D65727570616B616E206B617461203F USING latin1)
WHERE `id` = 'FQT00000000000000000897';

-- ------------------------------------------------------------
-- [135/184] QST00000000000000001128 | option | Level 4 / Sublevel 1 / Materi: Api tidak akan menyentuh?
-- Sebelum: 5. فعل مضارع dari عَدَّ adalah…
UPDATE `soal`
SET `question` = CONVERT(0xE2808E352E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206461726920D8B9D98ED8AFD991D98E206164616C6168E280A6 USING latin1)
WHERE `id` = 'QST00000000000000001128';

-- ------------------------------------------------------------
-- [136/184] QST00000000000000001140 | option | Level 4 / Sublevel 1 / Materi: Aturan keadilan
-- Sebelum:  5. فعل مضارع dari خَلَدَ adalah…
UPDATE `soal`
SET `question` = CONVERT(0xE2808E20352E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206461726920D8AED98ED984D98ED8AFD98E206164616C6168E280A6 USING latin1)
WHERE `id` = 'QST00000000000000001140';

-- ------------------------------------------------------------
-- [137/184] QST00000000000000001165 | drag | Level 4 / Sublevel 1 / Materi: Perjanjian Bani Israel
-- Sebelum: 5. فعل مضارع dari أَقَامَ adalah…
UPDATE `soal`
SET `question` = CONVERT(0xE2808E352E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206461726920D8A3D98ED982D98ED8A7D985D98E206164616C6168E280A6 USING latin1)
WHERE `id` = 'QST00000000000000001165';

-- ------------------------------------------------------------
-- [138/184] QST00000000000000001117 | option | Level 4 / Sublevel 1 / Materi: Perkenalan & Fmi. Kata Ganti
-- Sebelum: 1. أَنْتُمْ merupakan kata ?
UPDATE `soal`
SET `question` = CONVERT(0xE2808E312E20D8A3D98ED986D992D8AAD98FD985D992206D65727570616B616E206B617461203F USING latin1)
WHERE `id` = 'QST00000000000000001117';

-- ------------------------------------------------------------
-- [139/184] QST00000000000000001133 | option | Level 4 / Sublevel 1 / Materi: Tabel 3-huruf Verb untuk jenis kelamin feminim
-- Sebelum: 5. اسم فاعل dari : فَعَلَتْ adalah ?
UPDATE `soal`
SET `question` = CONVERT(0xE2808E352E20D8A7D8B3D98520D981D8A7D8B9D9842064617269203A20D981D98ED8B9D98ED984D98ED8AAD992206164616C6168203F USING latin1)
WHERE `id` = 'QST00000000000000001133';

-- ------------------------------------------------------------
-- [140/184] QST00000000000000001213 | drag | Level 4 / Sublevel 2 / Materi: Pembunuhan & pengusiran
-- Sebelum: 5. فعل أمر dari حَرَّمَ adalah… 
UPDATE `soal`
SET `question` = CONVERT(0xE2808E352E20D981D8B9D98420D8A3D985D8B1206461726920D8ADD98ED8B1D991D98ED985D98E206164616C6168E280A620 USING latin1)
WHERE `id` = 'QST00000000000000001213';

-- ------------------------------------------------------------
-- [141/184] QST00000000000000001277 | drag | Level 4 / Sublevel 2 / Materi: Perawatan dengan Musa & Isa & Rasul lainnya
-- Sebelum: 5. فعل مضارع dari قَلَّ adalah…
UPDATE `soal`
SET `question` = CONVERT(0xE2808E352E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206461726920D982D98ED984D991D98E206164616C6168E280A6 USING latin1)
WHERE `id` = 'QST00000000000000001277';

-- ------------------------------------------------------------
-- [142/184] QST00000000000000001254 | drag | Level 4 / Sublevel 2 / Materi: Percaya pada bagian?
-- Sebelum: 5. فعل مضارع dari اِشْتَرٰى adalah…
UPDATE `soal`
SET `question` = CONVERT(0xE2808E352E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206461726920D8A7D990D8B4D992D8AAD98ED8B1D9B0D989206164616C6168E280A6 USING latin1)
WHERE `id` = 'QST00000000000000001254';

-- ------------------------------------------------------------
-- [143/184] QST00000000000000001263 | drag | Level 4 / Sublevel 2 / Materi: Pola كرم, حسب
-- Sebelum: 5.  اسم فاعل dari : كَرُم adalah 
UPDATE `soal`
SET `question` = CONVERT(0xE2808E352E2020D8A7D8B3D98520D981D8A7D8B9D9842064617269203A20D983D98ED8B1D98FD985206164616C616820 USING latin1)
WHERE `id` = 'QST00000000000000001263';

-- ------------------------------------------------------------
-- [144/184] QST00000000000000001334 | drag | Level 4 / Sublevel 3 / Materi: " Kami percaya pada buku kami "
-- Sebelum: 5. فعل مضارع dari اِتَّخَذَ adalah…
UPDATE `soal`
SET `question` = CONVERT(0xE2808E352E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206461726920D8A7D990D8AAD991D98ED8AED98ED8B0D98E206164616C6168E280A6 USING latin1)
WHERE `id` = 'QST00000000000000001334';

-- ------------------------------------------------------------
-- [145/184] QST00000000000000001356 | drag | Level 4 / Sublevel 3 / Materi: Perjanjian gunung tursinai
-- Sebelum: 5. فعل مضارع dari عَصٰى adalah…
UPDATE `soal`
SET `question` = CONVERT(0xE2808E352E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206461726920D8B9D98ED8B5D9B0D989206164616C6168E280A6 USING latin1)
WHERE `id` = 'QST00000000000000001356';

-- ------------------------------------------------------------
-- [146/184] QST00000000000000001311 | drag | Level 4 / Sublevel 3 / Materi: Transaksi jahat kufur
-- Sebelum: 5. فعل أمر dari أَهَانَ adalah…
UPDATE `soal`
SET `question` = CONVERT(0xE2808E352E20D981D8B9D98420D8A3D985D8B1206461726920D8A3D98ED987D98ED8A7D986D98E206164616C6168E280A6 USING latin1)
WHERE `id` = 'QST00000000000000001311';

-- ------------------------------------------------------------
-- [147/184] QST00000000000000001400 | option | Level 4 / Sublevel 4 / Materi: Bermusuhan dengan jibril
-- Sebelum: 5. فعل مضارع dari فَسَقَ adalah… 
UPDATE `soal`
SET `question` = CONVERT(0xE2808E352E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206461726920D981D98ED8B3D98ED982D98E206164616C6168E280A620 USING latin1)
WHERE `id` = 'QST00000000000000001400';

-- ------------------------------------------------------------
-- [148/184] QST00000000000000001412 | drag | Level 4 / Sublevel 4 / Materi: Buang janji
-- Sebelum: 5. فعل مضارع dari عَاهَدَ adalah…
UPDATE `soal`
SET `question` = CONVERT(0xE2808E352E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206461726920D8B9D98ED8A7D987D98ED8AFD98E206164616C6168E280A6 USING latin1)
WHERE `id` = 'QST00000000000000001412';

-- ------------------------------------------------------------
-- [149/184] QST00000000000000001388 | option | Level 4 / Sublevel 4 / Materi: Mereka mencintai hidup ini
-- Sebelum: 5. فعل أمر dari وَجَدَ adalah…
UPDATE `soal`
SET `question` = CONVERT(0xE2808E352E20D981D8B9D98420D8A3D985D8B1206461726920D988D98ED8ACD98ED8AFD98E206164616C6168E280A6 USING latin1)
WHERE `id` = 'QST00000000000000001388';

-- ------------------------------------------------------------
-- [150/184] QST00000000000000001460 | drag | Level 4 / Sublevel 5 / Materi: Jangan katakan Ra'ina
-- Sebelum: 5. فعل مضارع dari اِتَّقٰى adalah…
UPDATE `soal`
SET `question` = CONVERT(0xE2808E352E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206461726920D8A7D990D8AAD991D98ED982D9B0D989206164616C6168E280A6 USING latin1)
WHERE `id` = 'QST00000000000000001460';

-- ------------------------------------------------------------
-- [151/184] QST00000000000000001435 | option | Level 4 / Sublevel 5 / Materi: Memisahkan suami & istri
-- Sebelum: 5. فعل أمر dari تَعَلَّمَ adalah...
UPDATE `soal`
SET `question` = CONVERT(0xE2808E352E20D981D8B9D98420D8A3D985D8B1206461726920D8AAD98ED8B9D98ED984D98ED991D985D98E206164616C61682E2E2E USING latin1)
WHERE `id` = 'QST00000000000000001435';

-- ------------------------------------------------------------
-- [152/184] QST00000000000000001447 | drag | Level 4 / Sublevel 5 / Materi: Perdagangan jahat, secara sadar
-- Sebelum: 4. فعل مضارع dari اِتَّقٰى adalah…
UPDATE `soal`
SET `question` = CONVERT(0xE2808E342E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206461726920D8A7D990D8AAD991D98ED982D9B0D989206164616C6168E280A6 USING latin1)
WHERE `id` = 'QST00000000000000001447';

-- ------------------------------------------------------------
-- [153/184] FQT00000000000000000800 | drag | Level 5 | Final Test
-- Sebelum: 5. فعل أمر dari تَبَدَّلَ adalah…
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E352E20D981D8B9D98420D8A3D985D8B1206461726920D8AAD98ED8A8D98ED8AFD991D98ED984D98E206164616C6168E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000800';

-- ------------------------------------------------------------
-- [154/184] FQT00000000000000000803 | drag | Level 5 | Final Test
-- Sebelum: 8. فعل مضارع dari قَدَّمَ adalah…
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E382E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206461726920D982D98ED8AFD991D98ED985D98E206164616C6168E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000803';

-- ------------------------------------------------------------
-- [155/184] FQT00000000000000000809 | drag | Level 5 | Final Test
-- Sebelum: 14. فعل أمر dari سَعٰى adalah…
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E31342E20D981D8B9D98420D8A3D985D8B1206461726920D8B3D98ED8B9D9B0D989206164616C6168E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000809';

-- ------------------------------------------------------------
-- [156/184] FQT00000000000000000823 | drag | Level 5 | Final Test
-- Sebelum: 22. فعل أمر dari نَصَرَ adalah…
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E32322E20D981D8B9D98420D8A3D985D8B1206461726920D986D98ED8B5D98ED8B1D98E206164616C6168E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000823';

-- ------------------------------------------------------------
-- [157/184] FQT00000000000000000833 | drag | Level 5 | Final Test
-- Sebelum: 25. فعل مضارع dari عَهِدَ adalah…
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E32352E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206461726920D8B9D98ED987D990D8AFD98E206164616C6168E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000833';

-- ------------------------------------------------------------
-- [158/184] FQT00000000000000000836 | drag | Level 5 | Final Test
-- Sebelum: 28. فعل مضارع dari قَلَّ adalah…
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E32382E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206461726920D982D98ED984D991D98E206164616C6168E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000836';

-- ------------------------------------------------------------
-- [159/184] FQT00000000000000000845 | option | Level 5 | Final Test
-- Sebelum: 37. فعل مضارع dari مَاتَ adalah…
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E33372E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206461726920D985D98ED8A7D8AAD98E206164616C6168E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000845';

-- ------------------------------------------------------------
-- [160/184] FQT00000000000000000852 | option | Level 5 | Final Test
-- Sebelum: 44. فعل أمر dari تَوَلّٰى adalah…
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E34342E20D981D8B9D98420D8A3D985D8B1206461726920D8AAD98ED988D98ED984D991D9B0D989206164616C6168E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000852';

-- ------------------------------------------------------------
-- [161/184] FQT00000000000000000741 | option | Level 5 / Sublevel 1 | Ujian Pelajaran
-- Sebelum: 6. فعل أمر dari تَبَدَّلَ adalah…
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E362E20D981D8B9D98420D8A3D985D8B1206461726920D8AAD98ED8A8D98ED8AFD991D98ED984D98E206164616C6168E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000741';

-- ------------------------------------------------------------
-- [162/184] FQT00000000000000000744 | option | Level 5 / Sublevel 1 | Ujian Pelajaran
-- Sebelum: 9. فعل مضارع dari قَدَّمَ adalah…
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E392E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206461726920D982D98ED8AFD991D98ED985D98E206164616C6168E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000744';

-- ------------------------------------------------------------
-- [163/184] FQT00000000000000000747 | option | Level 5 / Sublevel 1 | Ujian Pelajaran
-- Sebelum: 12. فعل مضارع dari خَافَ adalah…
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E31322E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206461726920D8AED98ED8A7D981D98E206164616C6168E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000747';

-- ------------------------------------------------------------
-- [164/184] FQT00000000000000000753 | option | Level 5 / Sublevel 2 | Ujian Pelajaran
-- Sebelum: 6. فعل أمر dari سَعٰى adalah…
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E362E20D981D8B9D98420D8A3D985D8B1206461726920D8B3D98ED8B9D9B0D989206164616C6168E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000753';

-- ------------------------------------------------------------
-- [165/184] FQT00000000000000000765 | option | Level 5 / Sublevel 3 | Ujian Pelajaran
-- Sebelum: 6. فعل أمر dari نَصَرَ adalah…
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E362E20D981D8B9D98420D8A3D985D8B1206461726920D986D98ED8B5D98ED8B1D98E206164616C6168E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000765';

-- ------------------------------------------------------------
-- [166/184] FQT00000000000000000768 | option | Level 5 / Sublevel 3 | Ujian Pelajaran
-- Sebelum: 9. فعل مضارع dari عَهِدَ adalah…
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E392E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206461726920D8B9D98ED987D990D8AFD98E206164616C6168E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000768';

-- ------------------------------------------------------------
-- [167/184] FQT00000000000000000771 | option | Level 5 / Sublevel 3 | Ujian Pelajaran
-- Sebelum: 12. فعل مضارع dari قَلَّ adalah…
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E31322E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206461726920D982D98ED984D991D98E206164616C6168E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000771';

-- ------------------------------------------------------------
-- [168/184] FQT00000000000000000780 | option | Level 5 / Sublevel 4 | Ujian Pelajaran
-- Sebelum: 9. فعل مضارع dari مَاتَ adalah…
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E392E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206461726920D985D98ED8A7D8AAD98E206164616C6168E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000780';

-- ------------------------------------------------------------
-- [169/184] FQT00000000000000000789 | option | Level 5 / Sublevel 5 | Ujian Pelajaran
-- Sebelum: 6. أمر dari تَوَلّٰى adalah…
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E362E20D8A3D985D8B1206461726920D8AAD98ED988D98ED984D991D9B0D989206164616C6168E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000789';

-- ------------------------------------------------------------
-- [170/184] QST00000000000000001196 | option | Level 5 / Sublevel 1 / Materi: Jangan Tanya!
-- Sebelum: 5. فعل أمر dari تَبَدَّلَ adalah…
UPDATE `soal`
SET `question` = CONVERT(0xE2808E352E20D981D8B9D98420D8A3D985D8B1206461726920D8AAD98ED8A8D98ED8AFD991D98ED984D98E206164616C6168E280A6 USING latin1)
WHERE `id` = 'QST00000000000000001196';

-- ------------------------------------------------------------
-- [171/184] QST00000000000000001202 | option | Level 5 / Sublevel 1 / Materi: Keinginan Ahli Kitab
-- Sebelum: 5. فعل مضارع dari قَدَّمَ adalah…
UPDATE `soal`
SET `question` = CONVERT(0xE2808E352E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206461726920D982D98ED8AFD991D98ED985D98E206164616C6168E280A6 USING latin1)
WHERE `id` = 'QST00000000000000001202';

-- ------------------------------------------------------------
-- [172/184] QST00000000000000001207 | option | Level 5 / Sublevel 1 / Materi: Surga Hanya Untuk Orang Yahudi & Kristen ?
-- Sebelum: 5. فعل مضارع dari خَافَ adalah…
UPDATE `soal`
SET `question` = CONVERT(0xE2808E352E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206461726920D8AED98ED8A7D981D98E206164616C6168E280A6 USING latin1)
WHERE `id` = 'QST00000000000000001207';

-- ------------------------------------------------------------
-- [173/184] QST00000000000000001223 | option | Level 5 / Sublevel 2 / Materi: Masjid Blok Yang Tidak Adil
-- Sebelum: 5. فعل أمر dari سَعٰى adalah…
UPDATE `soal`
SET `question` = CONVERT(0xE2808E352E20D981D8B9D98420D8A3D985D8B1206461726920D8B3D98ED8B9D9B0D989206164616C6168E280A6 USING latin1)
WHERE `id` = 'QST00000000000000001223';

-- ------------------------------------------------------------
-- [174/184] QST00000000000000001230 | option | Level 5 / Sublevel 2 / Materi: Nasrani Membuat Seorang Anak Untuk Allah
-- Sebelum: 5. فعل مضارع dari قَالَ adalah…
UPDATE `soal`
SET `question` = CONVERT(0xE2808E352E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206461726920D982D98ED8A7D984D98E206164616C6168E280A6 USING latin1)
WHERE `id` = 'QST00000000000000001230';

-- ------------------------------------------------------------
-- [175/184] QST00000000000000001240 | option | Level 5 / Sublevel 2 / Materi: Orang Bodoh Berkata: Allah Harus Berbicara dengan Mereka
-- Sebelum: 5. فعل مضارع dari كَلَّمَ adalah…
UPDATE `soal`
SET `question` = CONVERT(0xE2808E352E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206461726920D983D98ED984D991D98ED985D98E206164616C6168E280A6 USING latin1)
WHERE `id` = 'QST00000000000000001240';

-- ------------------------------------------------------------
-- [176/184] QST00000000000000001255 | option | Level 5 / Sublevel 3 / Materi: Bani Israel! ingat nikmatnya
-- Sebelum: 5. فعل أمر  dari نَصَرَ adalah… 
UPDATE `soal`
SET `question` = CONVERT(0xE2808E352E20D981D8B9D98420D8A3D985D8B120206461726920D986D98ED8B5D98ED8B1D98E206164616C6168E280A620 USING latin1)
WHERE `id` = 'QST00000000000000001255';

-- ------------------------------------------------------------
-- [177/184] QST00000000000000001276 | option | Level 5 / Sublevel 3 / Materi: Rumah Allah & kota
-- Sebelum: 5. فعل مضارع dari قَلَّ adalah…
UPDATE `soal`
SET `question` = CONVERT(0xE2808E352E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206461726920D982D98ED984D991D98E206164616C6168E280A6 USING latin1)
WHERE `id` = 'QST00000000000000001276';

-- ------------------------------------------------------------
-- [178/184] QST00000000000000001265 | option | Level 5 / Sublevel 3 / Materi: Ujian Ibrahim
-- Sebelum: 5. فعل مضارع dari عَهِدَ adalah…
UPDATE `soal`
SET `question` = CONVERT(0xE2808E352E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206461726920D8B9D98ED987D990D8AFD98E206164616C6168E280A6 USING latin1)
WHERE `id` = 'QST00000000000000001265';

-- ------------------------------------------------------------
-- [179/184] QST00000000000000001332 | option | Level 5 / Sublevel 4 / Materi: Bangsa meninggal
-- Sebelum: 5. فعل مضارع dari سَأَلَ adalah
UPDATE `soal`
SET `question` = CONVERT(0xE2808E352E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206461726920D8B3D98ED8A3D98ED984D98E206164616C6168 USING latin1)
WHERE `id` = 'QST00000000000000001332';

-- ------------------------------------------------------------
-- [180/184] QST00000000000000001322 | option | Level 5 / Sublevel 4 / Materi: Instruksi Ibrahim & Yaqub
-- Sebelum: 5. فعل مضارع dari مَاتَ adalah…
UPDATE `soal`
SET `question` = CONVERT(0xE2808E352E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206461726920D985D98ED8A7D8AAD98E206164616C6168E280A6 USING latin1)
WHERE `id` = 'QST00000000000000001322';

-- ------------------------------------------------------------
-- [181/184] QST00000000000000001295 | option | Level 5 / Sublevel 4 / Materi: Siapa yang akan berpaling dari agama Ibrahim
-- Sebelum: 5. فعل أمر dari أَسْلَمَ adalah…
UPDATE `soal`
SET `question` = CONVERT(0xE2808E352E20D981D8B9D98420D8A3D985D8B1206461726920D8A3D98ED8B3D992D984D98ED985D98E206164616C6168E280A6 USING latin1)
WHERE `id` = 'QST00000000000000001295';

-- ------------------------------------------------------------
-- [182/184] QST00000000000000001364 | option | Level 5 / Sublevel 5 / Materi: Anda membantah tentang Allah
-- Sebelum: 5. فعل مضارع dari أَخْلَصَ adalah…
UPDATE `soal`
SET `question` = CONVERT(0xE2808E352E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206461726920D8A3D98ED8AED992D984D98ED8B5D98E206164616C6168E280A6 USING latin1)
WHERE `id` = 'QST00000000000000001364';

-- ------------------------------------------------------------
-- [183/184] QST00000000000000001353 | option | Level 5 / Sublevel 5 / Materi: Keyakinan yang ideal
-- Sebelum: 5. فعل أمر dari تَوَلّٰى adalah…
UPDATE `soal`
SET `question` = CONVERT(0xE2808E352E20D981D8B9D98420D8A3D985D8B1206461726920D8AAD98ED988D98ED984D991D9B0D989206164616C6168E280A6 USING latin1)
WHERE `id` = 'QST00000000000000001353';

-- ------------------------------------------------------------
-- [184/184] QST00000000000000001373 | option | Level 5 / Sublevel 5 / Materi: Paling tidak adil membunyikan kesaksian
-- Sebelum: 5. فعل مضارع dari كَسَبَ adalah…
UPDATE `soal`
SET `question` = CONVERT(0xE2808E352E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206461726920D983D98ED8B3D98ED8A8D98E206164616C6168E280A6 USING latin1)
WHERE `id` = 'QST00000000000000001373';

COMMIT;

-- ============================================================
-- VERIFIKASI
-- ============================================================

-- 1) Harus 184 baris, semua prefix_hex = E2808E
SELECT 'final_exam' AS tabel, id, HEX(LEFT(question, 3)) AS prefix_hex, question
FROM `final_exam`
WHERE id IN (
  'FQT00000000000000001393',
  'FQT00000000000000001394',
  'FQT00000000000000000173',
  'FQT00000000000000000584',
  'FQT00000000000000000594',
  'FQT00000000000000000596',
  'FQT00000000000000000611',
  'FQT00000000000000000010',
  'FQT00000000000000000021',
  'FQT00000000000000000067',
  'FQT00000000000000000073',
  'FQT00000000000000000079',
  'FQT00000000000000000136',
  'FQT00000000000000000141',
  'FQT00000000000000000146',
  'FQT00000000000000000156',
  'FQT00000000000000000223',
  'FQT00000000000000000239',
  'FQT00000000000000000294',
  'FQT00000000000000000306',
  'FQT00000000000000000315',
  'FQT00000000000000000317',
  'FQT00000000000000000323',
  'FQT00000000000000000495',
  'FQT00000000000000000499',
  'FQT00000000000000000504',
  'FQT00000000000000000509',
  'FQT00000000000000000510',
  'FQT00000000000000000533',
  'FQT00000000000000000534',
  'FQT00000000000000000539',
  'FQT00000000000000000543',
  'FQT00000000000000000548',
  'FQT00000000000000000579',
  'FQT00000000000000000592',
  'FQT00000000000000000606',
  'FQT00000000000000000618',
  'FQT00000000000000000675',
  'FQT00000000000000000679',
  'FQT00000000000000000684',
  'FQT00000000000000001307',
  'FQT00000000000000001316',
  'FQT00000000000000001322',
  'FQT00000000000000001065',
  'FQT00000000000000001073',
  'FQT00000000000000001078',
  'FQT00000000000000001086',
  'FQT00000000000000001097',
  'FQT00000000000000001100',
  'FQT00000000000000001103',
  'FQT00000000000000001111',
  'FQT00000000000000001114',
  'FQT00000000000000001116',
  'FQT00000000000000000827',
  'FQT00000000000000000929',
  'FQT00000000000000001304',
  'FQT00000000000000000973',
  'FQT00000000000000001006',
  'FQT00000000000000001012',
  'FQT00000000000000001014',
  'FQT00000000000000001016',
  'FQT00000000000000000712',
  'FQT00000000000000000715',
  'FQT00000000000000000718',
  'FQT00000000000000000897',
  'FQT00000000000000000800',
  'FQT00000000000000000803',
  'FQT00000000000000000809',
  'FQT00000000000000000823',
  'FQT00000000000000000833',
  'FQT00000000000000000836',
  'FQT00000000000000000845',
  'FQT00000000000000000852',
  'FQT00000000000000000741',
  'FQT00000000000000000744',
  'FQT00000000000000000747',
  'FQT00000000000000000753',
  'FQT00000000000000000765',
  'FQT00000000000000000768',
  'FQT00000000000000000771',
  'FQT00000000000000000780',
  'FQT00000000000000000789'
)
UNION ALL
SELECT 'soal' AS tabel, id, HEX(LEFT(question, 3)) AS prefix_hex, question
FROM `soal`
WHERE id IN (
  'QST00000000000000000228',
  'QST00000000000000000230',
  'QST00000000000000000314',
  'QST00000000000000000643',
  'QST00000000000000000645',
  'QST00000000000000000596',
  'QST00000000000000000598',
  'QST00000000000000000570',
  'QST00000000000000000572',
  'QST00000000000000000352',
  'QST00000000000000000353',
  'QST00000000000000000758',
  'QST00000000000000000759',
  'QST00000000000000000712',
  'QST00000000000000000713',
  'QST00000000000000000680',
  'QST00000000000000000681',
  'QST00000000000000000798',
  'QST00000000000000000799',
  'QST00000000000000000885',
  'QST00000000000000000839',
  'QST00000000000000000861',
  'QST00000000000000000935',
  'QST00000000000000000936',
  'QST00000000000000000915',
  'QST00000000000000000955',
  'QST00000000000000000956',
  'QST00000000000000000982',
  'QST00000000000000000983',
  'QST00000000000000000377',
  'QST00000000000000000378',
  'QST00000000000000000396',
  'QST00000000000000000397',
  'QST00000000000000000362',
  'QST00000000000000000363',
  'QST00000000000000001615',
  'QST00000000000000000415',
  'QST00000000000000000455',
  'QST00000000000000000456',
  'QST00000000000000000476',
  'QST00000000000000000478',
  'QST00000000000000000434',
  'QST00000000000000000435',
  'QST00000000000000000501',
  'QST00000000000000000502',
  'QST00000000000000000561',
  'QST00000000000000000562',
  'QST00000000000000000654',
  'QST00000000000000000656',
  'QST00000000000000000524',
  'QST00000000000000000526',
  'QST00000000000000000620',
  'QST00000000000000000621',
  'QST00000000000000000696',
  'QST00000000000000001022',
  'QST00000000000000001023',
  'QST00000000000000000746',
  'QST00000000000000000748',
  'QST00000000000000000761',
  'QST00000000000000000762',
  'QST00000000000000001073',
  'QST00000000000000001074',
  'QST00000000000000001093',
  'QST00000000000000001094',
  'QST00000000000000001095',
  'QST00000000000000003205',
  'QST00000000000000003206',
  'QST00000000000000001043',
  'QST00000000000000001044',
  'QST00000000000000001128',
  'QST00000000000000001140',
  'QST00000000000000001165',
  'QST00000000000000001117',
  'QST00000000000000001133',
  'QST00000000000000001213',
  'QST00000000000000001277',
  'QST00000000000000001254',
  'QST00000000000000001263',
  'QST00000000000000001334',
  'QST00000000000000001356',
  'QST00000000000000001311',
  'QST00000000000000001400',
  'QST00000000000000001412',
  'QST00000000000000001388',
  'QST00000000000000001460',
  'QST00000000000000001435',
  'QST00000000000000001447',
  'QST00000000000000001196',
  'QST00000000000000001202',
  'QST00000000000000001207',
  'QST00000000000000001223',
  'QST00000000000000001230',
  'QST00000000000000001240',
  'QST00000000000000001255',
  'QST00000000000000001276',
  'QST00000000000000001265',
  'QST00000000000000001332',
  'QST00000000000000001322',
  'QST00000000000000001295',
  'QST00000000000000001364',
  'QST00000000000000001353',
  'QST00000000000000001373'
);

-- 2) Hitungan harus 82 dan 102
SELECT COUNT(*) AS total_final_exam
FROM `final_exam`
WHERE id IN (
  'FQT00000000000000001393',
  'FQT00000000000000001394',
  'FQT00000000000000000173',
  'FQT00000000000000000584',
  'FQT00000000000000000594',
  'FQT00000000000000000596',
  'FQT00000000000000000611',
  'FQT00000000000000000010',
  'FQT00000000000000000021',
  'FQT00000000000000000067',
  'FQT00000000000000000073',
  'FQT00000000000000000079',
  'FQT00000000000000000136',
  'FQT00000000000000000141',
  'FQT00000000000000000146',
  'FQT00000000000000000156',
  'FQT00000000000000000223',
  'FQT00000000000000000239',
  'FQT00000000000000000294',
  'FQT00000000000000000306',
  'FQT00000000000000000315',
  'FQT00000000000000000317',
  'FQT00000000000000000323',
  'FQT00000000000000000495',
  'FQT00000000000000000499',
  'FQT00000000000000000504',
  'FQT00000000000000000509',
  'FQT00000000000000000510',
  'FQT00000000000000000533',
  'FQT00000000000000000534',
  'FQT00000000000000000539',
  'FQT00000000000000000543',
  'FQT00000000000000000548',
  'FQT00000000000000000579',
  'FQT00000000000000000592',
  'FQT00000000000000000606',
  'FQT00000000000000000618',
  'FQT00000000000000000675',
  'FQT00000000000000000679',
  'FQT00000000000000000684',
  'FQT00000000000000001307',
  'FQT00000000000000001316',
  'FQT00000000000000001322',
  'FQT00000000000000001065',
  'FQT00000000000000001073',
  'FQT00000000000000001078',
  'FQT00000000000000001086',
  'FQT00000000000000001097',
  'FQT00000000000000001100',
  'FQT00000000000000001103',
  'FQT00000000000000001111',
  'FQT00000000000000001114',
  'FQT00000000000000001116',
  'FQT00000000000000000827',
  'FQT00000000000000000929',
  'FQT00000000000000001304',
  'FQT00000000000000000973',
  'FQT00000000000000001006',
  'FQT00000000000000001012',
  'FQT00000000000000001014',
  'FQT00000000000000001016',
  'FQT00000000000000000712',
  'FQT00000000000000000715',
  'FQT00000000000000000718',
  'FQT00000000000000000897',
  'FQT00000000000000000800',
  'FQT00000000000000000803',
  'FQT00000000000000000809',
  'FQT00000000000000000823',
  'FQT00000000000000000833',
  'FQT00000000000000000836',
  'FQT00000000000000000845',
  'FQT00000000000000000852',
  'FQT00000000000000000741',
  'FQT00000000000000000744',
  'FQT00000000000000000747',
  'FQT00000000000000000753',
  'FQT00000000000000000765',
  'FQT00000000000000000768',
  'FQT00000000000000000771',
  'FQT00000000000000000780',
  'FQT00000000000000000789'
);

SELECT COUNT(*) AS total_soal
FROM `soal`
WHERE id IN (
  'QST00000000000000000228',
  'QST00000000000000000230',
  'QST00000000000000000314',
  'QST00000000000000000643',
  'QST00000000000000000645',
  'QST00000000000000000596',
  'QST00000000000000000598',
  'QST00000000000000000570',
  'QST00000000000000000572',
  'QST00000000000000000352',
  'QST00000000000000000353',
  'QST00000000000000000758',
  'QST00000000000000000759',
  'QST00000000000000000712',
  'QST00000000000000000713',
  'QST00000000000000000680',
  'QST00000000000000000681',
  'QST00000000000000000798',
  'QST00000000000000000799',
  'QST00000000000000000885',
  'QST00000000000000000839',
  'QST00000000000000000861',
  'QST00000000000000000935',
  'QST00000000000000000936',
  'QST00000000000000000915',
  'QST00000000000000000955',
  'QST00000000000000000956',
  'QST00000000000000000982',
  'QST00000000000000000983',
  'QST00000000000000000377',
  'QST00000000000000000378',
  'QST00000000000000000396',
  'QST00000000000000000397',
  'QST00000000000000000362',
  'QST00000000000000000363',
  'QST00000000000000001615',
  'QST00000000000000000415',
  'QST00000000000000000455',
  'QST00000000000000000456',
  'QST00000000000000000476',
  'QST00000000000000000478',
  'QST00000000000000000434',
  'QST00000000000000000435',
  'QST00000000000000000501',
  'QST00000000000000000502',
  'QST00000000000000000561',
  'QST00000000000000000562',
  'QST00000000000000000654',
  'QST00000000000000000656',
  'QST00000000000000000524',
  'QST00000000000000000526',
  'QST00000000000000000620',
  'QST00000000000000000621',
  'QST00000000000000000696',
  'QST00000000000000001022',
  'QST00000000000000001023',
  'QST00000000000000000746',
  'QST00000000000000000748',
  'QST00000000000000000761',
  'QST00000000000000000762',
  'QST00000000000000001073',
  'QST00000000000000001074',
  'QST00000000000000001093',
  'QST00000000000000001094',
  'QST00000000000000001095',
  'QST00000000000000003205',
  'QST00000000000000003206',
  'QST00000000000000001043',
  'QST00000000000000001044',
  'QST00000000000000001128',
  'QST00000000000000001140',
  'QST00000000000000001165',
  'QST00000000000000001117',
  'QST00000000000000001133',
  'QST00000000000000001213',
  'QST00000000000000001277',
  'QST00000000000000001254',
  'QST00000000000000001263',
  'QST00000000000000001334',
  'QST00000000000000001356',
  'QST00000000000000001311',
  'QST00000000000000001400',
  'QST00000000000000001412',
  'QST00000000000000001388',
  'QST00000000000000001460',
  'QST00000000000000001435',
  'QST00000000000000001447',
  'QST00000000000000001196',
  'QST00000000000000001202',
  'QST00000000000000001207',
  'QST00000000000000001223',
  'QST00000000000000001230',
  'QST00000000000000001240',
  'QST00000000000000001255',
  'QST00000000000000001276',
  'QST00000000000000001265',
  'QST00000000000000001332',
  'QST00000000000000001322',
  'QST00000000000000001295',
  'QST00000000000000001364',
  'QST00000000000000001353',
  'QST00000000000000001373'
);

-- 3) Total yang sudah berprefix LRM harus 184
SELECT COUNT(*) AS total_prefix_lrm
FROM (
  SELECT id FROM `final_exam` WHERE id IN (
    'FQT00000000000000001393',
    'FQT00000000000000001394',
    'FQT00000000000000000173',
    'FQT00000000000000000584',
    'FQT00000000000000000594',
    'FQT00000000000000000596',
    'FQT00000000000000000611',
    'FQT00000000000000000010',
    'FQT00000000000000000021',
    'FQT00000000000000000067',
    'FQT00000000000000000073',
    'FQT00000000000000000079',
    'FQT00000000000000000136',
    'FQT00000000000000000141',
    'FQT00000000000000000146',
    'FQT00000000000000000156',
    'FQT00000000000000000223',
    'FQT00000000000000000239',
    'FQT00000000000000000294',
    'FQT00000000000000000306',
    'FQT00000000000000000315',
    'FQT00000000000000000317',
    'FQT00000000000000000323',
    'FQT00000000000000000495',
    'FQT00000000000000000499',
    'FQT00000000000000000504',
    'FQT00000000000000000509',
    'FQT00000000000000000510',
    'FQT00000000000000000533',
    'FQT00000000000000000534',
    'FQT00000000000000000539',
    'FQT00000000000000000543',
    'FQT00000000000000000548',
    'FQT00000000000000000579',
    'FQT00000000000000000592',
    'FQT00000000000000000606',
    'FQT00000000000000000618',
    'FQT00000000000000000675',
    'FQT00000000000000000679',
    'FQT00000000000000000684',
    'FQT00000000000000001307',
    'FQT00000000000000001316',
    'FQT00000000000000001322',
    'FQT00000000000000001065',
    'FQT00000000000000001073',
    'FQT00000000000000001078',
    'FQT00000000000000001086',
    'FQT00000000000000001097',
    'FQT00000000000000001100',
    'FQT00000000000000001103',
    'FQT00000000000000001111',
    'FQT00000000000000001114',
    'FQT00000000000000001116',
    'FQT00000000000000000827',
    'FQT00000000000000000929',
    'FQT00000000000000001304',
    'FQT00000000000000000973',
    'FQT00000000000000001006',
    'FQT00000000000000001012',
    'FQT00000000000000001014',
    'FQT00000000000000001016',
    'FQT00000000000000000712',
    'FQT00000000000000000715',
    'FQT00000000000000000718',
    'FQT00000000000000000897',
    'FQT00000000000000000800',
    'FQT00000000000000000803',
    'FQT00000000000000000809',
    'FQT00000000000000000823',
    'FQT00000000000000000833',
    'FQT00000000000000000836',
    'FQT00000000000000000845',
    'FQT00000000000000000852',
    'FQT00000000000000000741',
    'FQT00000000000000000744',
    'FQT00000000000000000747',
    'FQT00000000000000000753',
    'FQT00000000000000000765',
    'FQT00000000000000000768',
    'FQT00000000000000000771',
    'FQT00000000000000000780',
    'FQT00000000000000000789'
  ) AND HEX(LEFT(question, 3)) = 'E2808E'
  UNION ALL
  SELECT id FROM `soal` WHERE id IN (
    'QST00000000000000000228',
    'QST00000000000000000230',
    'QST00000000000000000314',
    'QST00000000000000000643',
    'QST00000000000000000645',
    'QST00000000000000000596',
    'QST00000000000000000598',
    'QST00000000000000000570',
    'QST00000000000000000572',
    'QST00000000000000000352',
    'QST00000000000000000353',
    'QST00000000000000000758',
    'QST00000000000000000759',
    'QST00000000000000000712',
    'QST00000000000000000713',
    'QST00000000000000000680',
    'QST00000000000000000681',
    'QST00000000000000000798',
    'QST00000000000000000799',
    'QST00000000000000000885',
    'QST00000000000000000839',
    'QST00000000000000000861',
    'QST00000000000000000935',
    'QST00000000000000000936',
    'QST00000000000000000915',
    'QST00000000000000000955',
    'QST00000000000000000956',
    'QST00000000000000000982',
    'QST00000000000000000983',
    'QST00000000000000000377',
    'QST00000000000000000378',
    'QST00000000000000000396',
    'QST00000000000000000397',
    'QST00000000000000000362',
    'QST00000000000000000363',
    'QST00000000000000001615',
    'QST00000000000000000415',
    'QST00000000000000000455',
    'QST00000000000000000456',
    'QST00000000000000000476',
    'QST00000000000000000478',
    'QST00000000000000000434',
    'QST00000000000000000435',
    'QST00000000000000000501',
    'QST00000000000000000502',
    'QST00000000000000000561',
    'QST00000000000000000562',
    'QST00000000000000000654',
    'QST00000000000000000656',
    'QST00000000000000000524',
    'QST00000000000000000526',
    'QST00000000000000000620',
    'QST00000000000000000621',
    'QST00000000000000000696',
    'QST00000000000000001022',
    'QST00000000000000001023',
    'QST00000000000000000746',
    'QST00000000000000000748',
    'QST00000000000000000761',
    'QST00000000000000000762',
    'QST00000000000000001073',
    'QST00000000000000001074',
    'QST00000000000000001093',
    'QST00000000000000001094',
    'QST00000000000000001095',
    'QST00000000000000003205',
    'QST00000000000000003206',
    'QST00000000000000001043',
    'QST00000000000000001044',
    'QST00000000000000001128',
    'QST00000000000000001140',
    'QST00000000000000001165',
    'QST00000000000000001117',
    'QST00000000000000001133',
    'QST00000000000000001213',
    'QST00000000000000001277',
    'QST00000000000000001254',
    'QST00000000000000001263',
    'QST00000000000000001334',
    'QST00000000000000001356',
    'QST00000000000000001311',
    'QST00000000000000001400',
    'QST00000000000000001412',
    'QST00000000000000001388',
    'QST00000000000000001460',
    'QST00000000000000001435',
    'QST00000000000000001447',
    'QST00000000000000001196',
    'QST00000000000000001202',
    'QST00000000000000001207',
    'QST00000000000000001223',
    'QST00000000000000001230',
    'QST00000000000000001240',
    'QST00000000000000001255',
    'QST00000000000000001276',
    'QST00000000000000001265',
    'QST00000000000000001332',
    'QST00000000000000001322',
    'QST00000000000000001295',
    'QST00000000000000001364',
    'QST00000000000000001353',
    'QST00000000000000001373'
  ) AND HEX(LEFT(question, 3)) = 'E2808E'
) t;

-- 4) Harus 0 baris: tidak boleh ada LRM ganda
SELECT 'final_exam' AS tabel, id FROM `final_exam`
WHERE id IN (
  'FQT00000000000000001393',
  'FQT00000000000000001394',
  'FQT00000000000000000173',
  'FQT00000000000000000584',
  'FQT00000000000000000594',
  'FQT00000000000000000596',
  'FQT00000000000000000611',
  'FQT00000000000000000010',
  'FQT00000000000000000021',
  'FQT00000000000000000067',
  'FQT00000000000000000073',
  'FQT00000000000000000079',
  'FQT00000000000000000136',
  'FQT00000000000000000141',
  'FQT00000000000000000146',
  'FQT00000000000000000156',
  'FQT00000000000000000223',
  'FQT00000000000000000239',
  'FQT00000000000000000294',
  'FQT00000000000000000306',
  'FQT00000000000000000315',
  'FQT00000000000000000317',
  'FQT00000000000000000323',
  'FQT00000000000000000495',
  'FQT00000000000000000499',
  'FQT00000000000000000504',
  'FQT00000000000000000509',
  'FQT00000000000000000510',
  'FQT00000000000000000533',
  'FQT00000000000000000534',
  'FQT00000000000000000539',
  'FQT00000000000000000543',
  'FQT00000000000000000548',
  'FQT00000000000000000579',
  'FQT00000000000000000592',
  'FQT00000000000000000606',
  'FQT00000000000000000618',
  'FQT00000000000000000675',
  'FQT00000000000000000679',
  'FQT00000000000000000684',
  'FQT00000000000000001307',
  'FQT00000000000000001316',
  'FQT00000000000000001322',
  'FQT00000000000000001065',
  'FQT00000000000000001073',
  'FQT00000000000000001078',
  'FQT00000000000000001086',
  'FQT00000000000000001097',
  'FQT00000000000000001100',
  'FQT00000000000000001103',
  'FQT00000000000000001111',
  'FQT00000000000000001114',
  'FQT00000000000000001116',
  'FQT00000000000000000827',
  'FQT00000000000000000929',
  'FQT00000000000000001304',
  'FQT00000000000000000973',
  'FQT00000000000000001006',
  'FQT00000000000000001012',
  'FQT00000000000000001014',
  'FQT00000000000000001016',
  'FQT00000000000000000712',
  'FQT00000000000000000715',
  'FQT00000000000000000718',
  'FQT00000000000000000897',
  'FQT00000000000000000800',
  'FQT00000000000000000803',
  'FQT00000000000000000809',
  'FQT00000000000000000823',
  'FQT00000000000000000833',
  'FQT00000000000000000836',
  'FQT00000000000000000845',
  'FQT00000000000000000852',
  'FQT00000000000000000741',
  'FQT00000000000000000744',
  'FQT00000000000000000747',
  'FQT00000000000000000753',
  'FQT00000000000000000765',
  'FQT00000000000000000768',
  'FQT00000000000000000771',
  'FQT00000000000000000780',
  'FQT00000000000000000789'
) AND HEX(LEFT(question, 6)) = 'E2808EE2808E'
UNION ALL
SELECT 'soal' AS tabel, id FROM `soal`
WHERE id IN (
  'QST00000000000000000228',
  'QST00000000000000000230',
  'QST00000000000000000314',
  'QST00000000000000000643',
  'QST00000000000000000645',
  'QST00000000000000000596',
  'QST00000000000000000598',
  'QST00000000000000000570',
  'QST00000000000000000572',
  'QST00000000000000000352',
  'QST00000000000000000353',
  'QST00000000000000000758',
  'QST00000000000000000759',
  'QST00000000000000000712',
  'QST00000000000000000713',
  'QST00000000000000000680',
  'QST00000000000000000681',
  'QST00000000000000000798',
  'QST00000000000000000799',
  'QST00000000000000000885',
  'QST00000000000000000839',
  'QST00000000000000000861',
  'QST00000000000000000935',
  'QST00000000000000000936',
  'QST00000000000000000915',
  'QST00000000000000000955',
  'QST00000000000000000956',
  'QST00000000000000000982',
  'QST00000000000000000983',
  'QST00000000000000000377',
  'QST00000000000000000378',
  'QST00000000000000000396',
  'QST00000000000000000397',
  'QST00000000000000000362',
  'QST00000000000000000363',
  'QST00000000000000001615',
  'QST00000000000000000415',
  'QST00000000000000000455',
  'QST00000000000000000456',
  'QST00000000000000000476',
  'QST00000000000000000478',
  'QST00000000000000000434',
  'QST00000000000000000435',
  'QST00000000000000000501',
  'QST00000000000000000502',
  'QST00000000000000000561',
  'QST00000000000000000562',
  'QST00000000000000000654',
  'QST00000000000000000656',
  'QST00000000000000000524',
  'QST00000000000000000526',
  'QST00000000000000000620',
  'QST00000000000000000621',
  'QST00000000000000000696',
  'QST00000000000000001022',
  'QST00000000000000001023',
  'QST00000000000000000746',
  'QST00000000000000000748',
  'QST00000000000000000761',
  'QST00000000000000000762',
  'QST00000000000000001073',
  'QST00000000000000001074',
  'QST00000000000000001093',
  'QST00000000000000001094',
  'QST00000000000000001095',
  'QST00000000000000003205',
  'QST00000000000000003206',
  'QST00000000000000001043',
  'QST00000000000000001044',
  'QST00000000000000001128',
  'QST00000000000000001140',
  'QST00000000000000001165',
  'QST00000000000000001117',
  'QST00000000000000001133',
  'QST00000000000000001213',
  'QST00000000000000001277',
  'QST00000000000000001254',
  'QST00000000000000001263',
  'QST00000000000000001334',
  'QST00000000000000001356',
  'QST00000000000000001311',
  'QST00000000000000001400',
  'QST00000000000000001412',
  'QST00000000000000001388',
  'QST00000000000000001460',
  'QST00000000000000001435',
  'QST00000000000000001447',
  'QST00000000000000001196',
  'QST00000000000000001202',
  'QST00000000000000001207',
  'QST00000000000000001223',
  'QST00000000000000001230',
  'QST00000000000000001240',
  'QST00000000000000001255',
  'QST00000000000000001276',
  'QST00000000000000001265',
  'QST00000000000000001332',
  'QST00000000000000001322',
  'QST00000000000000001295',
  'QST00000000000000001364',
  'QST00000000000000001353',
  'QST00000000000000001373'
) AND HEX(LEFT(question, 6)) = 'E2808EE2808E';
