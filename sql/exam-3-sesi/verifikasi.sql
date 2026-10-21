-- =====================================================================
-- VERIFIKASI setelah import insert-semua-bab.sql
-- =====================================================================

-- 1. Jumlah soal per bab & per sesi.
--    Target: tiap bab -> Soal Inisialisasi = 10, Final Test = 20,
--                        Final Test Advanced = 20  (total 50 soal/bab)
SELECT lid, excerpt, COUNT(*) AS jumlah, MIN(id) AS id_awal, MAX(id) AS id_akhir
FROM final_exam
WHERE excerpt IN ('Soal Inisialisasi', 'Final Test', 'Final Test Advanced')
  AND lid LIKE 'PFC%'
GROUP BY lid, excerpt
ORDER BY lid, FIELD(excerpt, 'Soal Inisialisasi', 'Final Test', 'Final Test Advanced');


-- 2. Total soal baru yang masuk (target 360).
SELECT COUNT(*) AS total_soal_baru
FROM final_exam
WHERE id BETWEEN 'FQT00000000009200000600' AND 'FQT00000000009200000959';


-- 3. Distribusi tipe soal per sesi (target per bab):
--    Inisialisasi     : option 7, multi 1, drag 1, yesorno 1
--    Final Test Adv.  : option 12, multi 4, drag 2, yesorno 2
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


-- =====================================================================
-- ROLLBACK (jalankan hanya bila ingin membatalkan seluruh soal baru)
-- Soal lama (Final Test 20/bab) tidak tersentuh.
-- =====================================================================
-- DELETE FROM final_exam
-- WHERE id BETWEEN 'FQT00000000009200000600' AND 'FQT00000000009200000959';
