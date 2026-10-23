-- Verifikasi setelah import (v2)

-- 1) 9 soal option Arab: HEX harus berisi byte UTF-8 (bukan 3F/?)
SELECT id, correct_option, HEX(correct_option) AS hex_value
FROM final_exam
WHERE id IN ('FQT00000000000000000084','FQT00000000000000000062','FQT00000000000000000151','FQT00000000000000001293','FQT00000000000000001304','FQT00000000000000000729','FQT00000000000000001080','FQT00000000000000001086','FQT00000000000000001111');

-- 2) 3 soal multi Arab: correct_option & correct_option_en harus berbentuk
--    serialized array dengan byte Arab yang benar (bukan 3F)
SELECT id, type, correct_option, HEX(correct_option) AS hex_co, correct_option_en, HEX(correct_option_en) AS hex_co_en
FROM final_exam
WHERE id IN ('FQT00000000000000000045','FQT00000000000000000109','FQT00000000000000000116');

-- 3) Tidak boleh ada sisa correct_option serialized pada type=option
SELECT id, type, LEFT(correct_option, 50) AS correct_option
FROM final_exam
WHERE type = 'option' AND correct_option LIKE 'a:%';

-- 4) 4 soal multi hasil konversi
SELECT id, type, correct_option, correct_option_en
FROM final_exam
WHERE id IN ('FQT00000000000000000045','FQT00000000000000000109','FQT00000000000000000116','FQT00000000000000000703');

-- 5) Soal materi Level 5
SELECT id, options, correct_option, correct_option_en
FROM soal
WHERE id IN ('QST00000000000000001188','QST00000000000000001189');