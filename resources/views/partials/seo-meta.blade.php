@php
    $brand = config('branding.name');
    $logoUrl = asset(config('branding.logo'));
    $faviconIco = asset(config('branding.favicon'));
    $favicon32 = asset(config('branding.favicon_png', 'branding/favicon/favicon-32x32.png'));
    $favicon16 = asset('branding/favicon/favicon-16x16.png');
    $appleTouch = asset(config('branding.apple_touch_icon', 'branding/favicon/apple-touch-icon.png'));
    $themeColor = config('branding.theme_color');
    $pageTitle = $seoTitle ?? trim($__env->yieldContent('title')) ?: config('branding.seo.default_title');
    $description = $seoDescription ?? config('branding.seo.default_description');
    $keywords = $seoKeywords ?? config('branding.seo.keywords');
    $canonical = $seoCanonical ?? url()->current();
    $ogType = $seoOgType ?? 'website';
@endphp

<title>{{ $pageTitle }}</title>

<meta name="description" content="{{ $description }}">
<meta name="keywords" content="{{ $keywords }}">
<meta name="author" content="{{ $brand }}">
<meta name="robots" content="index, follow">
<link rel="canonical" href="{{ $canonical }}">

<link rel="icon" href="{{ $faviconIco }}" sizes="any">
<link rel="icon" type="image/png" sizes="32x32" href="{{ $favicon32 }}">
<link rel="icon" type="image/png" sizes="16x16" href="{{ $favicon16 }}">
<link rel="apple-touch-icon" sizes="180x180" href="{{ $appleTouch }}">
<meta name="theme-color" content="{{ $themeColor }}">
<meta name="mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-title" content="{{ $brand }}">

<meta property="og:type" content="{{ $ogType }}">
<meta property="og:title" content="{{ $pageTitle }}">
<meta property="og:description" content="{{ $description }}">
<meta property="og:url" content="{{ $canonical }}">
<meta property="og:image" content="{{ $logoUrl }}">
<meta property="og:site_name" content="{{ $brand }}">
<meta property="og:locale" content="{{ str_replace('_', '-', app()->getLocale()) }}">

<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:title" content="{{ $pageTitle }}">
<meta name="twitter:description" content="{{ $description }}">
<meta name="twitter:image" content="{{ $logoUrl }}">
