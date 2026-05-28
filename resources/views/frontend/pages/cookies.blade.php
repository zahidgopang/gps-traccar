<!-- resources/views/frontend/pages/cookies.blade.php -->
@extends('frontend.layout')

@section('title', __('frontend.pages.cookies.title'))
@section('description', 'Learn about how FalconEyeGPS uses cookies and similar tracking technologies on our platform.')

@section('content')

    <!-- Hero -->
    <section class="relative min-h-[60vh] flex items-center overflow-hidden">
        <div class="absolute inset-0 bg-gradient-to-br from-slate-50 via-amber-50 to-orange-100 dark:from-slate-950 dark:via-amber-950 dark:to-orange-950"></div>

        <div class="relative max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-24 text-center">
        <span class="inline-block px-4 py-1.5 bg-gradient-to-r from-amber-500/10 to-orange-500/10 rounded-full text-amber-600 dark:text-amber-400 font-semibold text-sm mb-4">
            COOKIE POLICY
        </span>
            <h1 class="text-5xl lg:text-6xl font-bold mb-6">
                Cookies <span class="bg-gradient-to-r from-amber-500 to-orange-600 bg-clip-text text-transparent">Policy</span>
            </h1>
            <p class="text-xl text-slate-600 dark:text-slate-300 max-w-3xl mx-auto">
                Last updated: {{ now()->format('F j, Y') }}
            </p>
        </div>
    </section>

    <!-- Cookie Types -->
    <section class="py-20">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="text-center mb-16">
                <h2 class="text-3xl font-bold mb-4">Types of Cookies We Use</h2>
                <p class="text-slate-600 dark:text-slate-400">Understanding different cookie categories</p>
            </div>

            <div class="grid md:grid-cols-3 gap-8">
                <div class="p-8 rounded-2xl glass border border-amber-200 dark:border-amber-800">
                    <div class="w-12 h-12 rounded-xl bg-gradient-to-br from-amber-500 to-orange-600 flex items-center justify-center mb-6">
                        <i class="fa-solid fa-gear text-white text-xl"></i>
                    </div>
                    <h3 class="font-bold text-xl mb-4">Essential Cookies</h3>
                    <p class="text-slate-600 dark:text-slate-400 text-sm mb-4">
                        Required for basic website functionality and cannot be disabled.
                    </p>
                    <ul class="space-y-2 text-sm text-slate-600 dark:text-slate-400">
                        <li class="flex items-start gap-2">
                            <i class="fa-solid fa-check text-amber-500 mt-1"></i>
                            <span>Session management</span>
                        </li>
                        <li class="flex items-start gap-2">
                            <i class="fa-solid fa-check text-amber-500 mt-1"></i>
                            <span>Security features</span>
                        </li>
                        <li class="flex items-start gap-2">
                            <i class="fa-solid fa-check text-amber-500 mt-1"></i>
                            <span>Load balancing</span>
                        </li>
                    </ul>
                </div>

                <div class="p-8 rounded-2xl glass border border-sky-200 dark:border-sky-800">
                    <div class="w-12 h-12 rounded-xl bg-gradient-to-br from-sky-500 to-blue-600 flex items-center justify-center mb-6">
                        <i class="fa-solid fa-chart-line text-white text-xl"></i>
                    </div>
                    <h3 class="font-bold text-xl mb-4">Analytics Cookies</h3>
                    <p class="text-slate-600 dark:text-slate-400 text-sm mb-4">
                        Help us understand how visitors interact with our website.
                    </p>
                    <ul class="space-y-2 text-sm text-slate-600 dark:text-slate-400">
                        <li class="flex items-start gap-2">
                            <i class="fa-solid fa-check text-sky-500 mt-1"></i>
                            <span>Visitor statistics</span>
                        </li>
                        <li class="flex items-start gap-2">
                            <i class="fa-solid fa-check text-sky-500 mt-1"></i>
                            <span>Usage patterns</span>
                        </li>
                        <li class="flex items-start gap-2">
                            <i class="fa-solid fa-check text-sky-500 mt-1"></i>
                            <span>Performance metrics</span>
                        </li>
                    </ul>
                </div>

                <div class="p-8 rounded-2xl glass border border-purple-200 dark:border-purple-800">
                    <div class="w-12 h-12 rounded-xl bg-gradient-to-br from-purple-500 to-pink-600 flex items-center justify-center mb-6">
                        <i class="fa-solid fa-bullhorn text-white text-xl"></i>
                    </div>
                    <h3 class="font-bold text-xl mb-4">Marketing Cookies</h3>
                    <p class="text-slate-600 dark:text-slate-400 text-sm mb-4">
                        Used to track visitors across websites for marketing purposes.
                    </p>
                    <ul class="space-y-2 text-sm text-slate-600 dark:text-slate-400">
                        <li class="flex items-start gap-2">
                            <i class="fa-solid fa-check text-purple-500 mt-1"></i>
                            <span>Advertising tracking</span>
                        </li>
                        <li class="flex items-start gap-2">
                            <i class="fa-solid fa-check text-purple-500 mt-1"></i>
                            <span>Remarketing</span>
                        </li>
                        <li class="flex items-start gap-2">
                            <i class="fa-solid fa-check text-purple-500 mt-1"></i>
                            <span>Campaign effectiveness</span>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </section>

    <!-- Detailed Cookie Information -->
    <section class="py-20 bg-slate-50 dark:bg-slate-900/50">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="text-center mb-16">
                <h2 class="text-3xl font-bold mb-4">Cookie Details</h2>
                <p class="text-slate-600 dark:text-slate-400">Specific cookies used on our platform</p>
            </div>

            <div class="space-y-6 max-w-4xl mx-auto">
                @php
                    $cookies = [
                        [
                            'name' => 'falconeyegps_session',
                            'purpose' => 'Maintains user session state',
                            'duration' => 'Session',
                            'type' => 'Essential'
                        ],
                        [
                            'name' => 'XSRF-TOKEN',
                            'purpose' => 'Security protection against CSRF attacks',
                            'duration' => 'Session',
                            'type' => 'Essential'
                        ],
                        [
                            'name' => '_ga',
                            'purpose' => 'Google Analytics tracking',
                            'duration' => '2 years',
                            'type' => 'Analytics'
                        ],
                        [
                            'name' => '_gid',
                            'purpose' => 'Google Analytics session tracking',
                            'duration' => '24 hours',
                            'type' => 'Analytics'
                        ],
                        [
                            'name' => '_fbp',
                            'purpose' => 'Facebook Pixel tracking',
                            'duration' => '3 months',
                            'type' => 'Marketing'
                        ],
                        [
                            'name' => 'cookie_consent',
                            'purpose' => 'Stores your cookie preferences',
                            'duration' => '1 year',
                            'type' => 'Essential'
                        ]
                    ];
                @endphp
                <div class="rounded-xl overflow-hidden border border-slate-200 dark:border-slate-800 shadow-sm">
                    <div class="overflow-x-auto">
                        <table class="w-full">
                            <thead>
                            <tr class="bg-gradient-to-r from-slate-100 to-slate-50 dark:from-slate-800 dark:to-slate-900/50">
                                <th class="py-4 px-6 text-left font-semibold text-slate-700 dark:text-slate-300">Cookie Name</th>
                                <th class="py-4 px-6 text-left font-semibold text-slate-700 dark:text-slate-300">Purpose</th>
                                <th class="py-4 px-6 text-left font-semibold text-slate-700 dark:text-slate-300">Duration</th>
                                <th class="py-4 px-6 text-left font-semibold text-slate-700 dark:text-slate-300">Type</th>
                            </tr>
                            </thead>
                            <tbody class="divide-y divide-slate-200 dark:divide-slate-800">
                            @foreach($cookies as $cookie)
                                <tr class="hover:bg-slate-50 dark:hover:bg-slate-800/50 transition-colors">
                                    <td class="py-4 px-6 font-mono text-sm text-sky-600 dark:text-sky-400">{{ $cookie['name'] }}</td>
                                    <td class="py-4 px-6 text-slate-700 dark:text-slate-300">{{ $cookie['purpose'] }}</td>
                                    <td class="py-4 px-6 text-slate-700 dark:text-slate-300">{{ $cookie['duration'] }}</td>
                                    <td class="py-4 px-6">
                                        @php
                                            $typeColors = [
                                                'Essential' => 'bg-amber-100 text-amber-800 dark:bg-amber-900/30 dark:text-amber-300',
                                                'Analytics' => 'bg-sky-100 text-sky-800 dark:bg-sky-900/30 dark:text-sky-300',
                                                'Marketing' => 'bg-purple-100 text-purple-800 dark:bg-purple-900/30 dark:text-purple-300'
                                            ];
                                        @endphp
                                        <span class="inline-block px-3 py-1 rounded-full text-xs font-semibold {{ $typeColors[$cookie['type']] }}">
                                    {{ $cookie['type'] }}
                                </span>
                                    </td>
                                </tr>
                            @endforeach
                            </tbody>
                        </table>
                    </div>
                </div>

                <p class="text-sm text-slate-600 dark:text-slate-400 text-center">
                    This list is not exhaustive and may be updated periodically. Third-party services may set additional cookies.
                </p>
            </div>
        </div>
    </section>

    <!-- Cookie Management -->
    <section class="py-20">
        <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="text-center mb-16">
                <h2 class="text-3xl font-bold mb-4">Managing Your Cookie Preferences</h2>
                <p class="text-slate-600 dark:text-slate-400">You have control over your cookie settings</p>
            </div>

            <div class="grid md:grid-cols-2 gap-8 mb-12">
                <div class="p-8 rounded-2xl bg-gradient-to-br from-slate-50 to-slate-100 dark:from-slate-900/50 dark:to-slate-900 border border-slate-200 dark:border-slate-800">
                    <div class="w-14 h-14 rounded-xl bg-gradient-to-br from-green-500 to-emerald-600 flex items-center justify-center mb-6">
                        <i class="fa-solid fa-sliders text-white text-xl"></i>
                    </div>
                    <h3 class="font-bold text-xl mb-4">Browser Settings</h3>
                    <p class="text-slate-600 dark:text-slate-400 mb-6">
                        Most web browsers allow you to control cookies through their settings preferences.
                    </p>
                    <ul class="space-y-3 text-sm text-slate-700 dark:text-slate-300">
                        <li class="flex items-center gap-3">
                            <i class="fa-solid fa-desktop text-green-500"></i>
                            <span>Chrome: Settings → Privacy and security → Cookies</span>
                        </li>
                        <li class="flex items-center gap-3">
                            <i class="fa-solid fa-desktop text-green-500"></i>
                            <span>Firefox: Options → Privacy & Security → Cookies</span>
                        </li>
                        <li class="flex items-center gap-3">
                            <i class="fa-solid fa-desktop text-green-500"></i>
                            <span>Safari: Preferences → Privacy → Cookies</span>
                        </li>
                        <li class="flex items-center gap-3">
                            <i class="fa-solid fa-desktop text-green-500"></i>
                            <span>Edge: Settings → Cookies and site permissions</span>
                        </li>
                    </ul>
                </div>

                <div class="p-8 rounded-2xl bg-gradient-to-br from-slate-50 to-slate-100 dark:from-slate-900/50 dark:to-slate-900 border border-slate-200 dark:border-slate-800">
                    <div class="w-14 h-14 rounded-xl bg-gradient-to-br from-orange-500 to-red-600 flex items-center justify-center mb-6">
                        <i class="fa-solid fa-filter text-white text-xl"></i>
                    </div>
                    <h3 class="font-bold text-xl mb-4">Opt-Out Tools</h3>
                    <p class="text-slate-600 dark:text-slate-400 mb-6">
                        Use these industry tools to manage advertising cookies:
                    </p>
                    <ul class="space-y-4">
                        <li>
                            <a href="https://optout.aboutads.info/" target="_blank" class="flex items-center gap-3 group">
                                <div class="w-10 h-10 rounded-lg bg-blue-100 dark:bg-blue-900/30 flex items-center justify-center group-hover:bg-blue-200 dark:group-hover:bg-blue-900/50 transition-colors">
                                    <i class="fa-brands fa-google text-blue-600 dark:text-blue-400"></i>
                                </div>
                                <div>
                                    <div class="font-medium group-hover:text-blue-600 dark:group-hover:text-blue-400 transition-colors">Digital Advertising Alliance</div>
                                    <div class="text-xs text-slate-500 dark:text-slate-500">optout.aboutads.info</div>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a href="https://www.youronlinechoices.com/" target="_blank" class="flex items-center gap-3 group">
                                <div class="w-10 h-10 rounded-lg bg-purple-100 dark:bg-purple-900/30 flex items-center justify-center group-hover:bg-purple-200 dark:group-hover:bg-purple-900/50 transition-colors">
                                    <i class="fa-solid fa-globe text-purple-600 dark:text-purple-400"></i>
                                </div>
                                <div>
                                    <div class="font-medium group-hover:text-purple-600 dark:group-hover:text-purple-400 transition-colors">Your Online Choices</div>
                                    <div class="text-xs text-slate-500 dark:text-slate-500">European Interactive Digital Alliance</div>
                                </div>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>

            <div class="bg-gradient-to-r from-slate-50 to-amber-50 dark:from-slate-900/50 dark:to-amber-900/20 rounded-2xl p-8 border border-amber-200 dark:border-amber-800">
                <div class="flex items-start gap-4">
                    <div class="w-12 h-12 rounded-xl bg-gradient-to-br from-amber-500 to-orange-600 flex items-center justify-center flex-shrink-0">
                        <i class="fa-solid fa-triangle-exclamation text-white text-xl"></i>
                    </div>
                    <div>
                        <h3 class="font-bold text-xl mb-3">Important Note</h3>
                        <p class="text-slate-700 dark:text-slate-300 mb-4">
                            Disabling essential cookies may prevent certain parts of our website from functioning properly.
                            Some features may be unavailable if you disable analytics or functionality cookies.
                        </p>
                        <p class="text-slate-600 dark:text-slate-400 text-sm">
                            Our cookie consent banner allows you to selectively enable/disable non-essential cookies.
                            You can update your preferences at any time by clicking the "Cookie Settings" link in the footer.
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Updates & Contact -->
    <section class="py-20 bg-slate-50 dark:bg-slate-900/50">
        <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="text-center mb-12">
                <h2 class="text-3xl font-bold mb-4">Policy Updates & Contact</h2>
                <p class="text-slate-600 dark:text-slate-400">Stay informed about changes</p>
            </div>

            <div class="grid md:grid-cols-2 gap-8">
                <div class="p-8 rounded-2xl bg-white dark:bg-slate-900 border border-slate-200 dark:border-slate-800">
                    <h3 class="font-bold text-xl mb-4 flex items-center gap-3">
                        <i class="fa-solid fa-clock-rotate-left text-amber-500"></i>
                        Policy Updates
                    </h3>
                    <p class="text-slate-600 dark:text-slate-400 mb-6">
                        We may update this Cookie Policy from time to time to reflect changes in technology,
                        regulation, or our services. The "Last updated" date at the top of this page indicates when changes were made.
                    </p>
                    <div class="flex items-center gap-2 text-sm text-slate-500 dark:text-slate-500">
                        <i class="fa-solid fa-bell"></i>
                        <span>We encourage you to review this policy periodically</span>
                    </div>
                </div>

                <div class="p-8 rounded-2xl bg-white dark:bg-slate-900 border border-slate-200 dark:border-slate-800">
                    <h3 class="font-bold text-xl mb-4 flex items-center gap-3">
                        <i class="fa-solid fa-envelope text-sky-500"></i>
                        Contact Us
                    </h3>
                    <p class="text-slate-600 dark:text-slate-400 mb-6">
                        If you have questions about our use of cookies or this Cookie Policy,
                        please contact our Data Protection Officer.
                    </p>
                    <div class="space-y-3">
                        <a href="mailto:privacy@falconeyegps.com" class="flex items-center gap-3 group">
                            <div class="w-10 h-10 rounded-lg bg-sky-100 dark:bg-sky-900/30 flex items-center justify-center group-hover:bg-sky-200 dark:group-hover:bg-sky-900/50 transition-colors">
                                <i class="fa-solid fa-envelope text-sky-600 dark:text-sky-400"></i>
                            </div>
                            <div>
                                <div class="font-medium group-hover:text-sky-600 dark:group-hover:text-sky-400 transition-colors">Email</div>
                                <div class="text-sm text-slate-500 dark:text-slate-500">privacy@falconeyegps.com</div>
                            </div>
                        </a>
                        <a href="{{ route('privacy') }}" class="flex items-center gap-3 group">
                            <div class="w-10 h-10 rounded-lg bg-slate-100 dark:bg-slate-800 flex items-center justify-center group-hover:bg-slate-200 dark:group-hover:bg-slate-700 transition-colors">
                                <i class="fa-solid fa-shield-halved text-slate-600 dark:text-slate-400"></i>
                            </div>
                            <div>
                                <div class="font-medium group-hover:text-slate-700 dark:group-hover:text-slate-300 transition-colors">Privacy Policy</div>
                                <div class="text-sm text-slate-500 dark:text-slate-500">View our full Privacy Policy</div>
                            </div>
                        </a>
                    </div>
                </div>
            </div>

            <div class="mt-12 text-center">
                <div class="inline-flex items-center gap-4 p-4 bg-gradient-to-r from-slate-100 to-white dark:from-slate-900 dark:to-slate-800 rounded-xl border border-slate-200 dark:border-slate-800">
                    <div class="w-12 h-12 rounded-lg bg-gradient-to-br from-emerald-500 to-green-600 flex items-center justify-center">
                        <i class="fa-solid fa-cookie-bite text-white text-xl"></i>
                    </div>
                    <div class="text-left">
                        <div class="font-semibold">Cookie Preferences</div>
                        <div class="text-sm text-slate-600 dark:text-slate-400">Manage your cookie settings anytime</div>
                    </div>
                    <button onclick="showCookieSettings()" class="px-6 py-2.5 bg-gradient-to-r from-amber-500 to-orange-600 hover:from-amber-600 hover:to-orange-700 text-white font-medium rounded-lg transition-all hover:shadow-lg">
                        Update Preferences
                    </button>
                </div>
            </div>
        </div>
    </section>

@endsection

@push('scripts')
    <script>
        function showCookieSettings() {
            // This would typically trigger your cookie consent modal
            if (typeof window.showCookieConsentModal === 'function') {
                window.showCookieConsentModal();
            } else {
                // Fallback alert
                alert('Cookie settings functionality would appear here. In a production environment, this would open the cookie consent manager.');
            }
        }
    </script>
@endpush
