-- ============================================
-- RENAME 3 BAB CEOR (hapus karakter khusus di nama)
-- DB: u1642799_baqiapps
--
-- Latar belakang: .htaccess produksi hanya menerima
-- huruf/angka/dash/spasi di URL sublevels/... dan materi/get/...
-- Karakter ( ) dan , pada nama bab CEOR menyebabkan 404.
-- Perbaikan: ganti karakter tsb dengan spasi (nama tetap terbaca jelas).
-- Data yang diupdate: levels.name, sub_levels.level, materi.level
-- (kolom sub_levels.level & materi.level menyimpan NAMA bab, bukan id)
-- ============================================

-- 1) CEOR Bab 2 - Chemical EOR (Polymer Flooding)
--    -> CEOR Bab 2 - Chemical EOR Polymer Flooding
UPDATE levels     SET name='CEOR Bab 2 - Chemical EOR Polymer Flooding' WHERE id='PFC000000009';
UPDATE sub_levels SET level='CEOR Bab 2 - Chemical EOR Polymer Flooding' WHERE level='CEOR Bab 2 - Chemical EOR (Polymer Flooding)';
UPDATE materi     SET level='CEOR Bab 2 - Chemical EOR Polymer Flooding' WHERE level='CEOR Bab 2 - Chemical EOR (Polymer Flooding)';

-- 2) CEOR Bab 3 - Chemical EOR (Surfaktan dan Alkaline)
--    -> CEOR Bab 3 - Chemical EOR Surfaktan dan Alkaline
UPDATE levels     SET name='CEOR Bab 3 - Chemical EOR Surfaktan dan Alkaline' WHERE id='PFC000000010';
UPDATE sub_levels SET level='CEOR Bab 3 - Chemical EOR Surfaktan dan Alkaline' WHERE level='CEOR Bab 3 - Chemical EOR (Surfaktan dan Alkaline)';
UPDATE materi     SET level='CEOR Bab 3 - Chemical EOR Surfaktan dan Alkaline' WHERE level='CEOR Bab 3 - Chemical EOR (Surfaktan dan Alkaline)';

-- 3) CEOR Bab 5 - Perencanaan Proyek, Ekonomi dan Aplikasi CEOR
--    -> CEOR Bab 5 - Perencanaan Proyek Ekonomi dan Aplikasi CEOR
UPDATE levels     SET name='CEOR Bab 5 - Perencanaan Proyek Ekonomi dan Aplikasi CEOR' WHERE id='PFC000000012';
UPDATE sub_levels SET level='CEOR Bab 5 - Perencanaan Proyek Ekonomi dan Aplikasi CEOR' WHERE level='CEOR Bab 5 - Perencanaan Proyek, Ekonomi dan Aplikasi CEOR';
UPDATE materi     SET level='CEOR Bab 5 - Perencanaan Proyek Ekonomi dan Aplikasi CEOR' WHERE level='CEOR Bab 5 - Perencanaan Proyek, Ekonomi dan Aplikasi CEOR';

-- ============================================
-- Selesai. Cek pada level/sub_level/materi yang berubah.
-- ============================================