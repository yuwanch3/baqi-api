-- =====================================================================
-- VERIFIKASI setelah import (insert-semua-bab.sql ATAU import-perbaikan.sql)
-- Nama excerpt di database: 'Inisialisasi' dan 'Final Advanced' (varchar 15)
-- =====================================================================

-- 1. Jumlah soal per bab & per sesi.
--    Target: tiap bab -> Inisialisasi = 10, Final Test = 20,
--                        Final Advanced = 20  (total 50 soal/bab)
SELECT lid, excerpt, COUNT(*) AS jumlah, MIN(id) AS id_awal, MAX(id) AS id_akhir
FROM final_exam
WHERE excerpt IN ('Inisialisasi', 'Final Test', 'Final Advanced')
  AND lid LIKE 'PFC%'
GROUP BY lid, excerpt
ORDER BY lid, FIELD(excerpt, 'Inisialisasi', 'Final Test', 'Final Advanced');


-- 2. Total soal baru yang masuk (target 360).
SELECT COUNT(*) AS total_soal_baru
FROM final_exam
WHERE id BETWEEN 'FQT00000000009200000600' AND 'FQT00000000009200000959';


-- 3. Distribusi tipe soal per sesi (target per bab):
--    Inisialisasi     : option 7, multi 1, drag 1, yesorno 1
--    Final Advanced   : option 12, multi 4, drag 2, yesorno 2
SELECT excerpt, type, COUNT(*) AS jumlah
FROM final_exam
WHERE id BETWEEN 'FQT00000000009200000600' AND 'FQT00000000009200000959'
GROUP BY excerpt, type
ORDER BY excerpt, type;


-- 4. Pastikan tidak ada ID ganda.
SELECT id, COUNT(*) AS duplikat
FROM final_exam
WHERE id BETWEEN 'FQT00000000009200000600' AND 'FQT00000000009200000959'
GROUP BY id
HAVING COUNT(*) > 1;


-- 5. Pastikan tidak ada opsi/jawaban yang rusak (hasil unserialize = false).
--    Target: 0 baris.
SELECT id, type, excerpt
FROM final_exam
WHERE id BETWEEN 'FQT00000000009200000600' AND 'FQT00000000009200000959'
  AND (options = 'b:0;' OR options_en = 'b:0;'
       OR correct_option = 'b:0;' OR correct_option_en = 'b:0;'
       OR options IS NULL OR options_en IS NULL);


-- 6. Cek soal lama Final Test Bab 2 yang sebelumnya rusak (target: 0 baris).
SELECT id, type, options, correct_option
FROM final_exam
WHERE id = 'FQT00000000009200000389'
  AND (options = 'b:0;' OR correct_option = 'b:0;');


-- 7. Soal drag: hitung jumlah slot (dari correct_option) vs jumlah opsi (dari options).
--    Target: semua baris punya jumlah_opsi = jumlah_slot + 1.
SELECT id,
       (LENGTH(correct_option) - LENGTH(REPLACE(correct_option, 'i:', ''))) / 2 AS jumlah_slot,
       (LENGTH(options) - LENGTH(REPLACE(options, 'i:', ''))) / 2 AS jumlah_opsi
FROM final_exam
WHERE id BETWEEN 'FQT00000000009200000600' AND 'FQT00000000009200000959'
  AND type = 'drag'
HAVING jumlah_opsi <> jumlah_slot + 1;


-- =====================================================================
-- ROLLBACK (jalankan hanya bila ingin membatalkan seluruh soal baru)
-- Soal lama (Final Test 20/bab) tidak tersentuh.
-- =====================================================================
-- DELETE FROM final_exam
-- WHERE id BETWEEN 'FQT00000000009200000600' AND 'FQT00000000009200000959';
