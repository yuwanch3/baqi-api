# Soal Ujian 3 Sesi — Petrofisika & CEOR

Folder ini berisi soal baru untuk mekanisme ujian **3 sesi per bab**.
Tidak ada perubahan struktur tabel, tidak ada perubahan `.htaccess`, dan
**20 soal `Final Test` yang lama dipakai apa adanya** sebagai Sesi 2.

## Isi folder

| File | Keterangan |
|---|---|
| `bab-01-petrofisika.json` … `bab-12-ceor.json` | Sumber soal (ID + EN), 30 soal per bab |
| `gen-sql.js` | Generator JSON → SQL (PHP serialize otomatis + validasi) |
| `output/bab-XX-*.sql` | Hasil SQL per bab |
| `output/insert-semua-bab.sql` | **File yang diimport** (360 soal, 12 bab) |
| `verifikasi.sql` | Query pengecekan setelah import |

## Rancangan sesi

| Sesi | `excerpt` | Jumlah | Ambang lulus |
|---|---|---|---|
| 1 | `Soal Inisialisasi` | 10 soal | **8/10** |
| 2 | `Final Test` (soal lama) | 20 soal | **18/20** |
| 3 | `Final Test Advanced` | 20 soal | **18/20** |

Distribusi tipe soal:

| Sesi | option | multi | drag | yesorno |
|---|---|---|---|---|
| Soal Inisialisasi (10) | 7 | 1 | 1 | 1 |
| Final Test Advanced (20) | 12 | 4 | 2 | 2 |

## Cara import (phpMyAdmin)

1. Backup dulu tabel `final_exam` (Export → SQL).
2. Buka tab **Import**, pilih `output/insert-semua-bab.sql`, lalu **Go**.
3. Jalankan `verifikasi.sql` dan cocokkan hasilnya:
   - total soal baru = **360**
   - tiap bab: 10 + 20 + 20
   - distribusi tipe sesuai tabel di atas
4. Rollback bila perlu: bagian `DELETE` di akhir `verifikasi.sql`
   (hanya menghapus ID `...0600`–`...0959`, soal lama aman).

## Alur di aplikasi (hanya Petrofisika & CEOR)

1. Buka menu ujian → pilih bab → masuk **Sesi 1**.
2. Selesai sesi:
   - lulus → skor disimpan (`skors`, `excerpt` = sesi) → otomatis lanjut sesi berikutnya;
   - belum lulus → muncul **"Perbaiki soal yang salah, sebelum lanjut"** →
     hanya soal yang salah diulang sampai memenuhi ambang.
3. Sesi 2 memakai 20 soal `Final Test` lama, sesi 3 memakai 20 soal advanced baru.
4. Bab dibuka lagi setelah lulus semua → otomatis menampilkan sesi yang belum selesai;
   bila ketiganya sudah lulus muncul pemberitahuan selesai.

Ujian bahasa (Level 1–5), `Grammer Test`, dan `Ujian Pelajaran` **tidak berubah**
karena alur baru hanya aktif bila layar dibuka dengan parameter `flow: 'petro3'`.

## Regenerate SQL

```bash
cd sql/exam-3-sesi
node gen-sql.js
```

Generator akan menolak data yang tidak valid (jawaban tidak ada di opsi,
jumlah opsi ID ≠ EN, tipe tidak dikenal, dsb).
