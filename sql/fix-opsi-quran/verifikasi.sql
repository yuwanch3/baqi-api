-- Verifikasi setelah menjalankan fix-opsi-quran.sql

-- 1) Harus 0 baris: type=option yang correct_option-nya masih serialized
SELECT id, type, LEFT(correct_option, 50) AS correct_option
FROM final_exam
WHERE type = 'option' AND correct_option LIKE 'a:%';

-- 2) 4 soal multi hasil konversi
SELECT id, type, correct_option, correct_option_en
FROM final_exam
WHERE id IN ('FQT00000000000000000045','FQT00000000000000000109','FQT00000000000000000116','FQT00000000000000000703');

-- 3) 12 soal option yang diperbaiki (correct_option harus teks biasa)
SELECT id, type, correct_option
FROM final_exam
WHERE id IN ('FQT00000000000000000084','FQT00000000000000000106','FQT00000000000000000128','FQT00000000000000000062','FQT00000000000000000151','FQT00000000000000001293','FQT00000000000000001304','FQT00000000000000000729','FQT00000000000000001080','FQT00000000000000001081','FQT00000000000000001086','FQT00000000000000001111');

-- 4) Soal materi Level 5 (options sudah 4 item, tanpa opsi nyasar)
SELECT id, options, correct_option, correct_option_en
FROM soal
WHERE id IN ('QST00000000000000001188','QST00000000000000001189');

-- 5) Cek sisa data serialized di tabel soal (harus 0 baris)
SELECT id, type, LEFT(correct_option, 50) AS correct_option
FROM soal
WHERE type = 'option' AND correct_option LIKE 'a:%';