<?php

namespace Learnow\Services;

final class UploadService
{
    public static function receive(array $file, bool $imagesOnly = false): ?array
    {
        if (($file['error'] ?? UPLOAD_ERR_NO_FILE) === UPLOAD_ERR_NO_FILE) {
            return null;
        }
        if (($file['error'] ?? 1) !== UPLOAD_ERR_OK || ($file['size'] ?? 0) > 5 * 1024 * 1024 || !is_uploaded_file($file['tmp_name'] ?? '')) {
            abort(422, 'Upload a valid file smaller than 5 MB.');
        }
        $mime = (new \finfo(FILEINFO_MIME_TYPE))->file($file['tmp_name']);
        $allowed = $imagesOnly ? ['image/jpeg' => 'jpg','image/png' => 'png'] : ['application/pdf' => 'pdf','text/plain' => 'txt','image/jpeg' => 'jpg','image/png' => 'png'];
        if (!isset($allowed[$mime])) {
            abort(422, 'Allowed files: ' . ($imagesOnly ? 'JPG and PNG.' : 'PDF, TXT, JPG and PNG.'));
        }
        if (str_starts_with($mime, 'image/')) {
            $size = getimagesize($file['tmp_name']);
            if (!$size || $size[0] * $size[1] > 25000000) {
                abort(422, 'This image is invalid or too large.');
            }
        }
        $key = bin2hex(random_bytes(24)) . '.' . $allowed[$mime];
        if (!move_uploaded_file($file['tmp_name'], ROOT . '/storage/uploads/' . $key)) {
            abort(500, 'The file could not be stored. Please try again.');
        } chmod(ROOT . '/storage/uploads/' . $key, 0600);
        return ['key' => $key,'name' => mb_substr(preg_replace('/[^\pL\pN._ -]/u', '_', basename($file['name'])), 0, 180),'mime' => $mime];
    }
    public static function download(array $record, bool $inline = false): never
    {
        $key = $record['file_key'];
        if (!preg_match('/^[a-f0-9]{48}\.(pdf|txt|jpg|png)$/D', $key) || !is_file(ROOT . '/storage/uploads/' . $key)) {
            abort(404, 'File not found.');
        }
        header('Content-Type: ' . $record['file_mime']);
        header('Content-Disposition: ' . ($inline && in_array($record['file_mime'], ['image/jpeg','image/png'], true) ? 'inline' : 'attachment') . '; filename="' . preg_replace('/[^a-zA-Z0-9._ -]/', '_', $record['file_name']) . '"');
        header("Content-Security-Policy: default-src 'none'; sandbox");
        header('Content-Length: ' . filesize(ROOT . '/storage/uploads/' . $key));
        readfile(ROOT . '/storage/uploads/' . $key);
        exit;
    }
}
