-- =====================================================================
-- Perbaikan 1 soal lama "Final Test" Bab 2 Petrofisika (multi)
-- ID: FQT00000000009200000389 - sebelumnya options & correct_option = false
-- (karakter mu tidak bisa disimpan di kolom latin1, panjang serialize rusak)
-- =====================================================================
UPDATE final_exam SET options = 'a:4:{i:0;s:13:"Laju alir (Q)";i:1;s:14:"Tipe sementasi";i:2;s:22:"Viskositas fluida (mu)";i:3;s:18:"Panjang sampel (L)";}', options_en = 'a:4:{i:0;s:13:"Flow rate (Q)";i:1;s:16:"Cementation type";i:2;s:20:"Fluid viscosity (mu)";i:3;s:17:"Sample length (L)";}', correct_option = 'a:3:{i:0;s:13:"Laju alir (Q)";i:1;s:22:"Viskositas fluida (mu)";i:2;s:18:"Panjang sampel (L)";}', correct_option_en = 'a:3:{i:0;s:13:"Flow rate (Q)";i:1;s:20:"Fluid viscosity (mu)";i:2;s:17:"Sample length (L)";}', updated = '2026-10-22 10:00:00' WHERE id = 'FQT00000000009200000389';
