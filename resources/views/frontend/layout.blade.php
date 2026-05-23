<!DOCTYPE html>
<html lang="{{ $htmlLang ?? 'ar' }}" dir="{{ $htmlDir ?? 'ltr' }}" class="scroll-smooth">
<head>
    <meta charset="UTF-8">
    <title>@yield('title', __('frontend.meta.title'))</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="@yield('description', __('frontend.meta.description'))">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>

    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    @if($isRtl ?? false)
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+Arabic:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="{{ asset('css/frontend-rtl.css') }}?v={{ filemtime(public_path('css/frontend-rtl.css')) }}">
    @endif

    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            darkMode: 'class',
            theme: {
                extend: {
                    fontFamily: {
                        'sans': ['Inter', 'system-ui', 'sans-serif'],
                    },
                    animation: {
                        'float': 'float 6s ease-in-out infinite',
                        'slide-in': 'slide-in 0.5s ease-out',
                        'gradient-x': 'gradient-x 15s ease infinite',
                    },
                    keyframes: {
                        float: {
                            '0%, 100%': { transform: 'translateY(0px)' },
                            '50%': { transform: 'translateY(-20px)' },
                        },
                        'slide-in': {
                            '0%': { transform: 'translateY(20px)', opacity: 0 },
                            '100%': { transform: 'translateY(0)', opacity: 1 },
                        },
                        'gradient-x': {
                            '0%, 100%': { 'background-size': '200% 200%', 'background-position': 'left center' },
                            '50%': { 'background-size': '200% 200%', 'background-position': 'right center' },
                        }
                    }
                }
            }
        }
    </script>

    @stack('head')

    <style>
        /* Mobile Menu Fix */
        .mobile-menu-open {
            max-height: calc(100vh - 80px) !important;
            overflow-y: auto !important;
        }

        .mobile-menu-overlay {
            position: fixed;
            top: 80px;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.5);
            backdrop-filter: blur(4px);
            z-index: 40;
            opacity: 0;
            visibility: hidden;
            transition: all 0.3s ease;
        }

        .mobile-menu-overlay.active {
            opacity: 1;
            visibility: visible;
        }

        /* Ensure content is hidden when menu is open */
        body.menu-open {
            overflow: hidden;
        }

        /* Glass effect */
        .glass {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        .dark .glass {
            background: rgba(15, 23, 42, 0.7);
            border: 1px solid rgba(255, 255, 255, 0.05);
        }

        /* Custom scrollbar for mobile menu */
        .mobile-menu-open::-webkit-scrollbar {
            width: 6px;
        }

        .mobile-menu-open::-webkit-scrollbar-track {
            background: rgba(255, 255, 255, 0.1);
            border-radius: 3px;
        }

        .mobile-menu-open::-webkit-scrollbar-thumb {
            background: rgba(255, 255, 255, 0.3);
            border-radius: 3px;
        }

        .mobile-menu-open::-webkit-scrollbar-thumb:hover {
            background: rgba(255, 255, 255, 0.4);
        }
    </style>
</head>

<body class="font-sans bg-gradient-to-br from-slate-50 to-blue-50 dark:from-slate-950 dark:to-slate-900 text-slate-800 dark:text-slate-100 transition-colors duration-300">
<!-- Animated Background Elements -->
<div class="fixed inset-0 overflow-hidden pointer-events-none z-[-1]">
    <div class="absolute top-1/4 -left-32 w-64 h-64 bg-gradient-to-r from-sky-300/20 to-blue-400/10 rounded-full blur-3xl animate-float"></div>
    <div class="absolute bottom-1/4 -right-32 w-96 h-96 bg-gradient-to-r from-emerald-300/10 to-teal-400/5 rounded-full blur-3xl animate-float" style="animation-delay: 2s"></div>
</div>

{{-- ================= FIXED NAVBAR ================= --}}
<header class="fixed top-0 inset-x-0 z-50 glass border-b border-slate-200 dark:border-slate-800">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex items-center justify-between h-20">
            {{-- Logo --}}
            <div class="flex items-center space-x-3">
                <div class="relative">
                    <div class="w-10 h-10 bg-gradient-to-br from-sky-500 to-blue-600 rounded-xl flex items-center justify-center shadow-lg">
                        <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 20l-5.447-2.724A1 1 0 013 16.382V5.618a1 1 0 011.447-.894L9 7m0 13l6-3m-6 3V7m6 10l4.553 2.276A1 1 0 0021 18.382V7.618a1 1 0 00-.553-.894L15 4m0 13V4m0 0L9 7"/>
                        </svg>
                    </div>
                    <div class="absolute -top-1 -right-1 w-3 h-3 bg-emerald-500 rounded-full animate-pulse"></div>
                </div>
                <div>
                    <span class="text-xl font-bold bg-gradient-to-r from-sky-600 to-blue-700 bg-clip-text text-transparent">TrackPro</span>
                    <span class="text-xs text-slate-500 dark:text-slate-400 block">{{ __('frontend.meta.tagline') }}</span>
                </div>
            </div>

            {{-- Desktop Navigation --}}
            <nav class="hidden lg:flex items-center gap-8">
                <a href="{{ url('/') }}" class="nav-link relative group">
                    <span class="font-medium text-slate-700 dark:text-slate-300 group-hover:text-sky-600 transition-colors">{{ __('frontend.nav.home') }}</span>
                    <span class="absolute -bottom-1 start-0 w-0 h-0.5 bg-gradient-to-r from-sky-500 to-blue-500 group-hover:w-full transition-all duration-300"></span>
                </a>
                <a href="{{ url('/') }}#features" class="nav-link relative group">
                    <span class="font-medium text-slate-700 dark:text-slate-300 group-hover:text-sky-600 transition-colors">{{ __('frontend.nav.features') }}</span>
                    <span class="absolute -bottom-1 start-0 w-0 h-0.5 bg-gradient-to-r from-sky-500 to-blue-500 group-hover:w-full transition-all duration-300"></span>
                </a>
                <a href="{{ url('/pricing') }}" class="nav-link relative group">
                    <span class="font-medium text-slate-700 dark:text-slate-300 group-hover:text-sky-600 transition-colors">{{ __('frontend.nav.pricing') }}</span>
                    <span class="absolute -bottom-1 start-0 w-0 h-0.5 bg-gradient-to-r from-sky-500 to-blue-500 group-hover:w-full transition-all duration-300"></span>
                </a>
                <a href="{{ url('/') }}#testimonials" class="nav-link relative group">
                    <span class="font-medium text-slate-700 dark:text-slate-300 group-hover:text-sky-600 transition-colors">{{ __('frontend.nav.testimonials') }}</span>
                    <span class="absolute -bottom-1 start-0 w-0 h-0.5 bg-gradient-to-r from-sky-500 to-blue-500 group-hover:w-full transition-all duration-300"></span>
                </a>

                <a href="{{ url('/demo/login') }}"
                   class="px-6 py-2.5 bg-gradient-to-r from-emerald-500 to-teal-600 text-white font-semibold rounded-xl shadow-lg hover:shadow-xl hover:scale-105 transition-all duration-300 group">
                        <span class="flex items-center gap-2">
                            <svg class="w-4 h-4 group-hover:rotate-12 transition-transform" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14.752 11.168l-3.197-2.132A1 1 0 0010 9.87v4.263a1 1 0 001.555.832l3.197-2.132a1 1 0 000-1.664z"/>
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                            </svg>
                            <span>{{ __('frontend.nav.live_demo') }}</span>
                        </span>
                </a>
            </nav>

            {{-- Right Side Actions --}}
            <div class="flex items-center gap-4">
                @include('frontend.partials.language-toggle')

                <button id="themeToggle"
                        class="w-10 h-10 rounded-xl glass flex items-center justify-center hover:bg-slate-100 dark:hover:bg-slate-800 transition-colors group">
                    <svg class="w-5 h-5 text-slate-600 dark:text-slate-400 hidden dark:block" fill="currentColor" viewBox="0 0 20 20">
                        <path d="M17.293 13.293A8 8 0 016.707 2.707a8.001 8.001 0 1010.586 10.586z"/>
                    </svg>
                    <svg class="w-5 h-5 text-slate-600 dark:text-slate-400 block dark:hidden" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M10 2a1 1 0 011 1v1a1 1 0 11-2 0V3a1 1 0 011-1zm4 8a4 4 0 11-8 0 4 4 0 018 0zm-.464 4.95l.707.707a1 1 0 001.414-1.414l-.707-.707a1 1 0 00-1.414 1.414zm2.12-10.607a1 1 0 010 1.414l-.706.707a1 1 0 11-1.414-1.414l.707-.707a1 1 0 011.414 0zM17 11a1 1 0 100-2h-1a1 1 0 100 2h1zm-7 4a1 1 0 011 1v1a1 1 0 11-2 0v-1a1 1 0 011-1zM5.05 6.464A1 1 0 106.465 5.05l-.708-.707a1 1 0 00-1.414 1.414l.707.707zm1.414 8.486l-.707.707a1 1 0 01-1.414-1.414l.707-.707a1 1 0 011.414 1.414zM4 11a1 1 0 100-2H3a1 1 0 000 2h1z" clip-rule="evenodd"/>
                    </svg>
                </button>

                <div class="hidden lg:flex items-center gap-3">
                    <a href="{{ url('login') }}"
                       class="px-5 py-2.5 rounded-xl font-medium text-slate-700 dark:text-slate-300 hover:bg-slate-100 dark:hover:bg-slate-800 transition-colors">
                        {{ __('frontend.nav.sign_in') }}
                    </a>
                    <a href="{{ url('register') }}"
                       class="px-5 py-2.5 bg-gradient-to-r from-sky-600 to-blue-700 text-white font-semibold rounded-xl shadow-lg hover:shadow-xl hover:scale-105 transition-all duration-300">
                        {{ __('frontend.nav.get_started') }}
                    </a>
                </div>

                {{-- Mobile Menu Button --}}
                <button id="mobileMenuBtn"
                        class="lg:hidden w-10 h-10 rounded-xl glass flex items-center justify-center hover:bg-slate-100 dark:hover:bg-slate-800 transition-colors">
                    <svg id="menuIcon" class="w-6 h-6 text-slate-600 dark:text-slate-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"/>
                    </svg>
                    <svg id="closeIcon" class="w-6 h-6 text-slate-600 dark:text-slate-400 hidden" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/>
                    </svg>
                </button>
            </div>
        </div>
    </div>

    {{-- Mobile Menu Overlay --}}
    <div id="mobileMenuOverlay" class="mobile-menu-overlay"></div>

    {{-- Mobile Menu --}}
    <div id="mobileMenu"
         class="lg:hidden absolute top-20 inset-x-0 bg-white dark:bg-slate-900 border-t border-slate-200 dark:border-slate-800 max-h-0 overflow-hidden transition-all duration-300 shadow-lg">
        <div class="px-4 py-6 space-y-4">
            <div class="flex justify-center pb-2">
                @include('frontend.partials.language-toggle')
            </div>
            <a href="{{ url('/') }}" class="block py-3 px-4 rounded-xl hover:bg-slate-100 dark:hover:bg-slate-800 transition-colors font-medium">{{ __('frontend.nav.home') }}</a>
            <a href="{{ url('/') }}#features" class="block py-3 px-4 rounded-xl hover:bg-slate-100 dark:hover:bg-slate-800 transition-colors font-medium">{{ __('frontend.nav.features') }}</a>
            <a href="{{ url('/pricing') }}" class="block py-3 px-4 rounded-xl hover:bg-slate-100 dark:hover:bg-slate-800 transition-colors font-medium">{{ __('frontend.nav.pricing') }}</a>
            <a href="{{ url('/') }}#testimonials" class="block py-3 px-4 rounded-xl hover:bg-slate-100 dark:hover:bg-slate-800 transition-colors font-medium">{{ __('frontend.nav.testimonials') }}</a>
            <a href="{{ url('/') }}#use-cases" class="block py-3 px-4 rounded-xl hover:bg-slate-100 dark:hover:bg-slate-800 transition-colors font-medium">{{ __('frontend.nav.use_cases') }}</a>

            <div class="pt-4 space-y-3 border-t border-slate-200 dark:border-slate-800">
                <a href="{{ url('/demo/login') }}"
                   class="block py-3 px-4 rounded-xl bg-gradient-to-r from-emerald-500 to-teal-600 text-white font-semibold text-center">
                    {{ __('frontend.nav.live_demo') }}
                </a>
                <a href="{{ url('login') }}"
                   class="block py-3 px-4 rounded-xl border border-slate-300 dark:border-slate-700 text-center font-medium">
                    {{ __('frontend.nav.sign_in') }}
                </a>
                <a href="{{ url('register') }}"
                   class="block py-3 px-4 rounded-xl bg-gradient-to-r from-sky-600 to-blue-700 text-white font-semibold text-center">
                    {{ __('frontend.nav.get_started') }}
                </a>
            </div>
        </div>
    </div>
</header>

<main class="pt-20">
    @yield('content')
</main>

{{-- ================= FIXED FOOTER ================= --}}
<footer class="relative bg-gradient-to-b from-slate-900 to-slate-950 border-t border-slate-800">
    <!-- Background Pattern -->
    <div class="absolute inset-0 opacity-5">
        <div class="absolute inset-0" style="background-image: radial-gradient(circle at 2px 2px, #22d3ee 1px, transparent 1px); background-size: 40px 40px;"></div>
    </div>

    <!-- Gradient Overlay -->
    <div class="absolute inset-0 bg-gradient-to-t from-slate-950/50 to-transparent"></div>

    <div class="relative max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-16">
        <div class="grid lg:grid-cols-4 gap-12">
            {{-- Brand --}}
            <div class="lg:col-span-1">
                <div class="flex items-center space-x-3 mb-6">
                    <div class="w-12 h-12 bg-gradient-to-br from-sky-500 to-blue-600 rounded-xl flex items-center justify-center shadow-lg">
                        <svg class="w-7 h-7 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 20l-5.447-2.724A1 1 0 013 16.382V5.618a1 1 0 011.447-.894L9 7m0 13l6-3m-6 3V7m6 10l4.553 2.276A1 1 0 0021 18.382V7.618a1 1 0 00-.553-.894L15 4m0 13V4m0 0L9 7"/>
                        </svg>
                    </div>
                    <div>
                        <span class="text-2xl font-bold bg-gradient-to-r from-sky-400 to-blue-500 bg-clip-text text-transparent">TrackPro</span>
                        <span class="text-xs text-slate-400 block">{{ __('frontend.meta.platform') }}</span>
                    </div>
                </div>
                <p class="text-slate-400 text-sm">
                    {{ __('frontend.meta.footer_blurb') }}
                </p>

                <!-- Social Links -->
                <div class="flex items-center space-x-4 mt-6">
                    <a href="#" class="w-10 h-10 rounded-lg bg-slate-800 flex items-center justify-center text-slate-400 hover:text-white hover:bg-slate-700 transition-colors">
                        <i class="fab fa-twitter"></i>
                    </a>
                    <a href="#" class="w-10 h-10 rounded-lg bg-slate-800 flex items-center justify-center text-slate-400 hover:text-white hover:bg-slate-700 transition-colors">
                        <i class="fab fa-linkedin"></i>
                    </a>
                    <a href="#" class="w-10 h-10 rounded-lg bg-slate-800 flex items-center justify-center text-slate-400 hover:text-white hover:bg-slate-700 transition-colors">
                        <i class="fab fa-facebook"></i>
                    </a>
                    <a href="#" class="w-10 h-10 rounded-lg bg-slate-800 flex items-center justify-center text-slate-400 hover:text-white hover:bg-slate-700 transition-colors">
                        <i class="fab fa-youtube"></i>
                    </a>
                </div>
            </div>

            {{-- Quick Links --}}
            <div>
                <h4 class="font-semibold text-white mb-4">{{ __('frontend.footer.product') }}</h4>
                <ul class="space-y-3">
                    <li><a href="{{ url('/') }}#features" class="text-slate-400 hover:text-white transition-colors text-sm">{{ __('frontend.nav.features') }}</a></li>
                    <li><a href="{{ url('/pricing') }}" class="text-slate-400 hover:text-white transition-colors text-sm">{{ __('frontend.nav.pricing') }}</a></li>
                    <li><a href="{{ url('/') }}#use-cases" class="text-slate-400 hover:text-white transition-colors text-sm">{{ __('frontend.nav.use_cases') }}</a></li>
                    <li><a href="{{ url('/demo/login') }}" class="text-slate-400 hover:text-white transition-colors text-sm">{{ __('frontend.nav.live_demo') }}</a></li>
                    <li><a href="{{ url('/') }}#testimonials" class="text-slate-400 hover:text-white transition-colors text-sm">{{ __('frontend.nav.testimonials') }}</a></li>
                </ul>
            </div>

            {{-- Company --}}
            <div>
                <h4 class="font-semibold text-white mb-4">{{ __('frontend.footer.company') }}</h4>
                <ul class="space-y-3">
                    <li><a href="{{ url('/about') }}" class="text-slate-400 hover:text-white transition-colors text-sm">{{ __('frontend.footer.about') }}</a></li>
                    <li><a href="{{ url('/contact') }}" class="text-slate-400 hover:text-white transition-colors text-sm">{{ __('frontend.footer.contact') }}</a></li>
                    <li><a href="{{ url('/careers') }}" class="text-slate-400 hover:text-white transition-colors text-sm">{{ __('frontend.footer.careers') }}</a></li>
                    <li><a href="{{ url('/blog') }}" class="text-slate-400 hover:text-white transition-colors text-sm">{{ __('frontend.footer.blog') }}</a></li>
                    <li><a href="{{ url('/press') }}" class="text-slate-400 hover:text-white transition-colors text-sm">{{ __('frontend.footer.press') }}</a></li>
                </ul>
            </div>

            {{-- Legal & Support --}}
            <div>
                <h4 class="font-semibold text-white mb-4">{{ __('frontend.footer.support') }}</h4>
                <ul class="space-y-3">
                    <li><a href="{{ url('/help') }}" class="text-slate-400 hover:text-white transition-colors text-sm">{{ __('frontend.footer.help') }}</a></li>
                    <li><a href="{{ url('/docs') }}" class="text-slate-400 hover:text-white transition-colors text-sm">{{ __('frontend.footer.docs') }}</a></li>
                    <li><a href="{{ url('/api') }}" class="text-slate-400 hover:text-white transition-colors text-sm">{{ __('frontend.footer.api') }}</a></li>
                    <li><a href="{{ url('/status') }}" class="text-slate-400 hover:text-white transition-colors text-sm">{{ __('frontend.footer.status') }}</a></li>
                    <li><a href="{{ url('/contact') }}" class="text-slate-400 hover:text-white transition-colors text-sm">{{ __('frontend.footer.contact_support') }}</a></li>
                </ul>
            </div>
        </div>

        {{-- Bottom Bar --}}
        <div class="mt-12 pt-8 border-t border-slate-800 flex flex-col md:flex-row justify-between items-center">
            <div class="text-center md:text-left mb-4 md:mb-0">
                <p class="text-slate-500 text-sm">
                    {{ __('frontend.meta.copyright') }}
                </p>
                <p class="text-slate-600 text-xs mt-1">
                    {{ __('frontend.meta.trademark') }}
                </p>
            </div>

            <div class="flex items-center space-x-6">
                <a href="{{ url('/privacy') }}" class="text-slate-500 hover:text-white transition-colors text-sm">{{ __('frontend.footer.privacy') }}</a>
                <a href="{{ url('/terms') }}" class="text-slate-500 hover:text-white transition-colors text-sm">{{ __('frontend.footer.terms') }}</a>
                <a href="{{ url('/security') }}" class="text-slate-500 hover:text-white transition-colors text-sm">{{ __('frontend.footer.security') }}</a>
                <a href="{{ url('/cookies') }}" class="text-slate-500 hover:text-white transition-colors text-sm">{{ __('frontend.footer.cookies') }}</a>
            </div>
        </div>
    </div>
</footer>

{{-- ================= SCRIPTS ================= --}}
<script>
    // Theme Toggle
    const themeToggle = document.getElementById('themeToggle');
    const applyTheme = () => {
        const theme = localStorage.getItem('theme') || (window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light');
        document.documentElement.classList.toggle('dark', theme === 'dark');
    };

    themeToggle.addEventListener('click', () => {
        const isDark = document.documentElement.classList.contains('dark');
        document.documentElement.classList.toggle('dark');
        localStorage.setItem('theme', isDark ? 'light' : 'dark');
    });

    applyTheme();

    // Mobile Menu Functionality
    const mobileMenuBtn = document.getElementById('mobileMenuBtn');
    const mobileMenu = document.getElementById('mobileMenu');
    const mobileMenuOverlay = document.getElementById('mobileMenuOverlay');
    const menuIcon = document.getElementById('menuIcon');
    const closeIcon = document.getElementById('closeIcon');
    const body = document.body;

    mobileMenuBtn.addEventListener('click', () => {
        const isOpen = mobileMenu.classList.contains('mobile-menu-open');

        if (isOpen) {
            // Close menu
            mobileMenu.classList.remove('mobile-menu-open');
            mobileMenu.style.maxHeight = '0';
            mobileMenuOverlay.classList.remove('active');
            body.classList.remove('menu-open');
            menuIcon.classList.remove('hidden');
            closeIcon.classList.add('hidden');
        } else {
            // Open menu
            mobileMenu.classList.add('mobile-menu-open');
            mobileMenu.style.maxHeight = 'calc(100vh - 80px)';
            mobileMenuOverlay.classList.add('active');
            body.classList.add('menu-open');
            menuIcon.classList.add('hidden');
            closeIcon.classList.remove('hidden');
        }
    });

    // Close menu when clicking overlay
    mobileMenuOverlay.addEventListener('click', () => {
        mobileMenu.classList.remove('mobile-menu-open');
        mobileMenu.style.maxHeight = '0';
        mobileMenuOverlay.classList.remove('active');
        body.classList.remove('menu-open');
        menuIcon.classList.remove('hidden');
        closeIcon.classList.add('hidden');
    });

    // Close menu when clicking links
    document.querySelectorAll('#mobileMenu a').forEach(link => {
        link.addEventListener('click', () => {
            mobileMenu.classList.remove('mobile-menu-open');
            mobileMenu.style.maxHeight = '0';
            mobileMenuOverlay.classList.remove('active');
            body.classList.remove('menu-open');
            menuIcon.classList.remove('hidden');
            closeIcon.classList.add('hidden');
        });
    });

    // Close menu on escape key
    document.addEventListener('keydown', (e) => {
        if (e.key === 'Escape' && mobileMenu.classList.contains('mobile-menu-open')) {
            mobileMenu.classList.remove('mobile-menu-open');
            mobileMenu.style.maxHeight = '0';
            mobileMenuOverlay.classList.remove('active');
            body.classList.remove('menu-open');
            menuIcon.classList.remove('hidden');
            closeIcon.classList.add('hidden');
        }
    });

    // Smooth scrolling for anchor links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            const href = this.getAttribute('href');
            if (href === '#') return;

            e.preventDefault();
            const target = document.querySelector(href);
            if (target) {
                // Close mobile menu if open
                if (mobileMenu.classList.contains('mobile-menu-open')) {
                    mobileMenu.classList.remove('mobile-menu-open');
                    mobileMenu.style.maxHeight = '0';
                    mobileMenuOverlay.classList.remove('active');
                    body.classList.remove('menu-open');
                    menuIcon.classList.remove('hidden');
                    closeIcon.classList.add('hidden');
                }

                target.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        });
    });
</script>

@stack('scripts')
</body>
</html>
