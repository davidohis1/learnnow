<?php

namespace Learnow\Helpers;

final class Router
{
    private array $routes = [];
    public function add(string $method, string $path, callable|array $handler): void
    {
        $this->routes[] = [$method,$path,$handler];
    }
    public function dispatch(string $method, string $path): void
    {
        foreach ($this->routes as [$m,$p,$handler]) {
            $pattern = preg_replace('/\{([a-zA-Z_]+)\}/', '(?P<$1>[^/]+)', $p);
            if (($method === $m || ($method === 'HEAD' && $m === 'GET')) && preg_match('~^' . $pattern . '/?$~D', $path, $match)) {
                $args = [];
                foreach ($match as $k => $v) {
                    if (is_string($k)) {
                        $args[] = rawurldecode($v);
                    }
                } if (is_array($handler) && is_string($handler[0])) {
                    $handler = [new $handler[0](),$handler[1]];
                } $handler(...$args);
                return;
            }
        }
        abort(404, 'This page seems to have taken a different learning path.');
    }
}
