<?php
/**
 * SKRIP SEKALI-PAKAI (maintenance)
 * ------------------------------------------------------------------
 * Memindahkan foto profil user dari folder lama  : /assets/img/
 * ke folder baru (yang benar-benar di-serve)     : /react/assets/img/
 * lalu memperbarui URL foto di kolom users.picture.
 *
 * Kenapa perlu: domain baqi.jannahku.com me-redirect semua path
 * /assets/* ke baqi-app.jannahku.com (aplikasi lain) sehingga foto
 * lama tidak bisa dibuka (301 -> 404). Path /react/* tidak di-redirect.
 *
 * CARA PAKAI (cukup SEKALI):
 *   1. Buka di browser:
 *      https://baqi.jannahku.com/react/migrate-foto.php?key=BAQIMIGRATE2026
 *   2. Pastikan hasilnya {"moved":..., "updated":..., "missing":...}
 *   3. SETELAH SELESAI, HAPUS file ini dari server.
 * ------------------------------------------------------------------
 */
error_reporting(E_ALL);
ini_set('display_errors', '1');
set_time_limit(0);
date_default_timezone_set("Asia/Jakarta");

define('MIGRATE_KEY', 'BAQIMIGRATE2026');

if ((isset($_GET['key']) ? $_GET['key'] : '') !== MIGRATE_KEY) {
    http_response_code(403);
    header('Content-Type: text/plain; charset=utf-8');
    echo "Forbidden";
    exit;
}

include __DIR__ . "/config/connect.php";
$conn = (new Connection())->get_connection();

$srcDir    = __DIR__ . "/../assets/img/";   // <docroot>/assets/img/       (lokasi lama)
$dstDir    = __DIR__ . "/assets/img/";      // <docroot>/react/assets/img/ (lokasi baru yg di-serve)
$host      = $_SERVER['HTTP_HOST'];
$oldPrefix = 'https://baqi.jannahku.com/assets/img/';
$newPrefix = 'https://' . $host . '/react/assets/img/';

if (!is_dir($dstDir)) { @mkdir($dstDir, 0755, true); }

$moved = 0; $updated = 0; $missing = 0; $errors = array();

$res = $conn->query("SELECT id, picture FROM users WHERE picture LIKE 'https://baqi.jannahku.com/assets/img/%'");
if ($res) {
    while ($row = $res->fetch_assoc()) {
        $path  = parse_url($row['picture'], PHP_URL_PATH);
        $fname = basename($path);
        if ($fname === '') { continue; }

        $src = $srcDir . $fname;
        $dst = $dstDir . $fname;

        if (is_file($src)) {
            if (!is_file($dst)) {
                if (!@copy($src, $dst)) {
                    $errors[] = "gagal copy: " . $fname;
                    continue;
                }
            }
            $moved++;

            $newUrl = $newPrefix . $fname;
            $id     = $conn->real_escape_string($row['id']);
            $nu     = $conn->real_escape_string($newUrl);
            if ($conn->query("UPDATE users SET picture='$nu' WHERE id='$id'")) {
                $updated++;
                @unlink($src); // "pindahkan": hapus file lama setelah sukses
            } else {
                $errors[] = "gagal update DB: " . $row['id'];
            }
        } else {
            $missing++; // file lama tidak ada di server (mis. host api.pondok-huda.com yg sudah mati)
        }
    }
}

header('Content-Type: application/json; charset=utf-8');
echo json_encode(array(
    'status'    => 200,
    'srcDir'    => $srcDir,
    'dstDir'    => $dstDir,
    'newPrefix' => $newPrefix,
    'moved'     => $moved,
    'updated'   => $updated,
    'missing'   => $missing,
    'errors'    => $errors,
), JSON_PRETTY_PRINT);
