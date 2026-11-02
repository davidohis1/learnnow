<?php

return ['dsn' => env('DB_SOCKET') ? 'mysql:unix_socket=' . env('DB_SOCKET') . ';dbname=' . env('DB_DATABASE') . ';charset=utf8mb4' : 'mysql:host=' . env('DB_HOST') . ';port=' . env('DB_PORT', '3306') . ';dbname=' . env('DB_DATABASE') . ';charset=utf8mb4', 'username' => env('DB_USERNAME'), 'password' => env('DB_PASSWORD')];
