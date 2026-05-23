<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\App;
use Symfony\Component\HttpFoundation\Response;

class SetLocale
{
    public const SUPPORTED = ['en', 'ar'];

    public function handle(Request $request, Closure $next): Response
    {
        $locale = session('locale');

        if (! $locale && $request->user()) {
            $locale = $request->user()->getLocalePreference();
        }

        if (! in_array($locale, self::SUPPORTED, true)) {
            $locale = config('app.locale', 'ar');
        }

        if (! in_array($locale, self::SUPPORTED, true)) {
            $locale = 'ar';
        }

        App::setLocale($locale);
        session(['locale' => $locale]);

        return $next($request);
    }
}
