-- ============================================================
-- BAQI - Perbaikan arah teks pertanyaan (RTL) - Level 3 Final Test
-- ============================================================
-- Cakupan: 6 soal (nomor 42 sudah diperbaiki terpisah).
-- Masalah : pertanyaan dimulai "NN. " lalu huruf Arab, sehingga
--           seluruh paragraf pertanyaan mengikuti arah RTL.
-- Perbaikan: LEFT-TO-RIGHT MARK (U+200E) di awal field question
--            (versi Indonesia) saja. Potongan Arab tetap RTL.
-- Tidak diubah: question_en, options, correct_option, soal lain.
-- ============================================================

START TRANSACTION;

-- ------------------------------------------------------------
-- FQT00000000000000001194 | drag
-- Sebelum: 11. مفعول اسم dari ذَبَّحَ adalah…
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E31312E20D985D981D8B9D988D98420D8A7D8B3D985206461726920D8B0D98ED8A8D991D98ED8ADD98E206164616C6168E280A6 USING latin1)
WHERE `id` = 'FQT00000000000000001194';

-- ------------------------------------------------------------
-- FQT00000000000000001201 | option
-- Sebelum: 14. فعل أمر dari وَاعَدَ is:
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E31342E20D981D8B9D98420D8A3D985D8B1206461726920D988D98ED8A7D8B9D98ED8AFD98E2069733A USING latin1)
WHERE `id` = 'FQT00000000000000001201';

-- ------------------------------------------------------------
-- FQT00000000000000001207 | drag
-- Sebelum: 19. اسم مفعول dari اٰمَنَ adalah...
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E31392E20D8A7D8B3D98520D985D981D8B9D988D984206461726920D8A7D9B0D985D98ED986D98E206164616C61682E2E2E USING latin1)
WHERE `id` = 'FQT00000000000000001207';

-- ------------------------------------------------------------
-- FQT00000000000000001216 | drag
-- Sebelum: 25. فعل امر dari أَكَلَ adalah: 
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E32352E20D981D8B9D98420D8A7D985D8B1206461726920D8A3D98ED983D98ED984D98E206164616C61683A20 USING latin1)
WHERE `id` = 'FQT00000000000000001216';

-- ------------------------------------------------------------
-- FQT00000000000000001219 | drag
-- Sebelum: 27. اسم مفعول dari طَعِمَ adalah...
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E32372E20D8A7D8B3D98520D985D981D8B9D988D984206461726920D8B7D98ED8B9D990D985D98E206164616C61682E2E2E USING latin1)
WHERE `id` = 'FQT00000000000000001219';

-- ------------------------------------------------------------
-- FQT00000000000000001221 | drag
-- Sebelum: 29. فعل امر dari ذَلَّ adalah:
UPDATE `final_exam`
SET `question` = CONVERT(0xE2808E32392E20D981D8B9D98420D8A7D985D8B1206461726920D8B0D98ED984D98ED991206164616C61683A USING latin1)
WHERE `id` = 'FQT00000000000000001221';

COMMIT;

-- Verifikasi: prefix HEX harus E2808E (U+200E)
SELECT id,
       HEX(LEFT(question, 3)) AS prefix_question,
       question
FROM final_exam
WHERE id IN (
  'FQT00000000000000001194',
  'FQT00000000000000001201',
  'FQT00000000000000001207',
  'FQT00000000000000001216',
  'FQT00000000000000001219',
  'FQT00000000000000001221'
);
