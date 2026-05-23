<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- CSRF Token -->
    <meta name="csrf-token" content="{{ csrf_token() }}">

    <!-- ========== SEO ESSENTIALS ========== -->
    <title>@yield('title','Admin - GPS Tracker')</title>

    <meta name="description" content="GPS Tracker system for real-time vehicle tracking, live location, speed monitoring and route history.">
    <meta name="keywords" content="GPS Tracker, Vehicle Tracking, Bike Tracking, Car Tracking, Live Location, Fleet Monitoring, GPS Device">
    <meta name="author" content="GPS Tracker">

    <!-- ========== OPEN GRAPH (SOCIAL MEDIA SHARE) ========== -->
    <meta property="og:title" content="GPS Tracker System">
    <meta property="og:description" content="Live tracking, route history, speed monitoring & device management.">
    <meta property="og:type" content="website">
    <meta property="og:image" content="{{ asset('images/logo.png') }}">
    <meta property="og:url" content="{{ url('/') }}">
    <meta property="og:site_name" content="GPS Tracker">

    <!-- ========== TWITTER CARD ========== -->
    <meta name="twitter:card" content="summary_large_image">
    <meta name="twitter:title" content="GPS Tracker System">
    <meta name="twitter:description" content="Real-time GPS tracking system with modern dashboard.">
    <meta name="twitter:image" content="{{ asset('images/logo.png') }}">

    <!-- ========== FAVICON SETUP ========== -->
    <link rel="icon" type="image/png" href="{{ asset('images/favicon.png') }}">
    <link rel="apple-touch-icon" href="{{ asset('images/favicon.png') }}">
    <meta name="theme-color" content="#1976D2">

    <!-- CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <!-- Leaflet Draw CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/leaflet.draw/1.0.4/leaflet.draw.css"/>

    <style>
        /* =============================
           Base Layout
        ============================= */
        body {
            background: #f5f6fa;
            overflow: hidden;
        }

        .content-wrap {
            width: 100% !important;
            margin: 0 !important;
            padding: 0 !important;
        }

        .tracking-container {
            display: flex;
            height: calc(100vh - 80px);
            width: 100%;
            overflow: hidden;
            position: relative;
            gap: 12px;
        }

        /* =============================
           Premium Sidebar (FINAL VERSION)
        ============================= */

        .filter-panel {
            width: 340px;
            position: fixed;              /* stays under navbar */
            left: 0;
            top: 60px;                    /* navbar height */
            height: calc(100vh - 60px);

            background: rgba(255,255,255,0.92);
            backdrop-filter: blur(14px);
            border-right: 1px solid rgba(0,0,0,0.08);
            box-shadow: 4px 0 18px rgba(0,0,0,0.10);

            padding: 22px;
            border-top-right-radius: 18px;
            border-bottom-right-radius: 18px;

            overflow-y: auto;
            overflow-x: hidden;

            transform: translateX(-100%);
            transition: transform .35s ease;

            z-index: 99999;               /* above map controls */
        }

        /* Sidebar open */
        .filter-panel.show {
            transform: translateX(0);
        }

        /* Premium Scrollbar */
        .filter-panel::-webkit-scrollbar { width: 6px; }
        .filter-panel::-webkit-scrollbar-thumb {
            background: rgba(0,0,0,0.25);
            border-radius: 4px;
        }
        .filter-panel::-webkit-scrollbar-thumb:hover {
            background: rgba(0,0,0,0.35);
        }

        /* =============================
           Sidebar Elements
        ============================= */

        .filter-header {
            background: rgba(255,255,255,0.7);
            padding: 10px 12px;
            border-radius: 12px;
            margin-bottom: 18px;
            box-shadow: 0 3px 8px rgba(0,0,0,0.08);
        }

        .filter-panel .card {
            border: none;
            border-radius: 14px;
            box-shadow: 0 4px 18px rgba(0,0,0,0.12);
            background: rgba(255,255,255,0.85);
        }

        .filter-panel h6 {
            font-weight: 700;
            color: #1f3e72;
            margin-bottom: 8px;
        }

        .filter-panel p {
            font-size: 13px;
            color: #444;
        }

        .filter-panel hr {
            margin: 10px 0;
            border-top: 1px solid rgba(0,0,0,0.08);
        }

        /* =============================
           Mobile Responsive
        ============================= */
        @media (max-width: 768px) {
            .filter-panel {
                width: 85%;
                top: 60px;
                height: calc(100vh - 60px);
                border-radius: 0 20px 20px 0;
            }
        }

        /* =============================
           Sidebar Toggle Button
        ============================= */
        #toggleSidebar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: linear-gradient(135deg,#1976D2,#0049A8);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 18px;
            cursor: pointer;
            margin-right: 15px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.25);
            transition: .25s;
        }

        #toggleSidebar:hover {
            transform: scale(1.1);
        }

    </style>


    @stack('styles')
</head>

<body>

<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg bg-white shadow-sm px-3 d-flex align-items-center">


    <a class="navbar-brand d-flex align-items-center" href="{{ route('user.dashboard') }}">
        <img src="{{ asset('images/logo.png') }}" class="me-2" style="height:34px;">
        <strong>GPS Tracker</strong>
    </a>

    <div id="toggleSidebar"><i class="fa fa-sliders-h"></i></div>

    <ul class="navbar-nav ms-auto d-flex align-items-center">
        <li class="nav-item me-3">
            <span class="nav-link">{{ auth()->user()->name }}</span>
        </li>
        <li class="nav-item">
            <form method="POST" action="{{ route('logout') }}">
                @csrf
                <button class="btn btn-danger btn-sm"><i class="fa fa-power-off"></i></button>
            </form>
        </li>
    </ul>
</nav>

<!-- PAGE CONTENT -->
<div class="content-wrap">
    @yield('content')
</div>

<!-- JS LIBRARIES -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<!-- Polyline Decorator for arrows -->
<script src="https://unpkg.com/leaflet-polylinedecorator@1.7.0/dist/leaflet.polylineDecorator.min.js"></script>
<script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>

<!-- FIXED: Rotated Marker – stable CDN -->
<script src="https://cdn.jsdelivr.net/npm/leaflet-rotatedmarker@0.2.0/leaflet.rotatedMarker.min.js"></script>

<!-- Pusher -->
<script src="https://js.pusher.com/8.2/pusher.min.js"></script>

<!-- Laravel Echo (IIFE build) -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/laravel-echo/1.15.0/echo.iife.js"></script>

<!-- Leaflet Draw JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/leaflet.draw/1.0.4/leaflet.draw.js"></script>

<!-- Leaflet (already used) -->

@include('user._pusher')

</body>
</html>
