<?php

use Learnow\Repositories\DB;
use Learnow\Helpers\HttpError;
use Learnow\Middleware\Auth;
use Learnow\Middleware\Security;
use Learnow\Helpers\Url;
use Learnow\Helpers\Environment;

function env(string $key, string $default = ''): string
{
    return Environment::get($key, $default);
}
/** Idempotent internal reference (including an already-prefixed path or absolute URL). */
function url(string $reference = '', array $query = [], ?string $fragment = null): string
{
    return Url::to($reference, $query, $fragment);
}
/** A logical route, independent of the installation directory. */
function route_url(string $route = '', array $query = [], ?string $fragment = null): string
{
    return Url::route($route, $query, $fragment);
}
function asset_url(string $path): string
{
    return Url::asset($path);
}
function route_path(): string
{
    return Url::currentPath();
}
function e(mixed $value): string
{
    return htmlspecialchars((string)($value ?? ''), ENT_QUOTES | ENT_SUBSTITUTE, 'UTF-8');
}
function abort(int $code, string $message): never
{
    throw new HttpError($code, $message);
}
function input(): array
{
    static $data;
    if ($data === null) {
        if (str_contains($_SERVER['CONTENT_TYPE'] ?? '', 'application/json')) {
            $raw = file_get_contents('php://input');
            if (strlen($raw) > 250000) {
                abort(413, 'This request is too large.');
            } $data = json_decode($raw, true);
            if (!is_array($data)) {
                abort(400, 'Please send valid JSON.');
            }
        } else {
            $data = $_POST;
        }
    } return $data;
}
function jsonResponse(array $data, int $status = 200): never
{
    http_response_code($status);
    header('Content-Type: application/json; charset=utf-8');
    echo json_encode($data, JSON_UNESCAPED_SLASHES | JSON_INVALID_UTF8_SUBSTITUTE);
    exit;
}
function wantsJson(): bool
{
    return str_starts_with(Url::currentPath(), '/api/') || str_contains($_SERVER['HTTP_ACCEPT'] ?? '', 'application/json');
}
function success(string $message, array $data = [], int $status = 200): never
{
    if (isset($data['redirect'])) {
        $data['redirect'] = route_url($data['redirect']);
    }
    if (wantsJson()) {
        jsonResponse(['ok' => true, 'message' => $message] + $data, $status);
    } redirect($data['redirect'] ?? '/dashboard');
}
function redirect(string $path): never
{
    header('Location: ' . route_url($path), true, 303);
    exit;
}
function user(): ?array
{
    return Auth::user();
}
function csrf(): string
{
    return Security::csrfToken();
}
function csrfField(): string
{
    return '<input type="hidden" name="_csrf" value="' . e(csrf()) . '">';
}
function render(string $view, array $data = [], string $layout = 'app'): void
{
    $currentUser = user();
    $title = $data['title'] ?? 'Learnow';
    extract($data, EXTR_SKIP);
    ob_start();
    require ROOT . '/app/Views/pages/' . $view . '.php';
    $content = ob_get_clean();
    require ROOT . '/app/Views/layouts/' . $layout . '.php';
}
function setting(string $key, mixed $default = null): mixed
{
    $v = DB::value('SELECT setting_value FROM system_settings WHERE setting_key=?', [$key]);
    return $v === false ? $default : $v;
}
function audit(int $actor, string $action, string $type, mixed $id, array $details = []): void
{
    DB::run('INSERT INTO audit_logs(actor_id,action,entity_type,entity_id,details) VALUES(?,?,?,?,?)', [$actor, $action, $type, (string)$id, json_encode($details)]);
}
function initials(string $name): string
{
    $parts = preg_split('/\s+/', trim($name));
    return mb_strtoupper(mb_substr($parts[0], 0, 1) . (count($parts) > 1 ? mb_substr(end($parts), 0, 1) : ''));
}
function firstName(string $name): string
{
    return explode(' ', trim($name))[0];
}
function number(mixed $n): string
{
    return number_format((float)$n);
}
function niceDate(?string $d, string $format = 'M j, Y'): string
{
    return $d ? (new DateTimeImmutable($d, new DateTimeZone('UTC')))->format($format) : '—';
}
function lines(?string $text): array
{
    return array_values(array_filter(array_map('trim', preg_split('/\r?\n/', $text ?? ''))));
}
function badge(string $value): string
{
    $label = ucwords(str_replace('_', ' ', $value));
    return '<span class="badge badge-' . e($value) . '">' . e($label) . '</span>';
}
function emptyState(string $icon, string $heading, string $description, string $url = '', string $cta = ''): void
{
    echo '<div class="empty-state"><div class="empty-icon">' . icon($icon) . '</div><h3>' . e($heading) . '</h3><p>' . e($description) . '</p>';
    if ($url) {
        echo '<a class="btn btn-primary" href="' . e(route_url($url)) . '">' . e($cta) . icon('arrow-right') . '</a>';
    } echo '</div>';
}
function icon(string $name, int $size = 20, string $class = ''): string
{
    static $icons;
    if ($icons === null) {
        $icons = require ROOT . '/app/Helpers/icons.php';
    }
    return '<svg class="icon ' . e($class) . '" width="' . $size . '" height="' . $size . '" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">' . ($icons[$name] ?? $icons['sparkles']) . '</svg>';
}
function logo(bool $dark = false): string
{
    return '<a class="brand' . ($dark ? ' brand-light' : '') . '" href="' . e(route_url('/')) . '" aria-label="Learnow home"><span class="brand-symbol"><svg width="23" height="25" viewBox="0 0 23 25" fill="none" aria-hidden="true"><path d="M5 3v14a4 4 0 0 0 4 4h10" stroke="currentColor" stroke-width="5.5" stroke-linecap="round"/><path d="m12 4 6 6-6 6" stroke="currentColor" stroke-width="4" stroke-linecap="round" stroke-linejoin="round"/></svg></span><span>learnow<span class="brand-dot">.</span></span></a>';
}
function pageNumber(): int
{
    return max(1, min(10000, (int)($_GET['page'] ?? 1)));
}
function pagination(int $total, int $perPage = 20): void
{
    $p = pageNumber();
    $last = max(1, (int)ceil($total / $perPage));
    if ($last < 2) {
        return;
    } echo '<nav class="pagination" aria-label="Pagination"><span>Page ' . $p . ' of ' . $last . ' · ' . $total . ' results</span><div>';
    foreach (['Previous' => $p - 1, 'Next' => $p + 1] as $label => $n) {
        if ($n < 1 || $n > $last) {
            continue;
        } $q = $_GET;
        $q['page'] = $n;
        echo '<a class="btn btn-small btn-secondary" href="' . e(route_url(route_path(), $q)) . '">' . $label . '</a>';
    } echo '</div></nav>';
}
function lessonHtml(string $text): string
{
    $html = '';
    $paragraph = [];
    $code = [];
    $inCode = false;
    $flush = function () use (&$html, &$paragraph) {
        if ($paragraph) {
            $html .= '<p>' . implode('<br>', array_map('e', $paragraph)) . '</p>';
            $paragraph = [];
        }
    };
    foreach (preg_split('/\r?\n/', $text) as $line) {
        if (str_starts_with(trim($line), '```')) {
            $flush();
            if ($inCode) {
                $html .= '<pre><code>' . e(implode("\n", $code)) . '</code></pre>';
                $code = [];
            }$inCode = !$inCode;
            continue;
        }
        if ($inCode) {
            $code[] = $line;
            continue;
        }
        if (preg_match('/^## (.+)$/', $line, $m)) {
            $flush();
            $html .= '<h2>' . e($m[1]) . '</h2>';
            continue;
        }
        if (trim($line) === '') {
            $flush();
            continue;
        }$paragraph[] = $line;
    }
    $flush();
    if ($inCode) {
        $html .= '<pre><code>' . e(implode("\n", $code)) . '</code></pre>';
    }return $html;
}
