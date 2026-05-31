<?php

require __DIR__.'/../vendor/autoload.php';

$app = require __DIR__.'/../bootstrap/app.php';

foreach (['/', '/up', '/login'] as $path) {
    $request = Illuminate\Http\Request::create($path, 'GET');
    $response = $app->handleRequest($request);
    echo "{$path} => ".$response->getStatusCode().PHP_EOL;
}
