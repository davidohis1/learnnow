<?php

declare(strict_types=1);

namespace Learnow\Helpers;

/** File-backed configuration; does not require putenv(), which some shared hosts disable. */
final class Environment
{
    private static array $values = [];

    public static function load(string $file): void
    {
        self::$values = [];
        if (!is_file($file)) {
            return;
        }
        if (!is_readable($file)) {
            throw new \RuntimeException('The environment file is not readable by PHP.');
        }
        foreach (file($file, FILE_IGNORE_NEW_LINES) as $index => $line) {
            $line = trim($index === 0 ? preg_replace('/^\xEF\xBB\xBF/', '', $line) : $line);
            if ($line === '' || str_starts_with($line, '#')) {
                continue;
            }
            if (!preg_match('/^(?:export\s+)?([A-Za-z_][A-Za-z0-9_]*)\s*=\s*(.*)$/D', $line, $m)) {
                throw new \RuntimeException('Invalid environment assignment on line ' . ($index + 1) . '.');
            }
            $value = $m[2];
            if ($value !== '' && ($value[0] === '"' || $value[0] === "'")) {
                $quote = $value[0];
                $end = 0;
                for ($i = 1; $i < strlen($value); $i++) {
                    if ($quote === '"' && $value[$i] === '\\') {
                        $i++;
                        continue;
                    }
                    if ($value[$i] === $quote) {
                        $end = $i;
                        break;
                    }
                }
                if ($end === 0 || !preg_match('/^\s*(?:#.*)?$/D', substr($value, $end + 1))) {
                    throw new \RuntimeException('Invalid quoted environment value on line ' . ($index + 1) . '.');
                }
                $value = substr($value, 1, $end - 1);
                if ($quote === '"') {
                    $value = str_replace(['\\"', '\\\\'], ['"', '\\'], $value);
                }
            } else {
                $value = rtrim(preg_replace('/\s+#.*$/', '', $value));
            }
            self::$values[$m[1]] = $value;
        }
    }

    public static function get(string $key, string $default = ''): string
    {
        $process = function_exists('getenv') ? getenv($key) : false;
        if ($process !== false) {
            return (string)$process;
        }
        if (isset($_ENV[$key]) && is_scalar($_ENV[$key])) {
            return (string)$_ENV[$key];
        }
        return self::$values[$key] ?? $default;
    }

    public static function validate(): void
    {
        foreach (['pdo', 'pdo_mysql', 'mbstring', 'fileinfo', 'openssl', 'ctype'] as $extension) {
            if (!extension_loaded($extension)) {
                throw new \RuntimeException('Required PHP extension missing: ' . $extension);
            }
        }
        if (PHP_VERSION_ID < 80200 || !defined('PASSWORD_ARGON2ID')) {
            throw new \RuntimeException('PHP 8.2+ with Argon2id password support is required.');
        }
        if (!in_array(self::get('APP_ENV'), ['production', 'development', 'testing'], true)) {
            throw new \RuntimeException('APP_ENV must be production, development or testing.');
        }
        $base = Url::base();
        $key = self::get('APP_KEY');
        if (strlen($key) < 48 || preg_match('/^(?:change|replace|paste|your[_-])/i', $key) || preg_match('/^(.)\1+$/sD', $key)) {
            throw new \RuntimeException('APP_KEY must be a new randomly generated secret of at least 48 characters.');
        }
        foreach (['COOKIE_SECURE', 'MAIL_ENABLED'] as $name) {
            if (!in_array(self::get($name, $name === 'COOKIE_SECURE' ? 'true' : 'false'), ['true', 'false', '1', '0'], true)) {
                throw new \RuntimeException($name . ' must be true or false.');
            }
        }
        foreach (['DB_DATABASE', 'DB_USERNAME'] as $name) {
            if (self::get($name) === '') {
                throw new \RuntimeException('Required configuration missing: ' . $name);
            }
        }
        foreach (['DB_DATABASE', 'DB_HOST', 'DB_SOCKET'] as $name) {
            if (preg_match('/[;\x00-\x1f]/', self::get($name))) {
                throw new \RuntimeException('Invalid database configuration: ' . $name);
            }
        }
        if (self::get('DB_SOCKET') === '' && self::get('DB_HOST') === '') {
            throw new \RuntimeException('Set DB_HOST, or a valid DB_SOCKET for a local Unix socket.');
        }
        $port = self::get('DB_PORT', '3306');
        if (!ctype_digit($port) || (int)$port < 1 || (int)$port > 65535) {
            throw new \RuntimeException('DB_PORT must be a valid TCP port.');
        }
        if (!in_array(self::get('DEFAULT_TIMEZONE', 'UTC'), \DateTimeZone::listIdentifiers(), true)) {
            throw new \RuntimeException('DEFAULT_TIMEZONE must be a valid IANA timezone.');
        }
        if (self::get('JWT_ISSUER', 'learnow') === '' || self::get('JWT_AUDIENCE', 'learnow-browser') === '') {
            throw new \RuntimeException('JWT_ISSUER and JWT_AUDIENCE must not be empty.');
        }
        if (self::get('APP_ENV', 'production') === 'production') {
            if (!str_starts_with($base, 'https://') || !filter_var(self::get('COOKIE_SECURE', 'true'), FILTER_VALIDATE_BOOL)) {
                throw new \RuntimeException('Production requires an HTTPS APP_URL and COOKIE_SECURE=true.');
            }
            if (self::get('DB_PASSWORD') === '') {
                throw new \RuntimeException('Production requires a nonempty database password.');
            }
        }
        if (filter_var(self::get('MAIL_ENABLED', 'false'), FILTER_VALIDATE_BOOL)) {
            if (self::get('MAIL_HOST') === '' || !filter_var(self::get('MAIL_FROM'), FILTER_VALIDATE_EMAIL)) {
                throw new \RuntimeException('Enabled mail requires MAIL_HOST and a valid MAIL_FROM address.');
            }
            $mailPort = self::get('MAIL_PORT', '587');
            if (!ctype_digit($mailPort) || (int)$mailPort < 1 || (int)$mailPort > 65535) {
                throw new \RuntimeException('MAIL_PORT must be a valid TCP port.');
            }
        }
        foreach (['logs', 'uploads', 'mail'] as $name) {
            $dir = ROOT . '/storage/' . $name;
            if (!is_dir($dir) && !@mkdir($dir, 0700, true) && !is_dir($dir)) {
                throw new \RuntimeException('Cannot create private storage/' . $name . '. Check ownership and permissions.');
            }
            if (!is_writable($dir)) {
                throw new \RuntimeException('Private storage/' . $name . ' must be writable by PHP.');
            }
        }
    }
}
