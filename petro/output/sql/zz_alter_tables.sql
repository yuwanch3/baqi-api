-- ============================================
-- ALTER TABEL: PERLUAS KOLOM NAMA (menu Petrofisika & CEOR)
-- Jalankan file ini DULU di phpMyAdmin (DB: u1642799_baqiapps),
-- baru setelah itu import 00_gabungan.sql
--
-- Alasan: kolom nama DB lama lebar 7/10 karakter (untuk "Level 1",
-- "Sublevel 1"), sedangkan nama bab/menu Petrofisika mencapai 64
-- karakter. Tanpa pelebaran, INSERT akan error "Data too long".
-- Operasi ini HANYA melebarkan kolom (varchar 7/10 -> 200);
-- TIDAK menghapus/mengubah data lama sama sekali.
-- ============================================

ALTER TABLE `levels` MODIFY `name` varchar(200) NOT NULL;

ALTER TABLE `sub_levels` MODIFY `name` varchar(200) NOT NULL,
                         MODIFY `level` varchar(200) NOT NULL;

ALTER TABLE `materi` MODIFY `level` varchar(200) NOT NULL,
                     MODIFY `sub_levels` varchar(200) NOT NULL;

-- ============================================
-- Selesai. Setelah ini import 00_gabungan.sql
-- ============================================