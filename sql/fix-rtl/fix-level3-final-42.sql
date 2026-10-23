-- ============================================================
-- BAQI - Perbaikan arah teks pertanyaan (RTL) - 1 soal
-- ============================================================
-- ID       : FQT00000000000000001243
-- Lokasi   : Level 3 / Final Test / nomor 42
-- Masalah  : pertanyaan diawali "42. " lalu huruf Arab, sehingga
--            seluruh paragraf pertanyaan mengikuti arah RTL.
-- Perbaikan: menambahkan LEFT-TO-RIGHT MARK (U+200E) di awal
--            question (ID) saja. Potongan Arab tetap RTL.
-- Ruang lingkup: HANYA 1 baris ini. question_en, opsi, kunci,
--                dan soal lain tidak diubah.
-- ============================================================

START TRANSACTION;

UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E34322E20D981D8B9D98420D985D8B6D8A7D8B1D8B9206461726920D8AFD98ED8B9D98ED8A7206164616C61683A USING latin1)
WHERE `id` = 'FQT00000000000000001243';

COMMIT;

-- Verifikasi: prefix HEX harus E2808E (U+200E), lalu 34322E20 ("42. ")
SELECT id,
       HEX(LEFT(question, 3)) AS prefix_question,
       question,
       question_en
FROM final_exam
WHERE id = 'FQT00000000000000001243';
