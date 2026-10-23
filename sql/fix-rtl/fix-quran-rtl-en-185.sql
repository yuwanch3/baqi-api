-- ============================================================
-- BAQI - Perbaikan arah teks pertanyaan EN (RTL) - Quran
-- ============================================================
-- Dibuat: 2026-10-23
-- Cakupan: 185 soal (86 final_exam + 99 soal)
--
-- Masalah: pertanyaan EN dimulai angka lalu huruf Arab, sehingga
-- paragraf mengikuti arah RTL. Perbaikan: LRM (U+200E) di awal
-- field question_en.
--
-- HANYA field `question_en` yang diubah.
-- TIDAK diubah: question, options, options_en, correct_option,
-- correct_option_en, type, dan soal lain.
--
-- Batch ini melengkapi batch ID 184:
-- - 176 soal yang sama dengan batch ID
-- - 2 kasus EN-only (FQT...01372, FQT...00547)
-- - 7 EN dari soal yang question-nya sudah LRM (Q42 + 6 Level 3)
--
-- Catatan: FQT...00547 teks EN berbeda topik dari teks ID; LRM hanya
-- membetulkan arah, bukan isi. FQT...01372 teks EN juga tidak lazim,
-- tetapi arahnya diperbaiki tanpa mengubah isi.
--
-- Semua nilai ditulis hex UTF-8 + CONVERT(... USING latin1) agar byte
-- tersimpan persis, tidak tergantung charset koneksi.
--
-- BACKUP tabel final_exam dan soal sebelum import.
-- Setelah import, jalankan query verifikasi di bagian bawah file.
-- ============================================================

START TRANSACTION;

-- ------------------------------------------------------------
-- [1/185] FQT00000000000000001372 | option | Level 1 | Grammer Test
-- Sebelum: 22. :هٰذَا صَالِح Plural of
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E32322E203AD987D9B0D8B0D98ED8A720D8B5D98ED8A7D984D990D8AD20506C7572616C206F66 USING latin1)
WHERE `id` = 'FQT00000000000000001372';

-- ------------------------------------------------------------
-- [2/185] FQT00000000000000001393 | option | Level 1 | Grammer Test
-- Sebelum: 43. فَعَلَ، يَفْعَلُ، اِفْعَلْ are ۔۔۔۔۔۔keys
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E34332E20D981D98ED8B9D98ED984D98ED88C20D98AD98ED981D992D8B9D98ED984D98FD88C20D8A7D990D981D992D8B9D98ED984D9922061726520DB94DB94DB94DB94DB94DB946B657973 USING latin1)
WHERE `id` = 'FQT00000000000000001393';

-- ------------------------------------------------------------
-- [3/185] FQT00000000000000001394 | option | Level 1 | Grammer Test
-- Sebelum: 44. فَاعِل، مَفْعُوْل، فِعْل are ۔۔۔۔۔۔keys
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E34342E20D981D98ED8A7D8B9D990D984D88C20D985D98ED981D992D8B9D98FD988D992D984D88C20D981D990D8B9D992D9842061726520DB94DB94DB94DB94DB94DB946B657973 USING latin1)
WHERE `id` = 'FQT00000000000000001394';

-- ------------------------------------------------------------
-- [4/185] FQT00000000000000000584 | drag | Level 2 | Final Test
-- Sebelum: 5. فعل ماضٍ of نَعْبُدُ is…
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E352E20D981D8B9D98420D985D8A7D8B6D98D206F6620D986D98ED8B9D992D8A8D98FD8AFD98F206973E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000584';

-- ------------------------------------------------------------
-- [5/185] FQT00000000000000000594 | option | Level 2 | Final Test
-- Sebelum: 12. اسم فاعل of خَتَمَ is…
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E31322E20D8A7D8B3D98520D981D8A7D8B9D984206F6620D8AED98ED8AAD98ED985D98E206973E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000594';

-- ------------------------------------------------------------
-- [6/185] FQT00000000000000000596 | drag | Level 2 | Final Test
-- Sebelum: 14. فعل مضارع of شَعَرْتُ is…
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E31342E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206F6620D8B4D98ED8B9D98ED8B1D992D8AAD98F206973E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000596';

-- ------------------------------------------------------------
-- [7/185] FQT00000000000000000611 | option | Level 2 | Final Test
-- Sebelum: 21. فعل ماضٍ of يَتْرُكُ is…
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E32312E20D981D8B9D98420D985D8A7D8B6D98D206F6620D98AD98ED8AAD992D8B1D98FD983D98F206973E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000611';

-- ------------------------------------------------------------
-- [8/185] FQT00000000000000000010 | option | Level 2 / Sublevel 1 | Ujian Pelajaran
-- Sebelum: 7. فعل ماضٍ of نَعْبُدُ is…
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E372E20D981D8B9D98420D985D8A7D8B6D98D206F6620D986D98ED8B9D992D8A8D98FD8AFD98F206973E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000010';

-- ------------------------------------------------------------
-- [9/185] FQT00000000000000000021 | option | Level 2 / Sublevel 1 | Ujian Pelajaran
-- Sebelum: 16. فعل امر of رَزَقَ:
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E31362E20D981D8B9D98420D8A7D985D8B1206F6620D8B1D98ED8B2D98ED982D98E3A USING latin1)
WHERE `id` = 'FQT00000000000000000021';

-- ------------------------------------------------------------
-- [10/185] FQT00000000000000000067 | option | Level 2 / Sublevel 2 | Ujian Pelajaran
-- Sebelum: 4. اسم فاعل of خَتَمَ is…
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E342E20D8A7D8B3D98520D981D8A7D8B9D984206F6620D8AED98ED8AAD98ED985D98E206973E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000067';

-- ------------------------------------------------------------
-- [11/185] FQT00000000000000000073 | option | Level 2 / Sublevel 2 | Ujian Pelajaran
-- Sebelum: 8. فعل مضارع of شَعَرْتُ is…
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E382E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206F6620D8B4D98ED8B9D98ED8B1D992D8AAD98F206973E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000073';

-- ------------------------------------------------------------
-- [12/185] FQT00000000000000000079 | option | Level 2 / Sublevel 2 | Ujian Pelajaran
-- Sebelum: 13. فعل أمرof قَالَ is…
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E31332E20D981D8B9D98420D8A3D985D8B16F6620D982D98ED8A7D984D98E206973E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000079';

-- ------------------------------------------------------------
-- [13/185] FQT00000000000000000136 | option | Level 2 / Sublevel 3 | Ujian Pelajaran
-- Sebelum: 3. فعل ماضٍ of يَتْرُكُ is…
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E332E20D981D8B9D98420D985D8A7D8B6D98D206F6620D98AD98ED8AAD992D8B1D98FD983D98F206973E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000136';

-- ------------------------------------------------------------
-- [14/185] FQT00000000000000000141 | option | Level 2 / Sublevel 3 | Ujian Pelajaran
-- Sebelum: 8. اسم فاعل of مَاتَ is…
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E382E20D8A7D8B3D98520D981D8A7D8B9D984206F6620D985D98ED8A7D8AAD98E206973E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000141';

-- ------------------------------------------------------------
-- [15/185] FQT00000000000000000146 | option | Level 2 / Sublevel 3 | Ujian Pelajaran
-- Sebelum: 13. فعل مضارع of عَلِمَ is…
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E31332E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206F6620D8B9D98ED984D990D985D98E206973E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000146';

-- ------------------------------------------------------------
-- [16/185] FQT00000000000000000156 | option | Level 2 / Sublevel 3 | Ujian Pelajaran
-- Sebelum: 17. دَعَا is…
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E31372E20D8AFD98ED8B9D98ED8A7206973E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000156';

-- ------------------------------------------------------------
-- [17/185] FQT00000000000000000223 | option | Level 2 / Sublevel 4 | Ujian Pelajaran
-- Sebelum: 10. فعل أمر of قَالَ is…
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E31302E20D981D8B9D98420D8A3D985D8B1206F6620D982D98ED8A7D984D98E206973E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000223';

-- ------------------------------------------------------------
-- [18/185] FQT00000000000000000239 | option | Level 2 / Sublevel 4 | Ujian Pelajaran
-- Sebelum: 18. يَرْجِعُ  means:
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E31382E20D98AD98ED8B1D992D8ACD990D8B9D98F20206D65616E733A USING latin1)
WHERE `id` = 'FQT00000000000000000239';

-- ------------------------------------------------------------
-- [19/185] FQT00000000000000000294 | option | Level 2 / Sublevel 5 | Ujian Pelajaran
-- Sebelum: 2. فعل ماض of سَفْك is:
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E322E20D981D8B9D98420D985D8A7D8B6206F6620D8B3D98ED981D992D9832069733A USING latin1)
WHERE `id` = 'FQT00000000000000000294';

-- ------------------------------------------------------------
-- [20/185] FQT00000000000000000306 | option | Level 2 / Sublevel 5 | Ujian Pelajaran
-- Sebelum: 8. اسم فاعل of صَدَقَ is…
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E382E20D8A7D8B3D98520D981D8A7D8B9D984206F6620D8B5D98ED8AFD98ED982D98E206973E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000306';

-- ------------------------------------------------------------
-- [21/185] FQT00000000000000000315 | option | Level 2 / Sublevel 5 | Ujian Pelajaran
-- Sebelum: 13. فعل امر of أَكَلَ is…
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E31332E20D981D8B9D98420D8A7D985D8B1206F6620D8A3D98ED983D98ED984D98E206973E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000315';

-- ------------------------------------------------------------
-- [22/185] FQT00000000000000000317 | option | Level 2 / Sublevel 5 | Ujian Pelajaran
-- Sebelum: 14. فعل مضارع of أَبٰى is…
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E31342E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206F6620D8A3D98ED8A8D9B0D989206973E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000317';

-- ------------------------------------------------------------
-- [23/185] FQT00000000000000000323 | option | Level 2 / Sublevel 5 | Ujian Pelajaran
-- Sebelum: 17. فعل امر of هَبَطَ is…
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E31372E20D981D8B9D98420D8A7D985D8B1206F6620D987D98ED8A8D98ED8B7D98E206973E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000323';

-- ------------------------------------------------------------
-- [24/185] QST00000000000000000228 | option | Level 2 / Sublevel 1 / Materi: Do'a untuk petunjuk
-- Sebelum: 6. فعل مضارع of مَلَكَ is…
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E362E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206F6620D985D98ED984D98ED983D98E206973E280A6 USING latin1)
WHERE `id` = 'QST00000000000000000228';

-- ------------------------------------------------------------
-- [25/185] QST00000000000000000230 | option | Level 2 / Sublevel 1 / Materi: Do'a untuk petunjuk
-- Sebelum: 7. فعل ماضٍ of نَعْبُدُ is…
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E372E20D981D8B9D98420D985D8A7D8B6D98D206F6620D986D98ED8B9D992D8A8D98FD8AFD98F206973E280A6 USING latin1)
WHERE `id` = 'QST00000000000000000230';

-- ------------------------------------------------------------
-- [26/185] QST00000000000000000314 | option | Level 2 / Sublevel 1 / Materi: Sifat muttaqien
-- Sebelum: 6. فعل امر of رَزَقَ:
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E362E20D981D8B9D98420D8A7D985D8B1206F6620D8B1D98ED8B2D98ED982D98E3A USING latin1)
WHERE `id` = 'QST00000000000000000314';

-- ------------------------------------------------------------
-- [27/185] QST00000000000000000643 | option | Level 2 / Sublevel 2 / Materi: Bermuka Dua
-- Sebelum: 5. فعل ماض of يَعْمَهُ is…
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E352E20D981D8B9D98420D985D8A7D8B6206F6620D98AD98ED8B9D992D985D98ED987D98F206973E280A6 USING latin1)
WHERE `id` = 'QST00000000000000000643';

-- ------------------------------------------------------------
-- [28/185] QST00000000000000000645 | option | Level 2 / Sublevel 2 / Materi: Bermuka Dua
-- Sebelum: 6. يَخْلُو is…
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E362E20D98AD98ED8AED992D984D98FD988206973E280A6 USING latin1)
WHERE `id` = 'QST00000000000000000645';

-- ------------------------------------------------------------
-- [29/185] QST00000000000000000596 | option | Level 2 / Sublevel 2 / Materi: Korup dan Bodoh
-- Sebelum: 5. فعل ماض of يَعْلَمُ is…
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E352E20D981D8B9D98420D985D8A7D8B6206F6620D98AD98ED8B9D992D984D98ED985D98F206973E280A6 USING latin1)
WHERE `id` = 'QST00000000000000000596';

-- ------------------------------------------------------------
-- [30/185] QST00000000000000000598 | option | Level 2 / Sublevel 2 / Materi: Korup dan Bodoh
-- Sebelum: 6.  فعل أمرof قَالَ is…
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E362E2020D981D8B9D98420D8A3D985D8B16F6620D982D98ED8A7D984D98E206973E280A6 USING latin1)
WHERE `id` = 'QST00000000000000000598';

-- ------------------------------------------------------------
-- [31/185] QST00000000000000000570 | option | Level 2 / Sublevel 2 / Materi: Tidak Ada Petunjuk Bagi Munafiqqeen
-- Sebelum: 6. فعل مضارع of شَعَرْتُ is…
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E362E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206F6620D8B4D98ED8B9D98ED8B1D992D8AAD98F206973E280A6 USING latin1)
WHERE `id` = 'QST00000000000000000570';

-- ------------------------------------------------------------
-- [32/185] QST00000000000000000572 | option | Level 2 / Sublevel 2 / Materi: Tidak Ada Petunjuk Bagi Munafiqqeen
-- Sebelum: 7. اسم مَفْعُوْل of كَاذِب is…
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E372E20D8A7D8B3D98520D985D98ED981D992D8B9D98FD988D992D984206F6620D983D98ED8A7D8B0D990D8A8206973E280A6 USING latin1)
WHERE `id` = 'QST00000000000000000572';

-- ------------------------------------------------------------
-- [33/185] QST00000000000000000352 | option | Level 2 / Sublevel 2 / Materi: Tidak Ada Petunjuk Untuk Kafir
-- Sebelum: 6. اسم مفعول of يَكْفُرُ is…
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E362E20D8A7D8B3D98520D985D981D8B9D988D984206F6620D98AD98ED983D992D981D98FD8B1D98F206973E280A6 USING latin1)
WHERE `id` = 'QST00000000000000000352';

-- ------------------------------------------------------------
-- [34/185] QST00000000000000000353 | option | Level 2 / Sublevel 2 / Materi: Tidak Ada Petunjuk Untuk Kafir
-- Sebelum: 7. اسم فاعل of خَتَمَ is…
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E372E20D8A7D8B3D98520D981D8A7D8B9D984206F6620D8AED98ED8AAD98ED985D98E206973E280A6 USING latin1)
WHERE `id` = 'QST00000000000000000353';

-- ------------------------------------------------------------
-- [35/185] QST00000000000000000758 | option | Level 2 / Sublevel 3 / Materi: Al-Qur'an Memanggil
-- Sebelum: 5. فعل ماض of نَعْبُدُ is…
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E352E20D981D8B9D98420D985D8A7D8B6206F6620D986D98ED8B9D992D8A8D98FD8AFD98F206973E280A6 USING latin1)
WHERE `id` = 'QST00000000000000000758';

-- ------------------------------------------------------------
-- [36/185] QST00000000000000000759 | option | Level 2 / Sublevel 3 / Materi: Al-Qur'an Memanggil
-- Sebelum: 6. فعل مضارع of عَلِمَ is…
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E362E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206F6620D8B9D98ED984D990D985D98E206973E280A6 USING latin1)
WHERE `id` = 'QST00000000000000000759';

-- ------------------------------------------------------------
-- [37/185] QST00000000000000000712 | option | Level 2 / Sublevel 3 / Materi: Contoh Kedua : Hujan
-- Sebelum: 5. اسم فاعل of مَاتَ is…
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E352E20D8A7D8B3D98520D981D8A7D8B9D984206F6620D985D98ED8A7D8AAD98E206973E280A6 USING latin1)
WHERE `id` = 'QST00000000000000000712';

-- ------------------------------------------------------------
-- [38/185] QST00000000000000000713 | option | Level 2 / Sublevel 3 / Materi: Contoh Kedua : Hujan
-- Sebelum: 6. اسم مفعول of تَرَكَ is…
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E362E20D8A7D8B3D98520D985D981D8B9D988D984206F6620D8AAD98ED8B1D98ED983D98E206973E280A6 USING latin1)
WHERE `id` = 'QST00000000000000000713';

-- ------------------------------------------------------------
-- [39/185] QST00000000000000000680 | option | Level 2 / Sublevel 3 / Materi: Contoh Pertama Munafiqeen: Api
-- Sebelum: 5. فعل ماضٍ of يَتْرُكُ is…
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E352E20D981D8B9D98420D985D8A7D8B6D98D206F6620D98AD98ED8AAD992D8B1D98FD983D98F206973E280A6 USING latin1)
WHERE `id` = 'QST00000000000000000680';

-- ------------------------------------------------------------
-- [40/185] QST00000000000000000681 | option | Level 2 / Sublevel 3 / Materi: Contoh Pertama Munafiqeen: Api
-- Sebelum: 6. فعل امر of رَجَعَ is…
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E362E20D981D8B9D98420D8A7D985D8B1206F6620D8B1D98ED8ACD98ED8B9D98E206973E280A6 USING latin1)
WHERE `id` = 'QST00000000000000000681';

-- ------------------------------------------------------------
-- [41/185] QST00000000000000000798 | option | Level 2 / Sublevel 3 / Materi: Tantangan Al-Qur'an
-- Sebelum: 5. دَعَا is…
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E352E20D8AFD98ED8B9D98ED8A7206973E280A6 USING latin1)
WHERE `id` = 'QST00000000000000000798';

-- ------------------------------------------------------------
-- [42/185] QST00000000000000000799 | option | Level 2 / Sublevel 3 / Materi: Tantangan Al-Qur'an
-- Sebelum: 6. اسم مفعول of صَدَقَ is:
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E362E20D8A7D8B3D98520D985D981D8B9D988D984206F6620D8B5D98ED8AFD98ED982D98E2069733A USING latin1)
WHERE `id` = 'QST00000000000000000799';

-- ------------------------------------------------------------
-- [43/185] QST00000000000000000885 | option | Level 2 / Sublevel 4 / Materi: Bagaimana Bisa Kafir ?
-- Sebelum: 6. يَرْجِعُ  means:
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E362E20D98AD98ED8B1D992D8ACD990D8B9D98F20206D65616E733A USING latin1)
WHERE `id` = 'QST00000000000000000885';

-- ------------------------------------------------------------
-- [44/185] QST00000000000000000839 | option | Level 2 / Sublevel 4 / Materi: Contoh Nyamuk
-- Sebelum: 6. فعل أمر of قَالَ is…
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E362E20D981D8B9D98420D8A3D985D8B1206F6620D982D98ED8A7D984D98E206973E280A6 USING latin1)
WHERE `id` = 'QST00000000000000000839';

-- ------------------------------------------------------------
-- [45/185] QST00000000000000000861 | option | Level 2 / Sublevel 4 / Materi: Siapa Yang Tersesat ?
-- Sebelum: 5. فعل مضارع   of نَقَضُوْا
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E352E20D981D8B9D98420D985D8B6D8A7D8B1D8B92020206F6620D986D98ED982D98ED8B6D98FD988D992D8A7 USING latin1)
WHERE `id` = 'QST00000000000000000861';

-- ------------------------------------------------------------
-- [46/185] QST00000000000000000935 | option | Level 2 / Sublevel 5 / Materi: Ajaran Nama-nama 
-- Sebelum: 5. اسم فاعل of صَدَقَ is…
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E352E20D8A7D8B3D98520D981D8A7D8B9D984206F6620D8B5D98ED8AFD98ED982D98E206973E280A6 USING latin1)
WHERE `id` = 'QST00000000000000000935';

-- ------------------------------------------------------------
-- [47/185] QST00000000000000000936 | option | Level 2 / Sublevel 5 / Materi: Ajaran Nama-nama 
-- Sebelum: 6. فعل أمر of عَرَضَ is…
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E362E20D981D8B9D98420D8A3D985D8B1206F6620D8B9D98ED8B1D98ED8B6D98E206973E280A6 USING latin1)
WHERE `id` = 'QST00000000000000000936';

-- ------------------------------------------------------------
-- [48/185] QST00000000000000000915 | option | Level 2 / Sublevel 5 / Materi: Pertanyaan Tentang Khalifah 
-- Sebelum: 5. فعل ماض of سَفْك is:
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E352E20D981D8B9D98420D985D8A7D8B6206F6620D8B3D98ED981D992D9832069733A USING latin1)
WHERE `id` = 'QST00000000000000000915';

-- ------------------------------------------------------------
-- [49/185] QST00000000000000000955 | option | Level 2 / Sublevel 5 / Materi: Sajdah dan Iblis
-- Sebelum: 5. فعل امر of أَكَلَ is…
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E352E20D981D8B9D98420D8A7D985D8B1206F6620D8A3D98ED983D98ED984D98E206973E280A6 USING latin1)
WHERE `id` = 'QST00000000000000000955';

-- ------------------------------------------------------------
-- [50/185] QST00000000000000000956 | option | Level 2 / Sublevel 5 / Materi: Sajdah dan Iblis
-- Sebelum: 6. فعل مضارع of أَبٰى is…
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E362E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206F6620D8A3D98ED8A8D9B0D989206973E280A6 USING latin1)
WHERE `id` = 'QST00000000000000000956';

-- ------------------------------------------------------------
-- [51/185] QST00000000000000000982 | option | Level 2 / Sublevel 5 / Materi: Slip dan Tawbah
-- Sebelum: 5. فعل امر of هَبَطَ is…
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E352E20D981D8B9D98420D8A7D985D8B1206F6620D987D98ED8A8D98ED8B7D98E206973E280A6 USING latin1)
WHERE `id` = 'QST00000000000000000982';

-- ------------------------------------------------------------
-- [52/185] QST00000000000000000983 | option | Level 2 / Sublevel 5 / Materi: Slip dan Tawbah
-- Sebelum: 6. فعل مضارع of تَابَ is…
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E362E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206F6620D8AAD98ED8A7D8A8D98E206973E280A6 USING latin1)
WHERE `id` = 'QST00000000000000000983';

-- ------------------------------------------------------------
-- [53/185] FQT00000000000000001194 | drag | Level 3 | Final Test
-- Sebelum: 11. مفعول اسم of ذَبَّحَ is…
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E31312E20D985D981D8B9D988D98420D8A7D8B3D985206F6620D8B0D98ED8A8D991D98ED8ADD98E206973E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000001194';

-- ------------------------------------------------------------
-- [54/185] FQT00000000000000001201 | option | Level 3 | Final Test
-- Sebelum: 14. فعل أمر of وَاعَدَ is:
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E31342E20D981D8B9D98420D8A3D985D8B1206F6620D988D98ED8A7D8B9D98ED8AFD98E2069733A USING latin1)
WHERE `id` = 'FQT00000000000000001201';

-- ------------------------------------------------------------
-- [55/185] FQT00000000000000001207 | drag | Level 3 | Final Test
-- Sebelum: 19. اسم مفعول of اٰمَنَ is…
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E31392E20D8A7D8B3D98520D985D981D8B9D988D984206F6620D8A7D9B0D985D98ED986D98E206973E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000001207';

-- ------------------------------------------------------------
-- [56/185] FQT00000000000000001216 | drag | Level 3 | Final Test
-- Sebelum: 25. فعل امر of أَكَلَ is:
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E32352E20D981D8B9D98420D8A7D985D8B1206F6620D8A3D98ED983D98ED984D98E2069733A USING latin1)
WHERE `id` = 'FQT00000000000000001216';

-- ------------------------------------------------------------
-- [57/185] FQT00000000000000001219 | drag | Level 3 | Final Test
-- Sebelum: 27. اسم مفعول of طَعِمَ is…
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E32372E20D8A7D8B3D98520D985D981D8B9D988D984206F6620D8B7D98ED8B9D990D985D98E206973E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000001219';

-- ------------------------------------------------------------
-- [58/185] FQT00000000000000001221 | drag | Level 3 | Final Test
-- Sebelum: 29. فعل امر of ذَلَّ is:
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E32392E20D981D8B9D98420D8A7D985D8B1206F6620D8B0D98ED984D991D98E2069733A USING latin1)
WHERE `id` = 'FQT00000000000000001221';

-- ------------------------------------------------------------
-- [59/185] FQT00000000000000001243 | option | Level 3 | Final Test
-- Sebelum: 42. فعل مضارع of دَعَا is:
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E34322E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206F6620D8AFD98ED8B9D98ED8A72069733A USING latin1)
WHERE `id` = 'FQT00000000000000001243';

-- ------------------------------------------------------------
-- [60/185] FQT00000000000000000495 | option | Level 3 / Sublevel 1 | Ujian Pelajaran
-- Sebelum: 4. فعل مضارع of هَبَطَ is:
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E342E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206F6620D987D98ED8A8D98ED8B7D98E2069733A USING latin1)
WHERE `id` = 'FQT00000000000000000495';

-- ------------------------------------------------------------
-- [61/185] FQT00000000000000000499 | option | Level 3 / Sublevel 1 | Ujian Pelajaran
-- Sebelum: 8. فعل أمر of لَبَسَ is:
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E382E20D981D8B9D98420D8A3D985D8B1206F6620D984D98ED8A8D98ED8B3D98E2069733A USING latin1)
WHERE `id` = 'FQT00000000000000000499';

-- ------------------------------------------------------------
-- [62/185] FQT00000000000000000504 | option | Level 3 / Sublevel 1 | Ujian Pelajaran
-- Sebelum: 13. فعل أمر of تَلَا is…
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E31332E20D981D8B9D98420D8A3D985D8B1206F6620D8AAD98ED984D98ED8A7206973E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000504';

-- ------------------------------------------------------------
-- [63/185] FQT00000000000000000509 | option | Level 3 / Sublevel 1 | Ujian Pelajaran
-- Sebelum: 18. اسم مفعول of فَضَّلَ is…
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E31382E20D8A7D8B3D98520D985D981D8B9D988D984206F6620D981D98ED8B6D991D98ED984D98E206973E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000509';

-- ------------------------------------------------------------
-- [64/185] FQT00000000000000000533 | option | Level 3 / Sublevel 2 | Ujian Pelajaran
-- Sebelum: 3. فعل مضارع of فَرَقَ is:
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E332E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206F6620D981D98ED8B1D98ED982D98E2069733A USING latin1)
WHERE `id` = 'FQT00000000000000000533';

-- ------------------------------------------------------------
-- [65/185] FQT00000000000000000539 | option | Level 3 / Sublevel 2 | Ujian Pelajaran
-- Sebelum: 9. فعل أمر of وَاعَدَ is:
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E392E20D981D8B9D98420D8A3D985D8B1206F6620D988D98ED8A7D8B9D98ED8AFD98E2069733A USING latin1)
WHERE `id` = 'FQT00000000000000000539';

-- ------------------------------------------------------------
-- [66/185] FQT00000000000000000543 | option | Level 3 / Sublevel 2 | Ujian Pelajaran
-- Sebelum: 13. فعل امر of تَابَ is…
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E31332E20D981D8B9D98420D8A7D985D8B1206F6620D8AAD98ED8A7D8A8D98E206973E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000543';

-- ------------------------------------------------------------
-- [67/185] FQT00000000000000000547 | option | Level 3 / Sublevel 2 | Ujian Pelajaran
-- Sebelum: 18. اسم مفعول of اٰمَنَ is…
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E31382E20D8A7D8B3D98520D985D981D8B9D988D984206F6620D8A7D9B0D985D98ED986D98E206973E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000547';

-- ------------------------------------------------------------
-- [68/185] FQT00000000000000000548 | option | Level 3 / Sublevel 2 | Ujian Pelajaran
-- Sebelum: 18. اسم مفعول of اٰمَنَ is…
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E31382E20D8A7D8B3D98520D985D981D8B9D988D984206F6620D8A7D9B0D985D98ED986D98E206973E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000548';

-- ------------------------------------------------------------
-- [69/185] FQT00000000000000000579 | option | Level 3 / Sublevel 3 | Ujian Pelajaran
-- Sebelum: 3. فعل مضارع of شَاءَ is:
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E332E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206F6620D8B4D98ED8A7D8A1D98E2069733A USING latin1)
WHERE `id` = 'FQT00000000000000000579';

-- ------------------------------------------------------------
-- [70/185] FQT00000000000000000592 | option | Level 3 / Sublevel 3 | Ujian Pelajaran
-- Sebelum: 8. فعل امر of أَكَلَ is:
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E382E20D981D8B9D98420D8A7D985D8B1206F6620D8A3D98ED983D98ED984D98E2069733A USING latin1)
WHERE `id` = 'FQT00000000000000000592';

-- ------------------------------------------------------------
-- [71/185] FQT00000000000000000606 | option | Level 3 / Sublevel 3 | Ujian Pelajaran
-- Sebelum: 13. اسم مفعول of طَعِمَ is…
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E31332E20D8A7D8B3D98520D985D981D8B9D988D984206F6620D8B7D98ED8B9D990D985D98E206973E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000606';

-- ------------------------------------------------------------
-- [72/185] FQT00000000000000000618 | option | Level 3 / Sublevel 3 | Ujian Pelajaran
-- Sebelum: 18. فعل امر of ذَلَّ is:
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E31382E20D981D8B9D98420D8A7D985D8B1206F6620D8B0D98ED984D991D98E2069733A USING latin1)
WHERE `id` = 'FQT00000000000000000618';

-- ------------------------------------------------------------
-- [73/185] FQT00000000000000000675 | option | Level 3 / Sublevel 4 | Ujian Pelajaran
-- Sebelum: 9. اسم فَاعِل of ذَكَرَ is…
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E392E20D8A7D8B3D98520D981D98ED8A7D8B9D990D984206F6620D8B0D98ED983D98ED8B1D98E206973E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000675';

-- ------------------------------------------------------------
-- [74/185] FQT00000000000000000679 | option | Level 3 / Sublevel 4 | Ujian Pelajaran
-- Sebelum: 13. اسم فاعل of خَسَأَ is:
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E31332E20D8A7D8B3D98520D981D8A7D8B9D984206F6620D8AED98ED8B3D98ED8A3D98E2069733A USING latin1)
WHERE `id` = 'FQT00000000000000000679';

-- ------------------------------------------------------------
-- [75/185] FQT00000000000000000684 | option | Level 3 / Sublevel 4 | Ujian Pelajaran
-- Sebelum: 18.  فعل امر of سَرَّ is…
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E31382E2020D981D8B9D98420D8A7D985D8B1206F6620D8B3D98ED8B1D991D98E206973E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000684';

-- ------------------------------------------------------------
-- [76/185] FQT00000000000000001307 | option | Level 3 / Sublevel 5 | Ujian Pelajaran
-- Sebelum: 3. فعل مضارع of دَعَا is:
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E332E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206F6620D8AFD98ED8B9D98ED8A72069733A USING latin1)
WHERE `id` = 'FQT00000000000000001307';

-- ------------------------------------------------------------
-- [77/185] FQT00000000000000001316 | option | Level 3 / Sublevel 5 | Ujian Pelajaran
-- Sebelum: 12. فعل مضارع of غَفَلَ is:
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E31322E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206F6620D8BAD98ED981D98ED984D98E2069733A USING latin1)
WHERE `id` = 'FQT00000000000000001316';

-- ------------------------------------------------------------
-- [78/185] FQT00000000000000001322 | option | Level 3 / Sublevel 5 | Ujian Pelajaran
-- Sebelum: 18. فعل امر of حَرَّفَ is:
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E31382E20D981D8B9D98420D8A7D985D8B1206F6620D8ADD98ED8B1D991D98ED981D98E2069733A USING latin1)
WHERE `id` = 'FQT00000000000000001322';

-- ------------------------------------------------------------
-- [79/185] QST00000000000000000377 | option | Level 3 / Sublevel 1 / Materi: Dakwah Ke Bani Israel 
-- Sebelum: 4. فعل أمر of لَبَسَ is:
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E342E20D981D8B9D98420D8A3D985D8B1206F6620D984D98ED8A8D98ED8B3D98E2069733A USING latin1)
WHERE `id` = 'QST00000000000000000377';

-- ------------------------------------------------------------
-- [80/185] QST00000000000000000378 | option | Level 3 / Sublevel 1 / Materi: Dakwah Ke Bani Israel 
-- Sebelum: 5. اسم فَاعِل of رَهِبَ is…
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E352E20D8A7D8B3D98520D981D98ED8A7D8B9D990D984206F6620D8B1D98ED987D990D8A8D98E206973E280A6 USING latin1)
WHERE `id` = 'QST00000000000000000378';

-- ------------------------------------------------------------
-- [81/185] QST00000000000000000396 | option | Level 3 / Sublevel 1 / Materi: Lakukan Perbuatan Baik!
-- Sebelum: 5. اسم مفعول of نَسِيَ is
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E352E20D8A7D8B3D98520D985D981D8B9D988D984206F6620D986D98ED8B3D990D98AD98E206973 USING latin1)
WHERE `id` = 'QST00000000000000000396';

-- ------------------------------------------------------------
-- [82/185] QST00000000000000000397 | option | Level 3 / Sublevel 1 / Materi: Lakukan Perbuatan Baik!
-- Sebelum: 6. فعل أمر of تَلَا is…
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E362E20D981D8B9D98420D8A3D985D8B1206F6620D8AAD98ED984D98ED8A7206973E280A6 USING latin1)
WHERE `id` = 'QST00000000000000000397';

-- ------------------------------------------------------------
-- [83/185] QST00000000000000000362 | option | Level 3 / Sublevel 1 / Materi: Pengantar; Hasil Petunjuk
-- Sebelum: 5. فعل مضارع of هَبَطَ is
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E352E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206F6620D987D98ED8A8D98ED8B7D98E206973 USING latin1)
WHERE `id` = 'QST00000000000000000362';

-- ------------------------------------------------------------
-- [84/185] QST00000000000000000363 | option | Level 3 / Sublevel 1 / Materi: Pengantar; Hasil Petunjuk
-- Sebelum: 6. اسم مفعول  of هَدٰى is
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E362E20D8A7D8B3D98520D985D981D8B9D988D98420206F6620D987D98ED8AFD9B0D989206973 USING latin1)
WHERE `id` = 'QST00000000000000000363';

-- ------------------------------------------------------------
-- [85/185] QST00000000000000001615 | option | Level 3 / Sublevel 1 / Materi: Pengantar; مَزِيْدٌ فِيْه
-- Sebelum: 9. تَعْلِيم and مُحَاسَبَة are very important ........
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E392E20D8AAD98ED8B9D992D984D990D98AD98520616E6420D985D98FD8ADD98ED8A7D8B3D98ED8A8D98ED8A920617265207665727920696D706F7274616E74202E2E2E2E2E2E2E2E USING latin1)
WHERE `id` = 'QST00000000000000001615';

-- ------------------------------------------------------------
-- [86/185] QST00000000000000000415 | option | Level 3 / Sublevel 1 / Materi: Takut Hari!
-- Sebelum: 5. اسم مفعول of فَضَّلَ is…
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E352E20D8A7D8B3D98520D985D981D8B9D988D984206F6620D981D98ED8B6D991D98ED984D98E206973E280A6 USING latin1)
WHERE `id` = 'QST00000000000000000415';

-- ------------------------------------------------------------
-- [87/185] QST00000000000000000455 | option | Level 3 / Sublevel 2 / Materi: 40 Malam
-- Sebelum: 6. فعل أمر of وَاعَدَ is:
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E362E20D981D8B9D98420D8A3D985D8B1206F6620D988D98ED8A7D8B9D98ED8AFD98E2069733A USING latin1)
WHERE `id` = 'QST00000000000000000455';

-- ------------------------------------------------------------
-- [88/185] QST00000000000000000456 | option | Level 3 / Sublevel 2 / Materi: 40 Malam
-- Sebelum: 7. اسم فَاعِل of ظَلَمَ is…
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E372E20D8A7D8B3D98520D981D98ED8A7D8B9D990D984206F6620D8B8D98ED984D98ED985D98E206973E280A6 USING latin1)
WHERE `id` = 'QST00000000000000000456';

-- ------------------------------------------------------------
-- [89/185] QST00000000000000000476 | option | Level 3 / Sublevel 2 / Materi: Bertobat dari Penyembahan Anak Sapi
-- Sebelum: 6. اسم مفعول of قَالَ is
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E362E20D8A7D8B3D98520D985D981D8B9D988D984206F6620D982D98ED8A7D984D98E206973 USING latin1)
WHERE `id` = 'QST00000000000000000476';

-- ------------------------------------------------------------
-- [90/185] QST00000000000000000478 | option | Level 3 / Sublevel 2 / Materi: Bertobat dari Penyembahan Anak Sapi
-- Sebelum: 7. فعل امر of تَابَ is…
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E372E20D981D8B9D98420D8A7D985D8B1206F6620D8AAD98ED8A7D8A8D98E206973E280A6 USING latin1)
WHERE `id` = 'QST00000000000000000478';

-- ------------------------------------------------------------
-- [91/185] QST00000000000000000434 | option | Level 3 / Sublevel 2 / Materi: Penyelamatan dari Fir'aun
-- Sebelum: 5. فعل مضارع of فَرَقَ is
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E352E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206F6620D981D98ED8B1D98ED982D98E206973 USING latin1)
WHERE `id` = 'QST00000000000000000434';

-- ------------------------------------------------------------
-- [92/185] QST00000000000000000435 | option | Level 3 / Sublevel 2 / Materi: Penyelamatan dari Fir'aun
-- Sebelum: 6. مفعول اسم of ذَبَّحَ is…
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E362E20D985D981D8B9D988D98420D8A7D8B3D985206F6620D8B0D98ED8A8D991D98ED8ADD98E206973E280A6 USING latin1)
WHERE `id` = 'QST00000000000000000435';

-- ------------------------------------------------------------
-- [93/185] QST00000000000000000501 | option | Level 3 / Sublevel 2 / Materi: Tunjukan Pada Allah!
-- Sebelum: 5.  فاعل اسم of رَأٰى is:
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E352E2020D981D8A7D8B9D98420D8A7D8B3D985206F6620D8B1D98ED8A3D9B0D9892069733A USING latin1)
WHERE `id` = 'QST00000000000000000501';

-- ------------------------------------------------------------
-- [94/185] QST00000000000000000502 | option | Level 3 / Sublevel 2 / Materi: Tunjukan Pada Allah!
-- Sebelum: 6. اسم مفعول of اٰمَنَ is…
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E362E20D8A7D8B3D98520D985D981D8B9D988D984206F6620D8A7D9B0D985D98ED986D98E206973E280A6 USING latin1)
WHERE `id` = 'QST00000000000000000502';

-- ------------------------------------------------------------
-- [95/185] QST00000000000000000561 | option | Level 3 / Sublevel 3 / Materi: Do'a Untuk Air
-- Sebelum: 6. فعل امر of أَكَلَ is:
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E362E20D981D8B9D98420D8A7D985D8B1206F6620D8A3D98ED983D98ED984D98E2069733A USING latin1)
WHERE `id` = 'QST00000000000000000561';

-- ------------------------------------------------------------
-- [96/185] QST00000000000000000562 | option | Level 3 / Sublevel 3 / Materi: Do'a Untuk Air
-- Sebelum: 7. اسم فَاعِل of عَثِيَ is…
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E372E20D8A7D8B3D98520D981D98ED8A7D8B9D990D984206F6620D8B9D98ED8ABD990D98AD98E206973E280A6 USING latin1)
WHERE `id` = 'QST00000000000000000562';

-- ------------------------------------------------------------
-- [97/185] QST00000000000000000654 | option | Level 3 / Sublevel 3 / Materi: Hukuman 
-- Sebelum: 5. فعل امر of ذَلَّ is:
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E352E20D981D8B9D98420D8A7D985D8B1206F6620D8B0D98ED984D991D98E2069733A USING latin1)
WHERE `id` = 'QST00000000000000000654';

-- ------------------------------------------------------------
-- [98/185] QST00000000000000000656 | option | Level 3 / Sublevel 3 / Materi: Hukuman 
-- Sebelum: 6. اسم مفعول of عَصٰى is…
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E362E20D8A7D8B3D98520D985D981D8B9D988D984206F6620D8B9D98ED8B5D9B0D989206973E280A6 USING latin1)
WHERE `id` = 'QST00000000000000000656';

-- ------------------------------------------------------------
-- [99/185] QST00000000000000000524 | option | Level 3 / Sublevel 3 / Materi: Masuk ke Kota
-- Sebelum: 5. فعل مضارع of شَاءَ is
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E352E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206F6620D8B4D98ED8A7D8A1D98E206973 USING latin1)
WHERE `id` = 'QST00000000000000000524';

-- ------------------------------------------------------------
-- [100/185] QST00000000000000000526 | option | Level 3 / Sublevel 3 / Materi: Masuk ke Kota
-- Sebelum: 10. مفعول اسم of زَادَ is…
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E31302E20D985D981D8B9D988D98420D8A7D8B3D985206F6620D8B2D98ED8A7D8AFD98E206973E280A6 USING latin1)
WHERE `id` = 'QST00000000000000000526';

-- ------------------------------------------------------------
-- [101/185] QST00000000000000000620 | option | Level 3 / Sublevel 3 / Materi: Permintaan Makanan 
-- Sebelum: 6. اسم فاعل of سَأَلَ is:
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E362E20D8A7D8B3D98520D981D8A7D8B9D984206F6620D8B3D98ED8A3D98ED984D98E2069733A USING latin1)
WHERE `id` = 'QST00000000000000000620';

-- ------------------------------------------------------------
-- [102/185] QST00000000000000000621 | option | Level 3 / Sublevel 3 / Materi: Permintaan Makanan 
-- Sebelum: 7. اسم مفعول of طَعِمَ is…
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E372E20D8A7D8B3D98520D985D981D8B9D988D984206F6620D8B7D98ED8B9D990D985D98E206973E280A6 USING latin1)
WHERE `id` = 'QST00000000000000000621';

-- ------------------------------------------------------------
-- [103/185] QST00000000000000000696 | option | Level 3 / Sublevel 4 / Materi: Aturan Iman dan Perbuatan!
-- Sebelum: 6. فعل أمر of خَافَ is…
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E362E20D981D8B9D98420D8A3D985D8B1206F6620D8AED98ED8A7D981D98E206973E280A6 USING latin1)
WHERE `id` = 'QST00000000000000000696';

-- ------------------------------------------------------------
-- [104/185] QST00000000000000001022 | option | Level 3 / Sublevel 4 / Materi: Cerita Sapi! 
-- Sebelum: 5. فعل مضارع of هَزَأَ is:
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E352E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206F6620D987D98ED8B2D98ED8A3D98E2069733A USING latin1)
WHERE `id` = 'QST00000000000000001022';

-- ------------------------------------------------------------
-- [105/185] QST00000000000000001023 | option | Level 3 / Sublevel 4 / Materi: Cerita Sapi! 
-- Sebelum: 6. فعل امر of سَرَّ is…
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E362E20D981D8B9D98420D8A7D985D8B1206F6620D8B3D98ED8B1D991D98E206973E280A6 USING latin1)
WHERE `id` = 'QST00000000000000001023';

-- ------------------------------------------------------------
-- [106/185] QST00000000000000000746 | option | Level 3 / Sublevel 4 / Materi: Janji di bawah Gunung Tursina
-- Sebelum: 5. فعل امر of كَانَ is:
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E352E20D981D8B9D98420D8A7D985D8B1206F6620D983D98ED8A7D986D98E2069733A USING latin1)
WHERE `id` = 'QST00000000000000000746';

-- ------------------------------------------------------------
-- [107/185] QST00000000000000000748 | option | Level 3 / Sublevel 4 / Materi: Janji di bawah Gunung Tursina
-- Sebelum: 7. اسم فَاعِل of ذَكَرَ is…
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E372E20D8A7D8B3D98520D981D98ED8A7D8B9D990D984206F6620D8B0D98ED983D98ED8B1D98E206973E280A6 USING latin1)
WHERE `id` = 'QST00000000000000000748';

-- ------------------------------------------------------------
-- [108/185] QST00000000000000000761 | option | Level 3 / Sublevel 4 / Materi: pelanggaran Hari Sabtu 
-- Sebelum: 6. اسم فاعل of خَسَأَ is:
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E362E20D8A7D8B3D98520D981D8A7D8B9D984206F6620D8AED98ED8B3D98ED8A3D98E2069733A USING latin1)
WHERE `id` = 'QST00000000000000000761';

-- ------------------------------------------------------------
-- [109/185] QST00000000000000000762 | option | Level 3 / Sublevel 4 / Materi: pelanggaran Hari Sabtu 
-- Sebelum: 7. فعل امر of جَعَلَ is…
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E372E20D981D8B9D98420D8A7D985D8B1206F6620D8ACD98ED8B9D98ED984D98E206973E280A6 USING latin1)
WHERE `id` = 'QST00000000000000000762';

-- ------------------------------------------------------------
-- [110/185] QST00000000000000001073 | option | Level 3 / Sublevel 5 / Materi: Hati Batu 
-- Sebelum: 5. فعل مضارع of غَفَلَ is:
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E352E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206F6620D8BAD98ED981D98ED984D98E2069733A USING latin1)
WHERE `id` = 'QST00000000000000001073';

-- ------------------------------------------------------------
-- [111/185] QST00000000000000001074 | option | Level 3 / Sublevel 5 / Materi: Hati Batu 
-- Sebelum: 6. فعل امر of تَفَجَّرَ is:
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E362E20D981D8B9D98420D8A7D985D8B1206F6620D8AAD98ED981D98ED8ACD991D98ED8B1D98E2069733A USING latin1)
WHERE `id` = 'QST00000000000000001074';

-- ------------------------------------------------------------
-- [112/185] QST00000000000000001093 | option | Level 3 / Sublevel 5 / Materi: Mereka Berubah dan Bersembunyi 
-- Sebelum: 5. فعل ماض of يَطْمَعُ is:
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E352E20D981D8B9D98420D985D8A7D8B6206F6620D98AD98ED8B7D992D985D98ED8B9D98F2069733A USING latin1)
WHERE `id` = 'QST00000000000000001093';

-- ------------------------------------------------------------
-- [113/185] QST00000000000000001094 | option | Level 3 / Sublevel 5 / Materi: Mereka Berubah dan Bersembunyi 
-- Sebelum: 6. اسم مفعول of حَاجَّ is…
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E362E20D8A7D8B3D98520D985D981D8B9D988D984206F6620D8ADD98ED8A7D8ACD991D98E206973E280A6 USING latin1)
WHERE `id` = 'QST00000000000000001094';

-- ------------------------------------------------------------
-- [114/185] QST00000000000000001095 | option | Level 3 / Sublevel 5 / Materi: Mereka Berubah dan Bersembunyi 
-- Sebelum: 7. فعل امر of حَرَّفَ is:
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E372E20D981D8B9D98420D8A7D985D8B1206F6620D8ADD98ED8B1D991D98ED981D98E2069733A USING latin1)
WHERE `id` = 'QST00000000000000001095';

-- ------------------------------------------------------------
-- [115/185] QST00000000000000003205 | option | Level 3 / Sublevel 5 / Materi: Pembunuh
-- Sebelum: 5. فعل مضارع of قَتَلَ is:
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E352E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206F6620D982D98ED8AAD98ED984D98E2069733A USING latin1)
WHERE `id` = 'QST00000000000000003205';

-- ------------------------------------------------------------
-- [116/185] QST00000000000000003206 | option | Level 3 / Sublevel 5 / Materi: Pembunuh
-- Sebelum: 6. فعل مضارع of كَتَمَ is:
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E362E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206F6620D983D98ED8AAD98ED985D98E2069733A USING latin1)
WHERE `id` = 'QST00000000000000003206';

-- ------------------------------------------------------------
-- [117/185] QST00000000000000001043 | option | Level 3 / Sublevel 5 / Materi: Pertanyaan Ketiga
-- Sebelum: 5. فعل مضارع of دَعَا is:
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E352E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206F6620D8AFD98ED8B9D98ED8A72069733A USING latin1)
WHERE `id` = 'QST00000000000000001043';

-- ------------------------------------------------------------
-- [118/185] QST00000000000000001044 | option | Level 3 / Sublevel 5 / Materi: Pertanyaan Ketiga
-- Sebelum: 6. اسم مفعول of سَقٰى is…
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E362E20D8A7D8B3D98520D985D981D8B9D988D984206F6620D8B3D98ED982D9B0D989206973E280A6 USING latin1)
WHERE `id` = 'QST00000000000000001044';

-- ------------------------------------------------------------
-- [119/185] FQT00000000000000001065 | drag | Level 4 | Final Test
-- Sebelum: 9. فعل مضارع of  خَلَدَ is…
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E392E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206F662020D8AED98ED984D98ED8AFD98E206973E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000001065';

-- ------------------------------------------------------------
-- [120/185] FQT00000000000000001073 | drag | Level 4 | Final Test
-- Sebelum: 15. فعل أمر of حَرَّمَ is…
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E31352E20D981D8B9D98420D8A3D985D8B1206F6620D8ADD98ED8B1D991D98ED985D98E206973E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000001073';

-- ------------------------------------------------------------
-- [121/185] FQT00000000000000001078 | drag | Level 4 | Final Test
-- Sebelum: 20. فعل مضارع of قَلَّ is…
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E32302E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206F6620D982D98ED984D991D98E206973E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000001078';

-- ------------------------------------------------------------
-- [122/185] FQT00000000000000001086 | option | Level 4 | Final Test
-- Sebelum: 27. فعل مضارع of اِتَّخَذَ is…
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E32372E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206F6620D8A7D990D8AAD991D98ED8AED98ED8B0D98E206973E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000001086';

-- ------------------------------------------------------------
-- [123/185] FQT00000000000000001097 | option | Level 4 | Final Test
-- Sebelum: 35. فعل أمر of وَجَدَ is…
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E33352E20D981D8B9D98420D8A3D985D8B1206F6620D988D98ED8ACD98ED8AFD98E206973E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000001097';

-- ------------------------------------------------------------
-- [124/185] FQT00000000000000001100 | option | Level 4 | Final Test
-- Sebelum: 38. فعل مضارع of فَسَقَ is…
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E33382E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206F6620D981D98ED8B3D98ED982D98E206973E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000001100';

-- ------------------------------------------------------------
-- [125/185] FQT00000000000000001103 | option | Level 4 | Final Test
-- Sebelum: 40. فعل مضارع of عَاهَدَ is…
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E34302E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206F6620D8B9D98ED8A7D987D98ED8AFD98E206973E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000001103';

-- ------------------------------------------------------------
-- [126/185] FQT00000000000000001111 | option | Level 4 | Final Test
-- Sebelum: 45. فعل أمر of تَعَلَّمَ is…
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E34352E20D981D8B9D98420D8A3D985D8B1206F6620D8AAD98ED8B9D98ED984D991D98ED985D98E206973E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000001111';

-- ------------------------------------------------------------
-- [127/185] FQT00000000000000001114 | option | Level 4 | Final Test
-- Sebelum: 48. فعل مضارع of اِتَّقٰى is…
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E34382E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206F6620D8A7D990D8AAD991D98ED982D9B0D989206973E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000001114';

-- ------------------------------------------------------------
-- [128/185] FQT00000000000000001116 | drag | Level 4 | Final Test
-- Sebelum: 50. فعل مضارع of اِتَّقٰى is…
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E35302E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206F6620D8A7D990D8AAD991D98ED982D9B0D989206973E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000001116';

-- ------------------------------------------------------------
-- [129/185] FQT00000000000000000827 | option | Level 4 / Sublevel 1 | Ujian Pelajaran
-- Sebelum: 9. فعل مضارع of  خَلَدَ is…
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E392E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206F662020D8AED98ED984D98ED8AFD98E206973E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000827';

-- ------------------------------------------------------------
-- [130/185] FQT00000000000000000929 | drag | Level 4 / Sublevel 2 | Ujian Pelajaran
-- Sebelum: 6. فعل أمر of حَرَّمَ is…
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E362E20D981D8B9D98420D8A3D985D8B1206F6620D8ADD98ED8B1D991D98ED985D98E206973E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000929';

-- ------------------------------------------------------------
-- [131/185] FQT00000000000000001304 | option | Level 4 / Sublevel 2 | Ujian Pelajaran
-- Sebelum: 12. فعل مضارع of قَلَّ is…
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E31322E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206F6620D982D98ED984D991D98E206973E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000001304';

-- ------------------------------------------------------------
-- [132/185] FQT00000000000000000973 | option | Level 4 / Sublevel 3 | Ujian Pelajaran
-- Sebelum: 9. فعل مضارع of اِتَّخَذَ is…
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E392E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206F6620D8A7D990D8AAD991D98ED8AED98ED8B0D98E206973E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000973';

-- ------------------------------------------------------------
-- [133/185] FQT00000000000000001006 | option | Level 4 / Sublevel 4 | Ujian Pelajaran
-- Sebelum: 6. فعل أمر of وَجَدَ is…
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E362E20D981D8B9D98420D8A3D985D8B1206F6620D988D98ED8ACD98ED8AFD98E206973E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000001006';

-- ------------------------------------------------------------
-- [134/185] FQT00000000000000001012 | option | Level 4 / Sublevel 4 | Ujian Pelajaran
-- Sebelum: 9. فعل مضارع of فَسَقَ is…
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E392E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206F6620D981D98ED8B3D98ED982D98E206973E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000001012';

-- ------------------------------------------------------------
-- [135/185] FQT00000000000000001016 | option | Level 4 / Sublevel 4 | Ujian Pelajaran
-- Sebelum: 12. فعل مضارع of عَاهَدَ is…
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E31322E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206F6620D8B9D98ED8A7D987D98ED8AFD98E206973E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000001016';

-- ------------------------------------------------------------
-- [136/185] FQT00000000000000000712 | option | Level 4 / Sublevel 5 | Ujian Pelajaran
-- Sebelum: 6. فعل أمر of تَعَلَّمَ is…
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E362E20D981D8B9D98420D8A3D985D8B1206F6620D8AAD98ED8B9D98ED984D991D98ED985D98E206973E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000712';

-- ------------------------------------------------------------
-- [137/185] FQT00000000000000000715 | option | Level 4 / Sublevel 5 | Ujian Pelajaran
-- Sebelum: 9. فعل مضارع of اِتَّقٰى is…
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E392E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206F6620D8A7D990D8AAD991D98ED982D9B0D989206973E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000715';

-- ------------------------------------------------------------
-- [138/185] FQT00000000000000000718 | option | Level 4 / Sublevel 5 | Ujian Pelajaran
-- Sebelum: 12. فعل مضارع of اِتَّقٰى is…
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E31322E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206F6620D8A7D990D8AAD991D98ED982D9B0D989206973E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000718';

-- ------------------------------------------------------------
-- [139/185] QST00000000000000001128 | option | Level 4 / Sublevel 1 / Materi: Api tidak akan menyentuh?
-- Sebelum: 5. فعل أمر of عَدَّ is
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E352E20D981D8B9D98420D8A3D985D8B1206F6620D8B9D98ED8AFD991D98E206973 USING latin1)
WHERE `id` = 'QST00000000000000001128';

-- ------------------------------------------------------------
-- [140/185] QST00000000000000001140 | option | Level 4 / Sublevel 1 / Materi: Aturan keadilan
-- Sebelum: 5. فعل مضارع of  خَلَدَ is
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E352E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206F662020D8AED98ED984D98ED8AFD98E206973 USING latin1)
WHERE `id` = 'QST00000000000000001140';

-- ------------------------------------------------------------
-- [141/185] QST00000000000000001165 | drag | Level 4 / Sublevel 1 / Materi: Perjanjian Bani Israel
-- Sebelum: 5. فعل مضارع of أَقَامَ is
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E352E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206F6620D8A3D98ED982D98ED8A7D985D98E206973 USING latin1)
WHERE `id` = 'QST00000000000000001165';

-- ------------------------------------------------------------
-- [142/185] QST00000000000000001213 | drag | Level 4 / Sublevel 2 / Materi: Pembunuhan & pengusiran
-- Sebelum: 5. فعل أمر dari حَرَّمَ adalah…
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E352E20D981D8B9D98420D8A3D985D8B1206461726920D8ADD98ED8B1D991D98ED985D98E206164616C6168E280A6 USING latin1)
WHERE `id` = 'QST00000000000000001213';

-- ------------------------------------------------------------
-- [143/185] QST00000000000000001277 | drag | Level 4 / Sublevel 2 / Materi: Perawatan dengan Musa & Isa & Rasul lainnya
-- Sebelum: 5. فعل مضارع of قَلَّ is…
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E352E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206F6620D982D98ED984D991D98E206973E280A6 USING latin1)
WHERE `id` = 'QST00000000000000001277';

-- ------------------------------------------------------------
-- [144/185] QST00000000000000001254 | drag | Level 4 / Sublevel 2 / Materi: Percaya pada bagian?
-- Sebelum: 5. فعل مضارع of  اِشْتَرٰى is…
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E352E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206F662020D8A7D990D8B4D992D8AAD98ED8B1D9B0D989206973E280A6 USING latin1)
WHERE `id` = 'QST00000000000000001254';

-- ------------------------------------------------------------
-- [145/185] QST00000000000000001334 | drag | Level 4 / Sublevel 3 / Materi: " Kami percaya pada buku kami "
-- Sebelum: 5. فعل مضارع of اِتَّخَذَ is…
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E352E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206F6620D8A7D990D8AAD991D98ED8AED98ED8B0D98E206973E280A6 USING latin1)
WHERE `id` = 'QST00000000000000001334';

-- ------------------------------------------------------------
-- [146/185] QST00000000000000001356 | drag | Level 4 / Sublevel 3 / Materi: Perjanjian gunung tursinai
-- Sebelum: 5. فعل مضارع of عَصٰى is…
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E352E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206F6620D8B9D98ED8B5D9B0D989206973E280A6 USING latin1)
WHERE `id` = 'QST00000000000000001356';

-- ------------------------------------------------------------
-- [147/185] QST00000000000000001311 | drag | Level 4 / Sublevel 3 / Materi: Transaksi jahat kufur
-- Sebelum: 5. فعل أمر of أَهَانَ is…
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E352E20D981D8B9D98420D8A3D985D8B1206F6620D8A3D98ED987D98ED8A7D986D98E206973E280A6 USING latin1)
WHERE `id` = 'QST00000000000000001311';

-- ------------------------------------------------------------
-- [148/185] QST00000000000000001400 | option | Level 4 / Sublevel 4 / Materi: Bermusuhan dengan jibril
-- Sebelum: 5. فعل مضارع of فَسَقَ is…
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E352E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206F6620D981D98ED8B3D98ED982D98E206973E280A6 USING latin1)
WHERE `id` = 'QST00000000000000001400';

-- ------------------------------------------------------------
-- [149/185] QST00000000000000001412 | drag | Level 4 / Sublevel 4 / Materi: Buang janji
-- Sebelum: 5. فعل مضارع of عَاهَدَ is…
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E352E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206F6620D8B9D98ED8A7D987D98ED8AFD98E206973E280A6 USING latin1)
WHERE `id` = 'QST00000000000000001412';

-- ------------------------------------------------------------
-- [150/185] QST00000000000000001388 | option | Level 4 / Sublevel 4 / Materi: Mereka mencintai hidup ini
-- Sebelum: 5. فعل أمر of وَجَدَ is…\n
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E352E20D981D8B9D98420D8A3D985D8B1206F6620D988D98ED8ACD98ED8AFD98E206973E280A60A USING latin1)
WHERE `id` = 'QST00000000000000001388';

-- ------------------------------------------------------------
-- [151/185] QST00000000000000001460 | drag | Level 4 / Sublevel 5 / Materi: Jangan katakan Ra'ina
-- Sebelum: 5. فعل مضارع of اِتَّقٰى is…
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E352E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206F6620D8A7D990D8AAD991D98ED982D9B0D989206973E280A6 USING latin1)
WHERE `id` = 'QST00000000000000001460';

-- ------------------------------------------------------------
-- [152/185] QST00000000000000001435 | option | Level 4 / Sublevel 5 / Materi: Memisahkan suami & istri
-- Sebelum: 5. فعل أمر of تَعَلَّمَ is…
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E352E20D981D8B9D98420D8A3D985D8B1206F6620D8AAD98ED8B9D98ED984D991D98ED985D98E206973E280A6 USING latin1)
WHERE `id` = 'QST00000000000000001435';

-- ------------------------------------------------------------
-- [153/185] QST00000000000000001447 | drag | Level 4 / Sublevel 5 / Materi: Perdagangan jahat, secara sadar
-- Sebelum: 4. فعل مضارع of اِتَّقٰى is…
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E342E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206F6620D8A7D990D8AAD991D98ED982D9B0D989206973E280A6 USING latin1)
WHERE `id` = 'QST00000000000000001447';

-- ------------------------------------------------------------
-- [154/185] FQT00000000000000000800 | drag | Level 5 | Final Test
-- Sebelum: 5. فعل أمر of تَبَدَّلَ is…
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E352E20D981D8B9D98420D8A3D985D8B1206F6620D8AAD98ED8A8D98ED8AFD991D98ED984D98E206973E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000800';

-- ------------------------------------------------------------
-- [155/185] FQT00000000000000000803 | drag | Level 5 | Final Test
-- Sebelum: 8. فعل مضارع of  قَدَّمَ is…
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E382E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206F662020D982D98ED8AFD991D98ED985D98E206973E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000803';

-- ------------------------------------------------------------
-- [156/185] FQT00000000000000000809 | drag | Level 5 | Final Test
-- Sebelum: 14. فعل أمر of سَعٰى is…
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E31342E20D981D8B9D98420D8A3D985D8B1206F6620D8B3D98ED8B9D9B0D989206973E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000809';

-- ------------------------------------------------------------
-- [157/185] FQT00000000000000000823 | drag | Level 5 | Final Test
-- Sebelum: 22. فعل أمر of نَصَرَ is…
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E32322E20D981D8B9D98420D8A3D985D8B1206F6620D986D98ED8B5D98ED8B1D98E206973E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000823';

-- ------------------------------------------------------------
-- [158/185] FQT00000000000000000833 | drag | Level 5 | Final Test
-- Sebelum: 25.  فعل مضارع of  عَهِدَ is…
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E32352E2020D981D8B9D98420D985D8B6D8A7D8B1D8B9206F662020D8B9D98ED987D990D8AFD98E206973E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000833';

-- ------------------------------------------------------------
-- [159/185] FQT00000000000000000836 | drag | Level 5 | Final Test
-- Sebelum: 28.  فعل مضارع of قَلَّ is…
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E32382E2020D981D8B9D98420D985D8B6D8A7D8B1D8B9206F6620D982D98ED984D991D98E206973E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000836';

-- ------------------------------------------------------------
-- [160/185] FQT00000000000000000845 | option | Level 5 | Final Test
-- Sebelum: 37. فعل مضارع of  مَاتَ is…
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E33372E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206F662020D985D98ED8A7D8AAD98E206973E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000845';

-- ------------------------------------------------------------
-- [161/185] FQT00000000000000000852 | option | Level 5 | Final Test
-- Sebelum: 44. فعل أمر of تَوَلّٰى is…
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E34342E20D981D8B9D98420D8A3D985D8B1206F6620D8AAD98ED988D98ED984D991D9B0D989206973E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000852';

-- ------------------------------------------------------------
-- [162/185] FQT00000000000000000741 | option | Level 5 / Sublevel 1 | Ujian Pelajaran
-- Sebelum: 6. فعل أمر of تَبَدَّلَ is…
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E362E20D981D8B9D98420D8A3D985D8B1206F6620D8AAD98ED8A8D98ED8AFD991D98ED984D98E206973E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000741';

-- ------------------------------------------------------------
-- [163/185] FQT00000000000000000744 | option | Level 5 / Sublevel 1 | Ujian Pelajaran
-- Sebelum: 9. فعل مضارع of  قَدَّمَ is…
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E392E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206F662020D982D98ED8AFD991D98ED985D98E206973E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000744';

-- ------------------------------------------------------------
-- [164/185] FQT00000000000000000747 | option | Level 5 / Sublevel 1 | Ujian Pelajaran
-- Sebelum: 12. فعل مضارع of خَافَ is…
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E31322E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206F6620D8AED98ED8A7D981D98E206973E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000747';

-- ------------------------------------------------------------
-- [165/185] FQT00000000000000000753 | option | Level 5 / Sublevel 2 | Ujian Pelajaran
-- Sebelum: 6. فعل أمر of سَعٰى is…
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E362E20D981D8B9D98420D8A3D985D8B1206F6620D8B3D98ED8B9D9B0D989206973E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000753';

-- ------------------------------------------------------------
-- [166/185] FQT00000000000000000765 | option | Level 5 / Sublevel 3 | Ujian Pelajaran
-- Sebelum: 6. فعل أمر of نَصَرَ is…
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E362E20D981D8B9D98420D8A3D985D8B1206F6620D986D98ED8B5D98ED8B1D98E206973E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000765';

-- ------------------------------------------------------------
-- [167/185] FQT00000000000000000768 | option | Level 5 / Sublevel 3 | Ujian Pelajaran
-- Sebelum: 9. فعل مضارع of  عَهِدَ is…
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E392E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206F662020D8B9D98ED987D990D8AFD98E206973E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000768';

-- ------------------------------------------------------------
-- [168/185] FQT00000000000000000771 | option | Level 5 / Sublevel 3 | Ujian Pelajaran
-- Sebelum: 12. فعل مضارع of قَلَّ is…
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E31322E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206F6620D982D98ED984D991D98E206973E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000771';

-- ------------------------------------------------------------
-- [169/185] FQT00000000000000000780 | option | Level 5 / Sublevel 4 | Ujian Pelajaran
-- Sebelum: 9. فعل مضارع of  مَاتَ is…
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E392E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206F662020D985D98ED8A7D8AAD98E206973E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000780';

-- ------------------------------------------------------------
-- [170/185] FQT00000000000000000789 | option | Level 5 / Sublevel 5 | Ujian Pelajaran
-- Sebelum: 6. فعل أمر of تَوَلّٰى is…
UPDATE `final_exam`
SET `question_en` = CONVERT(0xE2808E362E20D981D8B9D98420D8A3D985D8B1206F6620D8AAD98ED988D98ED984D991D9B0D989206973E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000000789';

-- ------------------------------------------------------------
-- [171/185] QST00000000000000001196 | option | Level 5 / Sublevel 1 / Materi: Jangan Tanya!
-- Sebelum: 5. فعل أمر of تَبَدَّلَ is…
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E352E20D981D8B9D98420D8A3D985D8B1206F6620D8AAD98ED8A8D98ED8AFD991D98ED984D98E206973E280A6 USING latin1)
WHERE `id` = 'QST00000000000000001196';

-- ------------------------------------------------------------
-- [172/185] QST00000000000000001202 | option | Level 5 / Sublevel 1 / Materi: Keinginan Ahli Kitab
-- Sebelum: 5. 5. فعل مضارع of  قَدَّمَ is…
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E352E20352E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206F662020D982D98ED8AFD991D98ED985D98E206973E280A6 USING latin1)
WHERE `id` = 'QST00000000000000001202';

-- ------------------------------------------------------------
-- [173/185] QST00000000000000001207 | option | Level 5 / Sublevel 1 / Materi: Surga Hanya Untuk Orang Yahudi & Kristen ?
-- Sebelum: 5. فعل مضارع of خَافَ is…
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E352E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206F6620D8AED98ED8A7D981D98E206973E280A6 USING latin1)
WHERE `id` = 'QST00000000000000001207';

-- ------------------------------------------------------------
-- [174/185] QST00000000000000001223 | option | Level 5 / Sublevel 2 / Materi: Masjid Blok Yang Tidak Adil
-- Sebelum: 5. فعل أمر of سَعٰى is…
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E352E20D981D8B9D98420D8A3D985D8B1206F6620D8B3D98ED8B9D9B0D989206973E280A6 USING latin1)
WHERE `id` = 'QST00000000000000001223';

-- ------------------------------------------------------------
-- [175/185] QST00000000000000001230 | option | Level 5 / Sublevel 2 / Materi: Nasrani Membuat Seorang Anak Untuk Allah
-- Sebelum: 5. فعل مضارع of  قَالَ is…
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E352E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206F662020D982D98ED8A7D984D98E206973E280A6 USING latin1)
WHERE `id` = 'QST00000000000000001230';

-- ------------------------------------------------------------
-- [176/185] QST00000000000000001240 | option | Level 5 / Sublevel 2 / Materi: Orang Bodoh Berkata: Allah Harus Berbicara dengan Mereka
-- Sebelum: 5. فعل مضارع of كَلَّمَ is…
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E352E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206F6620D983D98ED984D991D98ED985D98E206973E280A6 USING latin1)
WHERE `id` = 'QST00000000000000001240';

-- ------------------------------------------------------------
-- [177/185] QST00000000000000001255 | option | Level 5 / Sublevel 3 / Materi: Bani Israel! ingat nikmatnya
-- Sebelum: 5. فعل أمر of نَصَرَ is…
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E352E20D981D8B9D98420D8A3D985D8B1206F6620D986D98ED8B5D98ED8B1D98E206973E280A6 USING latin1)
WHERE `id` = 'QST00000000000000001255';

-- ------------------------------------------------------------
-- [178/185] QST00000000000000001276 | option | Level 5 / Sublevel 3 / Materi: Rumah Allah & kota
-- Sebelum: 5. فعل مضارع of قَلَّ is…
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E352E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206F6620D982D98ED984D991D98E206973E280A6 USING latin1)
WHERE `id` = 'QST00000000000000001276';

-- ------------------------------------------------------------
-- [179/185] QST00000000000000001265 | option | Level 5 / Sublevel 3 / Materi: Ujian Ibrahim
-- Sebelum: 5. فعل مضارع of  عَهِدَ is…
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E352E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206F662020D8B9D98ED987D990D8AFD98E206973E280A6 USING latin1)
WHERE `id` = 'QST00000000000000001265';

-- ------------------------------------------------------------
-- [180/185] QST00000000000000001332 | option | Level 5 / Sublevel 4 / Materi: Bangsa meninggal
-- Sebelum: 5. فعل مضارع of سَأَلَ is…
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E352E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206F6620D8B3D98ED8A3D98ED984D98E206973E280A6 USING latin1)
WHERE `id` = 'QST00000000000000001332';

-- ------------------------------------------------------------
-- [181/185] QST00000000000000001322 | option | Level 5 / Sublevel 4 / Materi: Instruksi Ibrahim & Yaqub
-- Sebelum: 5. فعل مضارع of  مَاتَ is…
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E352E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206F662020D985D98ED8A7D8AAD98E206973E280A6 USING latin1)
WHERE `id` = 'QST00000000000000001322';

-- ------------------------------------------------------------
-- [182/185] QST00000000000000001295 | option | Level 5 / Sublevel 4 / Materi: Siapa yang akan berpaling dari agama Ibrahim
-- Sebelum: 5. فعل أمر of أَسْلَمَ is…
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E352E20D981D8B9D98420D8A3D985D8B1206F6620D8A3D98ED8B3D992D984D98ED985D98E206973E280A6 USING latin1)
WHERE `id` = 'QST00000000000000001295';

-- ------------------------------------------------------------
-- [183/185] QST00000000000000001364 | option | Level 5 / Sublevel 5 / Materi: Anda membantah tentang Allah
-- Sebelum: 5. فعل مضارع of  أَخْلَصَ is…
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E352E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206F662020D8A3D98ED8AED992D984D98ED8B5D98E206973E280A6 USING latin1)
WHERE `id` = 'QST00000000000000001364';

-- ------------------------------------------------------------
-- [184/185] QST00000000000000001353 | option | Level 5 / Sublevel 5 / Materi: Keyakinan yang ideal
-- Sebelum: 5. فعل أمر of تَوَلّٰى is…
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E352E20D981D8B9D98420D8A3D985D8B1206F6620D8AAD98ED988D98ED984D991D9B0D989206973E280A6 USING latin1)
WHERE `id` = 'QST00000000000000001353';

-- ------------------------------------------------------------
-- [185/185] QST00000000000000001373 | option | Level 5 / Sublevel 5 / Materi: Paling tidak adil membunyikan kesaksian
-- Sebelum: 5. فعل مضارع of كَسَبَ is…
UPDATE `soal`
SET `question_en` = CONVERT(0xE2808E352E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206F6620D983D98ED8B3D98ED8A8D98E206973E280A6 USING latin1)
WHERE `id` = 'QST00000000000000001373';

COMMIT;

-- ============================================================
-- VERIFIKASI
-- ============================================================

-- 1) Harus 185 baris, semua prefix_hex = E2808E
SELECT 'final_exam' AS tabel, id, HEX(LEFT(question_en, 3)) AS prefix_hex, question_en
FROM `final_exam`
WHERE id IN (
  'FQT00000000000000001372',
  'FQT00000000000000001393',
  'FQT00000000000000001394',
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
  'FQT00000000000000001194',
  'FQT00000000000000001201',
  'FQT00000000000000001207',
  'FQT00000000000000001216',
  'FQT00000000000000001219',
  'FQT00000000000000001221',
  'FQT00000000000000001243',
  'FQT00000000000000000495',
  'FQT00000000000000000499',
  'FQT00000000000000000504',
  'FQT00000000000000000509',
  'FQT00000000000000000533',
  'FQT00000000000000000539',
  'FQT00000000000000000543',
  'FQT00000000000000000547',
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
  'FQT00000000000000001016',
  'FQT00000000000000000712',
  'FQT00000000000000000715',
  'FQT00000000000000000718',
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
SELECT 'soal' AS tabel, id, HEX(LEFT(question_en, 3)) AS prefix_hex, question_en
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
  'QST00000000000000001213',
  'QST00000000000000001277',
  'QST00000000000000001254',
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

-- 2) Hitungan harus 86 dan 99
SELECT COUNT(*) AS total_final_exam
FROM `final_exam`
WHERE id IN (
  'FQT00000000000000001372',
  'FQT00000000000000001393',
  'FQT00000000000000001394',
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
  'FQT00000000000000001194',
  'FQT00000000000000001201',
  'FQT00000000000000001207',
  'FQT00000000000000001216',
  'FQT00000000000000001219',
  'FQT00000000000000001221',
  'FQT00000000000000001243',
  'FQT00000000000000000495',
  'FQT00000000000000000499',
  'FQT00000000000000000504',
  'FQT00000000000000000509',
  'FQT00000000000000000533',
  'FQT00000000000000000539',
  'FQT00000000000000000543',
  'FQT00000000000000000547',
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
  'FQT00000000000000001016',
  'FQT00000000000000000712',
  'FQT00000000000000000715',
  'FQT00000000000000000718',
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
  'QST00000000000000001213',
  'QST00000000000000001277',
  'QST00000000000000001254',
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

-- 3) Total yang sudah berprefix LRM harus 185
SELECT COUNT(*) AS total_prefix_lrm
FROM (
  SELECT id FROM `final_exam` WHERE id IN (
    'FQT00000000000000001372',
    'FQT00000000000000001393',
    'FQT00000000000000001394',
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
    'FQT00000000000000001194',
    'FQT00000000000000001201',
    'FQT00000000000000001207',
    'FQT00000000000000001216',
    'FQT00000000000000001219',
    'FQT00000000000000001221',
    'FQT00000000000000001243',
    'FQT00000000000000000495',
    'FQT00000000000000000499',
    'FQT00000000000000000504',
    'FQT00000000000000000509',
    'FQT00000000000000000533',
    'FQT00000000000000000539',
    'FQT00000000000000000543',
    'FQT00000000000000000547',
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
    'FQT00000000000000001016',
    'FQT00000000000000000712',
    'FQT00000000000000000715',
    'FQT00000000000000000718',
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
  ) AND HEX(LEFT(question_en, 3)) = 'E2808E'
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
    'QST00000000000000001213',
    'QST00000000000000001277',
    'QST00000000000000001254',
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
  ) AND HEX(LEFT(question_en, 3)) = 'E2808E'
) t;

-- 4) Harus 0 baris: tidak boleh ada LRM ganda di question_en
SELECT 'final_exam' AS tabel, id FROM `final_exam`
WHERE id IN (
  'FQT00000000000000001372',
  'FQT00000000000000001393',
  'FQT00000000000000001394',
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
  'FQT00000000000000001194',
  'FQT00000000000000001201',
  'FQT00000000000000001207',
  'FQT00000000000000001216',
  'FQT00000000000000001219',
  'FQT00000000000000001221',
  'FQT00000000000000001243',
  'FQT00000000000000000495',
  'FQT00000000000000000499',
  'FQT00000000000000000504',
  'FQT00000000000000000509',
  'FQT00000000000000000533',
  'FQT00000000000000000539',
  'FQT00000000000000000543',
  'FQT00000000000000000547',
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
  'FQT00000000000000001016',
  'FQT00000000000000000712',
  'FQT00000000000000000715',
  'FQT00000000000000000718',
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
) AND HEX(LEFT(question_en, 6)) = 'E2808EE2808E'
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
  'QST00000000000000001213',
  'QST00000000000000001277',
  'QST00000000000000001254',
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
) AND HEX(LEFT(question_en, 6)) = 'E2808EE2808E';
