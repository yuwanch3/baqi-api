-- ============================================
-- INSERT LEVEL 6 - 5 SUBLEVEL (sub_levels)
-- Path A: semua teks Arab via CONVERT(0x... USING utf8mb4).
-- File 100% ASCII. CARA IMPORT: phpMyAdmin -> Import -> file ini.
-- ============================================

SET NAMES utf8mb4;

INSERT INTO sub_levels(id, name, level, state_exam, ujian_grammer, ujian_pelajaran, backgroundColor, created, updated) VALUES
('SLV000000000037','Sublevel 1','Level 6','yes','','','#7BA95C','2026-09-25 16:00:00','2026-09-25 16:00:00'),
('SLV000000000038','Sublevel 2','Level 6','yes','','','#EE6C4D','2026-09-25 16:00:00','2026-09-25 16:00:00'),
('SLV000000000039','Sublevel 3','Level 6','yes','','','#A7BD3C','2026-09-25 16:00:00','2026-09-25 16:00:00'),
('SLV000000000040','Sublevel 4','Level 6','yes','','','#7BA95C','2026-09-25 16:00:00','2026-09-25 16:00:00'),
('SLV000000000041','Sublevel 5','Level 6','yes','','','#EE6C4D','2026-09-25 16:00:00','2026-09-25 16:00:00');
