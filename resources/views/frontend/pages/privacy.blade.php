<!-- resources/views/frontend/pages/privacy.blade.php -->
@extends('frontend.layout')

@section('title', __('frontend.pages.privacy.title'))
@section('description', 'TrackPro GPS privacy policy. Learn how we collect, use, and protect your data.')

@section('content')

    <!-- Hero -->
    <section class="relative min-h-[60vh] flex items-center overflow-hidden">
        <div class="absolute inset-0 bg-gradient-to-br from-slate-50 via-blue-50 to-sky-100 dark:from-slate-950 dark:via-blue-950 dark:to-sky-950"></div>

        <div class="relative max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-24 text-center">
        <span class="inline-block px-4 py-1.5 bg-gradient-to-r from-blue-500/10 to-indigo-500/10 rounded-full text-blue-600 dark:text-blue-400 font-semibold text-sm mb-4">
            LEGAL
        </span>
            <h1 class="text-5xl lg:text-6xl font-bold mb-6">
                Privacy <span class="bg-gradient-to-r from-blue-500 to-indigo-600 bg-clip-text text-transparent">Policy</span>
            </h1>
            <p class="text-xl text-slate-600 dark:text-slate-300 max-w-3xl mx-auto">
                Last updated: {{ now()->format('F j, Y') }}
            </p>
        </div>
    </section>

    <!-- Content -->
    <section class="py-20">
        <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="prose prose-lg dark:prose-invert prose-blue max-w-none">
                <!-- Introduction -->
                <div class="mb-12">
                    <h2 class="text-3xl font-bold mb-6">1. Introduction</h2>
                    <p class="text-slate-600 dark:text-slate-400 mb-4">
                        TrackPro GPS ("we", "our", or "us") is committed to protecting your privacy. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our GPS tracking platform and services.
                    </p>
                    <p class="text-slate-600 dark:text-slate-400">
                        By using TrackPro GPS, you agree to the collection and use of information in accordance with this policy. If you have any questions about this Privacy Policy, please contact us.
                    </p>
                </div>

                <!-- Information We Collect -->
                <div class="mb-12">
                    <h2 class="text-3xl font-bold mb-6">2. Information We Collect</h2>

                    <h3 class="text-xl font-semibold mb-4">2.1 Personal Information</h3>
                    <p class="text-slate-600 dark:text-slate-400 mb-4">
                        When you register for an account or use our services, we may collect:
                    </p>
                    <ul class="text-slate-600 dark:text-slate-400 space-y-2 mb-6">
                        <li>Name, email address, and phone number</li>
                        <li>Company name and business information</li>
                        <li>Billing and payment information</li>
                        <li>Account credentials and preferences</li>
                    </ul>

                    <h3 class="text-xl font-semibold mb-4">2.2 Vehicle and GPS Data</h3>
                    <p class="text-slate-600 dark:text-slate-400 mb-4">
                        When using our GPS tracking services, we collect:
                    </p>
                    <ul class="text-slate-600 dark:text-slate-400 space-y-2 mb-6">
                        <li>Real-time vehicle location data</li>
                        <li>Speed, direction, and trip information</li>
                        <li>Vehicle identification and status data</li>
                        <li>Historical tracking data and routes</li>
                    </ul>

                    <h3 class="text-xl font-semibold mb-4">2.3 Technical Information</h3>
                    <p class="text-slate-600 dark:text-slate-400">
                        We automatically collect technical information including:
                    </p>
                    <ul class="text-slate-600 dark:text-slate-400 space-y-2">
                        <li>IP address and device information</li>
                        <li>Browser type and version</li>
                        <li>Usage patterns and service logs</li>
                        <li>Cookies and similar tracking technologies</li>
                    </ul>
                </div>

                <!-- How We Use Your Information -->
                <div class="mb-12">
                    <h2 class="text-3xl font-bold mb-6">3. How We Use Your Information</h2>

                    <div class="grid md:grid-cols-2 gap-6 mb-6">
                        <div class="p-6 rounded-xl bg-blue-50 dark:bg-blue-900/20">
                            <div class="w-12 h-12 rounded-lg bg-gradient-to-br from-blue-500 to-indigo-600 flex items-center justify-center mb-4">
                                <i class="fa-solid fa-location-dot text-white"></i>
                            </div>
                            <h4 class="font-bold mb-2">Service Provision</h4>
                            <p class="text-slate-600 dark:text-slate-400 text-sm">
                                To provide GPS tracking services, manage your account, and process transactions.
                            </p>
                        </div>

                        <div class="p-6 rounded-xl bg-blue-50 dark:bg-blue-900/20">
                            <div class="w-12 h-12 rounded-lg bg-gradient-to-br from-blue-500 to-indigo-600 flex items-center justify-center mb-4">
                                <i class="fa-solid fa-chart-line text-white"></i>
                            </div>
                            <h4 class="font-bold mb-2">Analytics & Improvement</h4>
                            <p class="text-slate-600 dark:text-slate-400 text-sm">
                                To analyze usage patterns and improve our services and user experience.
                            </p>
                        </div>

                        <div class="p-6 rounded-xl bg-blue-50 dark:bg-blue-900/20">
                            <div class="w-12 h-12 rounded-lg bg-gradient-to-br from-blue-500 to-indigo-600 flex items-center justify-center mb-4">
                                <i class="fa-solid fa-shield text-white"></i>
                            </div>
                            <h4 class="font-bold mb-2">Security & Compliance</h4>
                            <p class="text-slate-600 dark:text-slate-400 text-sm">
                                To protect against fraud, ensure security, and comply with legal obligations.
                            </p>
                        </div>

                        <div class="p-6 rounded-xl bg-blue-50 dark:bg-blue-900/20">
                            <div class="w-12 h-12 rounded-lg bg-gradient-to-br from-blue-500 to-indigo-600 flex items-center justify-center mb-4">
                                <i class="fa-solid fa-comments text-white"></i>
                            </div>
                            <h4 class="font-bold mb-2">Communication</h4>
                            <p class="text-slate-600 dark:text-slate-400 text-sm">
                                To send service updates, security alerts, and support messages.
                            </p>
                        </div>
                    </div>
                </div>

                <!-- Data Sharing -->
                <div class="mb-12">
                    <h2 class="text-3xl font-bold mb-6">4. Data Sharing and Disclosure</h2>

                    <p class="text-slate-600 dark:text-slate-400 mb-4">
                        We do not sell your personal information. We may share your information with:
                    </p>

                    <div class="space-y-4">
                        <div class="p-4 rounded-lg border border-slate-200 dark:border-slate-800">
                            <h4 class="font-bold mb-2">Service Providers</h4>
                            <p class="text-slate-600 dark:text-slate-400 text-sm">
                                Trusted third-party providers who assist in delivering our services (payment processors, hosting providers, etc.).
                            </p>
                        </div>

                        <div class="p-4 rounded-lg border border-slate-200 dark:border-slate-800">
                            <h4 class="font-bold mb-2">Legal Requirements</h4>
                            <p class="text-slate-600 dark:text-slate-400 text-sm">
                                When required by law, regulation, or legal process, or to protect our rights and safety.
                            </p>
                        </div>

                        <div class="p-4 rounded-lg border border-slate-200 dark:border-slate-800">
                            <h4 class="font-bold mb-2">Business Transfers</h4>
                            <p class="text-slate-600 dark:text-slate-400 text-sm">
                                In connection with a merger, acquisition, or sale of assets, with appropriate privacy protections.
                            </p>
                        </div>
                    </div>
                </div>

                <!-- Data Security -->
                <div class="mb-12">
                    <h2 class="text-3xl font-bold mb-6">5. Data Security</h2>

                    <div class="p-6 rounded-xl bg-gradient-to-br from-blue-500/10 to-indigo-500/10 border border-blue-200 dark:border-blue-800">
                        <div class="flex items-start gap-4">
                            <div class="w-12 h-12 rounded-lg bg-gradient-to-br from-blue-500 to-indigo-600 flex items-center justify-center flex-shrink-0">
                                <i class="fa-solid fa-lock text-white"></i>
                            </div>
                            <div>
                                <h4 class="font-bold mb-2">Enterprise-Grade Security</h4>
                                <p class="text-slate-600 dark:text-slate-400">
                                    We implement industry-standard security measures including AES-256 encryption, secure socket layer (SSL) technology, regular security audits, and access controls to protect your data.
                                </p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Your Rights -->
                <div class="mb-12">
                    <h2 class="text-3xl font-bold mb-6">6. Your Privacy Rights</h2>

                    <p class="text-slate-600 dark:text-slate-400 mb-6">
                        Depending on your location, you may have certain rights regarding your personal information:
                    </p>

                    <div class="grid md:grid-cols-2 gap-4">
                        <div class="p-4 rounded-lg bg-slate-50 dark:bg-slate-800/50">
                            <h4 class="font-bold mb-2">Access & Correction</h4>
                            <p class="text-slate-600 dark:text-slate-400 text-sm">
                                Right to access and correct your personal information
                            </p>
                        </div>

                        <div class="p-4 rounded-lg bg-slate-50 dark:bg-slate-800/50">
                            <h4 class="font-bold mb-2">Data Portability</h4>
                            <p class="text-slate-600 dark:text-slate-400 text-sm">
                                Right to receive your data in a structured, machine-readable format
                            </p>
                        </div>

                        <div class="p-4 rounded-lg bg-slate-50 dark:bg-slate-800/50">
                            <h4 class="font-bold mb-2">Deletion</h4>
                            <p class="text-slate-600 dark:text-slate-400 text-sm">
                                Right to request deletion of your personal information
                            </p>
                        </div>

                        <div class="p-4 rounded-lg bg-slate-50 dark:bg-slate-800/50">
                            <h4 class="font-bold mb-2">Opt-Out</h4>
                            <p class="text-slate-600 dark:text-slate-400 text-sm">
                                Right to opt-out of marketing communications
                            </p>
                        </div>
                    </div>
                </div>

                <!-- International Transfers -->
                <div class="mb-12">
                    <h2 class="text-3xl font-bold mb-6">7. International Data Transfers</h2>
                    <p class="text-slate-600 dark:text-slate-400">
                        TrackPro GPS operates globally. Your information may be transferred to and processed in countries other than your own. We ensure appropriate safeguards are in place for international data transfers, including Standard Contractual Clauses and Privacy Shield frameworks where applicable.
                    </p>
                </div>

                <!-- Children's Privacy -->
                <div class="mb-12">
                    <h2 class="text-3xl font-bold mb-6">8. Children's Privacy</h2>
                    <p class="text-slate-600 dark:text-slate-400">
                        Our services are not directed to individuals under 16. We do not knowingly collect personal information from children under 16. If you become aware that a child has provided us with personal information, please contact us.
                    </p>
                </div>

                <!-- Changes to Policy -->
                <div class="mb-12">
                    <h2 class="text-3xl font-bold mb-6">9. Changes to This Policy</h2>
                    <p class="text-slate-600 dark:text-slate-400 mb-4">
                        We may update this Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page and updating the "Last updated" date.
                    </p>
                    <p class="text-slate-600 dark:text-slate-400">
                        We encourage you to review this Privacy Policy periodically for any changes. Changes to this Privacy Policy are effective when they are posted on this page.
                    </p>
                </div>

                <!-- Contact -->
                <div class="mb-12">
                    <h2 class="text-3xl font-bold mb-6">10. Contact Us</h2>
                    <div class="p-6 rounded-xl bg-blue-50 dark:bg-blue-900/20">
                        <p class="text-slate-600 dark:text-slate-400 mb-4">
                            If you have any questions about this Privacy Policy or our privacy practices, please contact us at:
                        </p>
                        <div class="space-y-2">
                            <p class="text-slate-700 dark:text-slate-300">
                                <strong>Email:</strong> privacy@trackpro.com
                            </p>
                            <p class="text-slate-700 dark:text-slate-300">
                                <strong>Phone:</strong> +1 (555) 123-4567
                            </p>
                            <p class="text-slate-700 dark:text-slate-300">
                                <strong>Address:</strong> 123 Privacy Street, Suite 100, San Francisco, CA 94107
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Quick Links -->
    <section class="py-20 bg-slate-50 dark:bg-slate-900/50">
        <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="text-center mb-12">
                <h2 class="text-2xl font-bold mb-4">Related Legal Documents</h2>
                <p class="text-slate-600 dark:text-slate-400">Review our complete legal framework</p>
            </div>

            <div class="grid md:grid-cols-4 gap-4">
                <a href="{{ route('terms') }}" class="p-4 rounded-xl bg-white dark:bg-slate-800 border border-slate-200 dark:border-slate-700 hover:border-blue-300 dark:hover:border-blue-700 transition-colors text-center">
                    <div class="w-10 h-10 rounded-lg bg-gradient-to-br from-blue-500 to-indigo-600 flex items-center justify-center mx-auto mb-3">
                        <i class="fa-solid fa-file-contract text-white"></i>
                    </div>
                    <div class="font-medium">Terms of Service</div>
                </a>

                <a href="{{ route('security') }}" class="p-4 rounded-xl bg-white dark:bg-slate-800 border border-slate-200 dark:border-slate-700 hover:border-emerald-300 dark:hover:border-emerald-700 transition-colors text-center">
                    <div class="w-10 h-10 rounded-lg bg-gradient-to-br from-emerald-500 to-teal-600 flex items-center justify-center mx-auto mb-3">
                        <i class="fa-solid fa-shield text-white"></i>
                    </div>
                    <div class="font-medium">Security</div>
                </a>

                <a href="{{ route('cookies') }}" class="p-4 rounded-xl bg-white dark:bg-slate-800 border border-slate-200 dark:border-slate-700 hover:border-amber-300 dark:hover:border-amber-700 transition-colors text-center">
                    <div class="w-10 h-10 rounded-lg bg-gradient-to-br from-amber-500 to-orange-600 flex items-center justify-center mx-auto mb-3">
                        <i class="fa-solid fa-cookie text-white"></i>
                    </div>
                    <div class="font-medium">Cookies Policy</div>
                </a>

                <a href="{{ route('contact') }}" class="p-4 rounded-xl bg-white dark:bg-slate-800 border border-slate-200 dark:border-slate-700 hover:border-sky-300 dark:hover:border-sky-700 transition-colors text-center">
                    <div class="w-10 h-10 rounded-lg bg-gradient-to-br from-sky-500 to-blue-600 flex items-center justify-center mx-auto mb-3">
                        <i class="fa-solid fa-envelope text-white"></i>
                    </div>
                    <div class="font-medium">Contact Us</div>
                </a>
            </div>
        </div>
    </section>

@endsection
