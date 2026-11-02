<?php

namespace Learnow\Validators;

use Learnow\Helpers\HttpError;

final class Validate
{
    public static function text(mixed $v, string $label, int $min = 1, int $max = 500): string
    {
        if (!is_scalar($v) && $v !== null) {
            throw new HttpError(422, "$label is invalid.");
        } $v = trim((string)$v);
        if (mb_strlen($v) < $min || mb_strlen($v) > $max) {
            throw new HttpError(422, "$label must be between $min and $max characters.");
        } return $v;
    }
    public static function email(mixed $v): string
    {
        $v = mb_strtolower(self::text($v, 'Email address', 3, 190));
        if (!filter_var($v, FILTER_VALIDATE_EMAIL)) {
            throw new HttpError(422, 'Enter a valid email address.');
        } return $v;
    }
    public static function password(mixed $v): string
    {
        if (!is_string($v)) {
            throw new HttpError(422, 'Enter a valid password.');
        } if (mb_strlen($v) < 12 || strlen($v) > 128) {
            throw new HttpError(422, 'Use a password with 12–128 characters. A memorable passphrase works well.');
        } return $v;
    }
    public static function int(mixed $v, string $name, int $min, int $max): int
    {
        if (filter_var($v, FILTER_VALIDATE_INT) === false || (int)$v < $min || (int)$v > $max) {
            throw new HttpError(422, "$name must be between $min and $max.");
        } return (int)$v;
    }
    public static function choice(mixed $v, array $allowed, string $name): string
    {
        if (!is_string($v) || !in_array($v, $allowed, true)) {
            throw new HttpError(422, "Choose a valid $name.");
        } return $v;
    }
    public static function timezone(mixed $v): string
    {
        return self::choice($v, \DateTimeZone::listIdentifiers(), 'timezone');
    }
    public static function url(mixed $v, string $name = 'URL'): ?string
    {
        if ($v === '' || $v === null) {
            return null;
        } $v = self::text($v, $name, 1, 2000);
        if (!filter_var($v, FILTER_VALIDATE_URL) || !in_array(strtolower(parse_url($v, PHP_URL_SCHEME) ?? ''), ['https','http'], true) || parse_url($v, PHP_URL_USER) || parse_url($v, PHP_URL_PASS)) {
            throw new HttpError(422, "Enter a complete, safe http or https $name.");
        } return $v;
    }
    public static function youtube(mixed $v): ?string
    {
        $v = self::text($v, 'YouTube URL or ID', 0, 2000);
        if (!$v) {
            return null;
        } if (preg_match('/^[A-Za-z0-9_-]{11}$/D', $v)) {
            return $v;
        } $p = parse_url($v);
        $host = strtolower($p['host'] ?? '');
        $id = '';
        if ($host === 'youtu.be') {
            $id = trim($p['path'] ?? '', '/');
        } elseif (in_array($host, ['www.youtube.com','youtube.com','m.youtube.com','www.youtube-nocookie.com'], true)) {
            parse_str($p['query'] ?? '', $q);
            $id = $q['v'] ?? '';
            if (!$id && preg_match('~^/(?:embed|shorts)/([\w-]{11})$~', $p['path'] ?? '', $m)) {
                $id = $m[1];
            }
        } if (!preg_match('/^[A-Za-z0-9_-]{11}$/D', (string)$id)) {
            throw new HttpError(422, 'Use a valid YouTube URL or 11-character video ID.');
        } return $id;
    }
    public static function ids(mixed $v, int $max = 30): array
    {
        if (!is_array($v) || count($v) > $max) {
            throw new HttpError(422, 'The selection is invalid.');
        } return array_values(array_unique(array_map(fn($id) => self::int($id, 'Selection', 1, 2147483647), $v)));
    }
}
