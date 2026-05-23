<!-- resources/views/frontend/pages/security.blade.php -->
@extends('frontend.layout')

@section('title', __('frontend.pages.security.title'))
@section('description', 'Learn about TrackPro GPS security measures, certifications, and data protection practices.')

@section('content')

    <!-- Hero -->
    <section class="relative min-h-[60vh] flex items-center overflow-hidden">
        <div class="absolute inset-0 bg-gradient-to-br from-slate-50 via-emerald-50 to-teal-100 dark:from-slate-950 dark:via-emerald-950 dark:to-teal-950"></div>

        <div class="relative max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-24 text-center">
        <span class="inline-block px-4 py-1.5 bg-gradient-to-r from-emerald-500/10 to-teal-500/10 rounded-full text-emerald-600 dark:text-emerald-400 font-semibold text-sm mb-4">
            ENTERPRISE SECURITY
        </span>
            <h1 class="text-5xl lg:text-6xl font-bold mb-6">
                Security <span class="bg-gradient-to-r from-emerald-500 to-teal-600 bg-clip-text text-transparent">First</span>
            </h1>
            <p class="text-xl text-slate-600 dark:text-slate-300 max-w-3xl mx-auto">
                Protecting your fleet data with enterprise-grade security measures and industry-leading practices.
            </p>
        </div>
    </section>

    <!-- Security Badges -->
    <section class="py-20">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="text-center mb-16">
                <h2 class="text-3xl font-bold mb-4">Certifications & Compliance</h2>
                <p class="text-slate-600 dark:text-slate-400">Industry-recognized security standards</p>
            </div>

            <div class="grid md:grid-cols-4 gap-8">
                <div class="p-8 rounded-2xl glass border border-emerald-200 dark:border-emerald-800 text-center">
                    <div class="w-16 h-16 rounded-xl bg-gradient-to-br from-emerald-500 to-teal-600 flex items-center justify-center mx-auto mb-6">
                        <i class="fa-solid fa-shield-check text-white text-2xl"></i>
                    </div>
                    <h3 class="font-bold text-xl mb-2">SOC 2 Type II</h3>
                    <p class="text-slate-600 dark:text-slate-400 text-sm">Security & Availability Controls</p>
                </div>

                <div class="p-8 rounded-2xl glass border border-emerald-200 dark:border-emerald-800 text-center">
                    <div class="w-16 h-16 rounded-xl bg-gradient-to-br from-emerald-500 to-teal-600 flex items-center justify-center mx-auto mb-6">
                        <i class="fa-solid fa-lock text-white text-2xl"></i>
                    </div>
                    <h3 class="font-bold text-xl mb-2">GDPR Compliant</h3>
                    <p class="text-slate-600 dark:text-slate-400 text-sm">Data Protection Regulation</p>
                </div>

                <div class="p-8 rounded-2xl glass border border-emerald-200 dark:border-emerald-800 text-center">
                    <div class="w-16 h-16 rounded-xl bg-gradient-to-br from-emerald-500 to-teal-600 flex items-center justify-center mx-auto mb-6">
                        <i class="fa-solid fa-shield-halved text-white text-2xl"></i>
                    </div>
                    <h3 class="font-bold text-xl mb-2">ISO 27001</h3>
                    <p class="text-slate-600 dark:text-slate-400 text-sm">Information Security</p>
                </div>

                <div class="p-8 rounded-2xl glass border border-emerald-200 dark:border-emerald-800 text-center">
                    <div class="w-16 h-16 rounded-xl bg-gradient-to-br from-emerald-500 to-teal-600 flex items-center justify-center mx-auto mb-6">
                        <i class="fa-solid fa-user-shield text-white text-2xl"></i>
                    </div>
                    <h3 class="font-bold text-xl mb-2">CCPA Ready</h3>
                    <p class="text-slate-600 dark:text-slate-400 text-sm">California Compliance</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Security Architecture -->
    <section class="py-20 bg-slate-50 dark:bg-slate-900/50">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="text-center mb-16">
                <h2 class="text-3xl font-bold mb-4">Security Architecture</h2>
                <p class="text-slate-600 dark:text-slate-400">Multi-layered protection for your data</p>
            </div>

            <div class="space-y-8 max-w-4xl mx-auto">
                @php
                    $layers = [
                        [
                            'title' => 'Data Encryption',
                            'description' => 'AES-256 encryption for data at rest and in transit',
                            'features' => ['End-to-end encryption', 'SSL/TLS 1.3', 'Encrypted backups'],
                            'icon' => 'fa-solid fa-key',
                            'color' => 'from-emerald-500 to-teal-600'
                        ],
                        [
                            'title' => 'Network Security',
                            'description' => 'Advanced network protection and monitoring',
                            'features' => ['Web Application Firewall', 'DDoS protection', 'Intrusion detection'],
                            'icon' => 'fa-solid fa-network-wired',
                            'color' => 'from-sky-500 to-blue-600'
                        ],
                        [
                            'title' => 'Access Control',
                            'description' => 'Strict authentication and authorization controls',
                            'features' => ['Multi-factor authentication', 'Role-based access', 'Single sign-on'],
                            'icon' => 'fa-solid fa-fingerprint',
                            'color' => 'from-purple-500 to-pink-600'
                        ],
                        [
                            'title' => 'Physical Security',
                            'description' => 'Secure data center infrastructure',
                            'features' => ['Biometric access', '24/7 monitoring', 'Redundant power'],
                            'icon' => 'fa-solid fa-building-shield',
                            'color' => 'from-amber-500 to-orange-600'
                        ],
                    ];
                @endphp

                @foreach($layers as $layer)
                    <div class="p-6 rounded-2xl glass border border-slate-200 dark:border-slate-800">
                        <div class="flex items-start gap-6">
                            <div class="w-16 h-16 rounded-xl bg-gradient-to-br {{ $layer['color'] }} flex items-center justify-center flex-shrink-0">
                                <i class="{{ $layer['icon'] }} text-white text-2xl"></i>
                            </div>
                            <div class="flex-grow">
                                <h3 class="font-bold text-xl mb-2">{{ $layer['title'] }}</h3>
                                <p class="text-slate-600 dark:text-slate-400 mb-4">{{ $layer['description'] }}</p>
                                <div class="flex flex-wrap gap-2">
                                    @foreach($layer['features'] as $feature)
                                        <span class="px-3 py-1 rounded-full bg-slate-100 dark:bg-slate-800 text-slate-700 dark:text-slate-300 text-xs">
                                        {{ $feature }}
                                    </span>
                                    @endforeach
                                </div>
                            </div>
                        </div>
                    </div>
                @endforeach
            </div>
        </div>
    </section>

    <!-- Security Practices -->
    <section class="py-20">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="text-center mb-16">
                <h2 class="text-3xl font-bold mb-4">Security Practices</h2>
                <p class="text-slate-600 dark:text-slate-400">Proactive measures to ensure security</p>
            </div>

            <div class="grid md:grid-cols-3 gap-8">
                <div class="p-8 rounded-2xl glass border border-slate-200 dark:border-slate-800">
                    <div class="w-12 h-12 rounded-xl bg-gradient-to-br from-emerald-500 to-teal-600 flex items-center justify-center mb-6">
                        <i class="fa-solid fa-search text-white text-xl"></i>
                    </div>
                    <h3 class="font-bold text-xl mb-4">Security Audits</h3>
                    <ul class="space-y-3 text-slate-600 dark:text-slate-400">
                        <li class="flex items-start gap-2">
                            <i class="fa-solid fa-check text-emerald-500 mt-1"></i>
                            <span>Regular third-party penetration testing</span>
                        </li>
                        <li class="flex items-start gap-2">
                            <i class="fa-solid fa-check text-emerald-500 mt-1"></i>
                            <span>Continuous vulnerability scanning</span>
                        </li>
                        <li class="flex items-start gap-2">
                            <i class="fa-solid fa-check text-emerald-500 mt-1"></i>
                            <span>Comprehensive security assessments</span>
                        </li>
                    </ul>
                </div>

                <div class="p-8 rounded-2xl glass border border-slate-200 dark:border-slate-800">
                    <div class="w-12 h-12 rounded-xl bg-gradient-to-br from-sky-500 to-blue-600 flex items-center justify-center mb-6">
                        <i class="fa-solid fa-people-group text-white text-xl"></i>
                    </div>
                    <h3 class="font-bold text-xl mb-4">Team & Training</h3>
                    <ul class="space-y-3 text-slate-600 dark:text-slate-400">
                        <li class="flex items-start gap-2">
                            <i class="fa-solid fa-check text-sky-500 mt-1"></i>
                            <span>Dedicated security team</span>
                        </li>
                        <li class="flex items-start gap-2">
                            <i class="fa-solid fa-check text-sky-500 mt-1"></i>
                            <span>Regular security training</span>
                        </li>
                        <li class="flex items-start gap-2">
                            <i class="fa-solid fa-check text-sky-500 mt-1"></i>
                            <span>Background checks for employees</span>
                        </li>
                    </ul>
                </div>

                <div class="p-8 rounded-2xl glass border border-slate-200 dark:border-slate-800">
                    <div class="w-12 h-12 rounded-xl bg-gradient-to-br from-purple-500 to-pink-600 flex items-center justify-center mb-6">
                        <i class="fa-solid fa-bell text-white text-xl"></i>
                    </div>
                    <h3 class="font-bold text-xl mb-4">Monitoring & Response</h3>
                    <ul class="space-y-3 text-slate-600 dark:text-slate-400">
                        <li class="flex items-start gap-2">
                            <i class="fa-solid fa-check text-purple-500 mt-1"></i>
                            <span>24/7 security monitoring</span>
                        </li>
                        <li class="flex items-start gap-2">
                            <i class="fa-solid fa-check text-purple-500 mt-1"></i>
                            <span>Incident response plan</span>
                        </li>
                        <li class="flex items-start gap-2">
                            <i class="fa-solid fa-check text-purple-500 mt-1"></i>
                            <span>Automated threat detection</span>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </section>

    <!-- Data Protection -->
    <section class="py-20 bg-gradient-to-r from-emerald-600 to-teal-700">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="text-center mb-16">
                <h2 class="text-3xl font-bold text-white mb-4">Data Protection</h2>
                <p class="text-emerald-200">How we protect your sensitive fleet data</p>
            </div>

            <div class="grid md:grid-cols-2 gap-8">
                <div class="p-8 rounded-2xl bg-white/10 backdrop-blur-sm border border-white/20">
                    <h3 class="font-bold text-white text-xl mb-4">Data Segregation</h3>
                    <ul class="space-y-3">
                        <li class="flex items-start gap-2">
                            <i class="fa-solid fa-shield text-emerald-300 mt-1"></i>
                            <span class="text-emerald-100">Logical data separation between clients</span>
                        </li>
                        <li class="flex items-start gap-2">
                            <i class="fa-solid fa-database text-emerald-300 mt-1"></i>
                            <span class="text-emerald-100">Dedicated database instances for enterprise clients</span>
                        </li>
                        <li class="flex items-start gap-2">
                            <i class="fa-solid fa-code-branch text-emerald-300 mt-1"></i>
                            <span class="text-emerald-100">Isolated processing environments</span>
                        </li>
                    </ul>
                </div>

                <div class="p-8 rounded-2xl bg-white/10 backdrop-blur-sm border border-white/20">
                    <h3 class="font-bold text-white text-xl mb-4">Backup & Recovery</h3>
                    <ul class="space-y-3">
                        <li class="flex items-start gap-2">
                            <i class="fa-solid fa-hard-drive text-emerald-300 mt-1"></i>
                            <span class="text-emerald-100">Automated daily backups</span>
                        </li>
                        <li class="flex items-start gap-2">
                            <i class="fa-solid fa-cloud-arrow-up text-emerald-300 mt-1"></i>
                            <span class="text-emerald-100">Geo-redundant storage</span>
                        </li>
                        <li class="flex items-start gap-2">
                            <i class="fa-solid fa-rotate text-emerald-300 mt-1"></i>
                            <span class="text-emerald-100">Point-in-time recovery capability</span>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </section>

    <!-- Security FAQ -->
    <section class="py-20">
        <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="text-center mb-16">
                <h2 class="text-3xl font-bold mb-4">Security FAQ</h2>
                <p class="text-slate-600 dark:text-slate-400">Common questions about our security</p>
            </div>

            <div class="space-y-4">
                @php
                    $faqs = [
                        [
                            'q' => 'Where is my data stored?',
                            'a' => 'All data is stored in SOC 2 certified data centers with geographic redundancy. Primary data centers are located in the United States and European Union.'
                        ],
                        [
                            'q' => 'How do you handle data breaches?',
                            'a' => 'We have a comprehensive incident response plan that includes immediate containment, investigation, notification to affected parties (within 72 hours), and remediation steps.'
                        ],
                        [
                            'q' => 'Is my GPS data encrypted?',
                            'a' => 'Yes, all GPS data is encrypted using AES-256 both in transit (SSL/TLS) and at rest. Vehicle location data is encrypted end-to-end.'
                        ],
                        [
                            'q' => 'Do you conduct security audits?',
                            'a' => 'Yes, we undergo annual third-party security audits and maintain SOC 2 Type II certification. We also conduct regular penetration testing.'
                        ],
                        [
                            'q' => 'How is access to my data controlled?',
                            'a' => 'Access is controlled through multi-factor authentication, role-based access controls, and strict authorization policies. All access is logged and monitored.'
                        ],
                        [
                            'q' => 'Can I get a security assessment report?',
                            'a' => 'Enterprise customers can request our latest security assessment report and compliance documentation through their account manager.'
                        ],
                    ];
                @endphp

                @foreach($faqs as $faq)
                    <div class="group" x-data="{ open: false }">
                        <button @click="open = !open"
                                class="w-full p-6 rounded-xl glass border border-slate-200 dark:border-slate-800 text-left hover:border-emerald-300 dark:hover:border-emerald-700 transition-all">
                            <div class="flex items-center justify-between">
                                <h4 class="font-semibold text-lg">{{ $faq['q'] }}</h4>
                                <svg class="w-5 h-5 text-slate-500 transform transition-transform duration-300"
                                     :class="{ 'rotate-180': open }"
                                     fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"/>
                                </svg>
                            </div>
                            <div x-show="open" x-collapse class="mt-4 text-slate-600 dark:text-slate-400">
                                {{ $faq['a'] }}
                            </div>
                        </button>
                    </div>
                @endforeach
            </div>
        </div>
    </section>

    <!-- Report Security Issue -->
    <section class="py-20 bg-slate-50 dark:bg-slate-900/50">
        <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
            <div class="p-8 rounded-2xl glass border border-slate-200 dark:border-slate-800">
                <div class="w-16 h-16 rounded-xl bg-gradient-to-br from-emerald-500 to-teal-600 flex items-center justify-center mx-auto mb-6">
                    <i class="fa-solid fa-bug text-white text-2xl"></i>
                </div>
                <h2 class="text-3xl font-bold mb-4">Report a Security Issue</h2>
                <p class="text-xl text-slate-600 dark:text-slate-400 mb-8">
                    We take security seriously. If you discover a security vulnerability, please report it to us immediately.
                </p>

                <div class="grid md:grid-cols-2 gap-6 mb-8">
                    <div class="p-6 rounded-xl bg-white dark:bg-slate-800">
                        <h3 class="font-bold mb-2">Security Team</h3>
                        <div class="text-emerald-600 dark:text-emerald-400">security@trackpro.com</div>
                        <p class="text-sm text-slate-500 dark:text-slate-400 mt-2">
                            For security vulnerabilities and threats
                        </p>
                    </div>

                    <div class="p-6 rounded-xl bg-white dark:bg-slate-800">
                        <h3 class="font-bold mb-2">Responsible Disclosure</h3>
                        <div class="text-emerald-600 dark:text-emerald-400">Publish vulnerability details only after we've patched</div>
                        <p class="text-sm text-slate-500 dark:text-slate-400 mt-2">
                            We appreciate coordinated disclosure
                        </p>
                    </div>
                </div>

                <a href="mailto:security@trackpro.com"
                   class="inline-flex items-center gap-2 px-8 py-3 bg-gradient-to-r from-emerald-500 to-teal-600 text-white font-semibold rounded-xl hover:shadow-xl transition-all">
                    <i class="fa-solid fa-envelope"></i>
                    Report Security Issue
                </a>
            </div>
        </div>
    </section>

@endsection
