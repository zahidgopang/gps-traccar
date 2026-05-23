<!-- resources/views/frontend/pages/terms.blade.php -->
@extends('frontend.layout')

@section('title', __('frontend.pages.terms.title'))
@section('description', 'TrackPro GPS terms of service and conditions of use for our GPS tracking platform.')

@section('content')

    <!-- Hero -->
    <section class="relative min-h-[60vh] flex items-center overflow-hidden">
        <div class="absolute inset-0 bg-gradient-to-br from-slate-50 via-indigo-50 to-purple-100 dark:from-slate-950 dark:via-indigo-950 dark:to-purple-950"></div>

        <div class="relative max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-24 text-center">
        <span class="inline-block px-4 py-1.5 bg-gradient-to-r from-indigo-500/10 to-purple-500/10 rounded-full text-indigo-600 dark:text-indigo-400 font-semibold text-sm mb-4">
            LEGAL AGREEMENT
        </span>
            <h1 class="text-5xl lg:text-6xl font-bold mb-6">
                Terms of <span class="bg-gradient-to-r from-indigo-500 to-purple-600 bg-clip-text text-transparent">Service</span>
            </h1>
            <p class="text-xl text-slate-600 dark:text-slate-300 max-w-3xl mx-auto">
                Last updated: {{ now()->format('F j, Y') }}
            </p>
        </div>
    </section>

    <!-- Content -->
    <section class="py-20">
        <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="prose prose-lg dark:prose-invert prose-indigo max-w-none">
                <!-- Introduction -->
                <div class="mb-12 p-6 rounded-xl bg-gradient-to-br from-indigo-500/5 to-purple-500/5 border border-indigo-200 dark:border-indigo-800">
                    <h2 class="text-3xl font-bold mb-4">Important Notice</h2>
                    <p class="text-slate-600 dark:text-slate-400">
                        These Terms of Service ("Terms") govern your access to and use of TrackPro GPS services. By accessing or using our services, you agree to be bound by these Terms. If you disagree with any part of the terms, you may not access the service.
                    </p>
                </div>

                <!-- 1. Definitions -->
                <div class="mb-12">
                    <h2 class="text-3xl font-bold mb-6">1. Definitions</h2>

                    <div class="space-y-4">
                        <div class="p-4 rounded-lg border border-slate-200 dark:border-slate-800">
                            <h4 class="font-bold mb-2">"Service"</h4>
                            <p class="text-slate-600 dark:text-slate-400">
                                Refers to the TrackPro GPS platform, website, mobile applications, and all related services provided by TrackPro GPS.
                            </p>
                        </div>

                        <div class="p-4 rounded-lg border border-slate-200 dark:border-slate-800">
                            <h4 class="font-bold mb-2">"User", "You"</h4>
                            <p class="text-slate-600 dark:text-slate-400">
                                Refers to the individual or entity accessing or using the Service.
                            </p>
                        </div>

                        <div class="p-4 rounded-lg border border-slate-200 dark:border-slate-800">
                            <h4 class="font-bold mb-2">"Content"</h4>
                            <p class="text-slate-600 dark:text-slate-400">
                                Refers to all information, data, text, GPS coordinates, and other materials available through the Service.
                            </p>
                        </div>
                    </div>
                </div>

                <!-- 2. Account Terms -->
                <div class="mb-12">
                    <h2 class="text-3xl font-bold mb-6">2. Account Registration and Security</h2>

                    <div class="space-y-6">
                        <div>
                            <h3 class="text-xl font-semibold mb-3">2.1 Account Creation</h3>
                            <p class="text-slate-600 dark:text-slate-400 mb-4">
                                To use our Service, you must register for an account and provide accurate, complete, and current information. You must be at least 18 years old to create an account.
                            </p>
                        </div>

                        <div>
                            <h3 class="text-xl font-semibold mb-3">2.2 Account Security</h3>
                            <p class="text-slate-600 dark:text-slate-400 mb-4">
                                You are responsible for maintaining the confidentiality of your account credentials and for all activities that occur under your account. You must immediately notify us of any unauthorized use of your account.
                            </p>
                        </div>

                        <div>
                            <h3 class="text-xl font-semibold mb-3">2.3 Account Termination</h3>
                            <p class="text-slate-600 dark:text-slate-400">
                                We reserve the right to suspend or terminate your account if you violate these Terms or engage in activities that may harm our Service or other users.
                            </p>
                        </div>
                    </div>
                </div>

                <!-- 3. Service Usage -->
                <div class="mb-12">
                    <h2 class="text-3xl font-bold mb-6">3. Acceptable Use Policy</h2>

                    <div class="p-6 rounded-xl bg-red-50 dark:bg-red-900/20 border border-red-200 dark:border-red-800 mb-6">
                        <h4 class="font-bold text-red-700 dark:text-red-400 mb-2">Prohibited Activities</h4>
                        <p class="text-red-600 dark:text-red-300 text-sm">
                            You agree not to use the Service for any unlawful purpose or in any way that could damage, disable, overburden, or impair the Service.
                        </p>
                    </div>

                    <div class="grid md:grid-cols-2 gap-4">
                        <div class="p-4 rounded-lg bg-slate-50 dark:bg-slate-800/50">
                            <div class="flex items-center gap-2 mb-2">
                                <i class="fa-solid fa-ban text-red-500"></i>
                                <h4 class="font-bold">Illegal Activities</h4>
                            </div>
                            <p class="text-slate-600 dark:text-slate-400 text-sm">
                                Using the Service for any illegal purpose or in violation of any laws
                            </p>
                        </div>

                        <div class="p-4 rounded-lg bg-slate-50 dark:bg-slate-800/50">
                            <div class="flex items-center gap-2 mb-2">
                                <i class="fa-solid fa-ban text-red-500"></i>
                                <h4 class="font-bold">Security Violations</h4>
                            </div>
                            <p class="text-slate-600 dark:text-slate-400 text-sm">
                                Attempting to breach security or access unauthorized areas
                            </p>
                        </div>

                        <div class="p-4 rounded-lg bg-slate-50 dark:bg-slate-800/50">
                            <div class="flex items-center gap-2 mb-2">
                                <i class="fa-solid fa-ban text-red-500"></i>
                                <h4 class="font-bold">Data Mining</h4>
                            </div>
                            <p class="text-slate-600 dark:text-slate-400 text-sm">
                                Scraping, crawling, or harvesting data without permission
                            </p>
                        </div>

                        <div class="p-4 rounded-lg bg-slate-50 dark:bg-slate-800/50">
                            <div class="flex items-center gap-2 mb-2">
                                <i class="fa-solid fa-ban text-red-500"></i>
                                <h4 class="font-bold">Service Abuse</h4>
                            </div>
                            <p class="text-slate-600 dark:text-slate-400 text-sm">
                                Overloading the Service or interfering with other users
                            </p>
                        </div>
                    </div>
                </div>

                <!-- 4. Payments and Billing -->
                <div class="mb-12">
                    <h2 class="text-3xl font-bold mb-6">4. Payments and Billing</h2>

                    <div class="space-y-6">
                        <div>
                            <h3 class="text-xl font-semibold mb-3">4.1 Subscription Plans</h3>
                            <p class="text-slate-600 dark:text-slate-400">
                                Our Service is offered under various subscription plans with different features and pricing. All fees are stated in US dollars and are exclusive of applicable taxes.
                            </p>
                        </div>

                        <div>
                            <h3 class="text-xl font-semibold mb-3">4.2 Billing Cycle</h3>
                            <p class="text-slate-600 dark:text-slate-400 mb-4">
                                Subscription fees are billed in advance on a monthly or annual basis, depending on your selected plan. You authorize us to charge your payment method for recurring payments.
                            </p>
                        </div>

                        <div>
                            <h3 class="text-xl font-semibold mb-3">4.3 Cancellation and Refunds</h3>
                            <p class="text-slate-600 dark:text-slate-400 mb-4">
                                You may cancel your subscription at any time. Cancellation will take effect at the end of your current billing period. We do not provide refunds for partial billing periods.
                            </p>
                        </div>

                        <div>
                            <h3 class="text-xl font-semibold mb-3">4.4 Price Changes</h3>
                            <p class="text-slate-600 dark:text-slate-400">
                                We reserve the right to modify subscription fees. Price changes will be communicated at least 30 days in advance and will not affect current subscriptions until renewal.
                            </p>
                        </div>
                    </div>
                </div>

                <!-- 5. Intellectual Property -->
                <div class="mb-12">
                    <h2 class="text-3xl font-bold mb-6">5. Intellectual Property Rights</h2>

                    <div class="p-6 rounded-xl bg-gradient-to-br from-indigo-500/10 to-purple-500/10 border border-indigo-200 dark:border-indigo-800">
                        <div class="flex items-start gap-4">
                            <div class="w-12 h-12 rounded-lg bg-gradient-to-br from-indigo-500 to-purple-600 flex items-center justify-center flex-shrink-0">
                                <i class="fa-solid fa-copyright text-white"></i>
                            </div>
                            <div>
                                <h4 class="font-bold mb-2">Ownership Rights</h4>
                                <p class="text-slate-600 dark:text-slate-400">
                                    The Service and its original content, features, and functionality are and will remain the exclusive property of TrackPro GPS and its licensors. Our trademarks and trade dress may not be used without prior written permission.
                                </p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 6. Data Ownership -->
                <div class="mb-12">
                    <h2 class="text-3xl font-bold mb-6">6. Data Ownership and Usage</h2>

                    <div class="space-y-4">
                        <div class="p-4 rounded-lg border border-slate-200 dark:border-slate-800">
                            <h4 class="font-bold mb-2">Your Data</h4>
                            <p class="text-slate-600 dark:text-slate-400">
                                You retain ownership of all data you upload or generate through the Service. However, by using our Service, you grant us a license to use, process, and store your data as necessary to provide the Service.
                            </p>
                        </div>

                        <div class="p-4 rounded-lg border border-slate-200 dark:border-slate-800">
                            <h4 class="font-bold mb-2">Aggregated Data</h4>
                            <p class="text-slate-600 dark:text-slate-400">
                                We may collect and use aggregated, anonymized data for statistical analysis, service improvement, and business purposes. This data will not identify you personally.
                            </p>
                        </div>
                    </div>
                </div>

                <!-- 7. Termination -->
                <div class="mb-12">
                    <h2 class="text-3xl font-bold mb-6">7. Termination</h2>

                    <div class="grid md:grid-cols-2 gap-6">
                        <div class="p-6 rounded-xl bg-slate-50 dark:bg-slate-800/50">
                            <h4 class="font-bold mb-2 text-red-600 dark:text-red-400">By You</h4>
                            <p class="text-slate-600 dark:text-slate-400 text-sm">
                                You may terminate your account at any time by contacting our support team or through your account settings.
                            </p>
                        </div>

                        <div class="p-6 rounded-xl bg-slate-50 dark:bg-slate-800/50">
                            <h4 class="font-bold mb-2 text-red-600 dark:text-red-400">By Us</h4>
                            <p class="text-slate-600 dark:text-slate-400 text-sm">
                                We may terminate or suspend your account immediately, without prior notice, for conduct that we believe violates these Terms or is harmful to other users.
                            </p>
                        </div>
                    </div>

                    <div class="mt-6 p-4 rounded-lg bg-amber-50 dark:bg-amber-900/20 border border-amber-200 dark:border-amber-800">
                        <h4 class="font-bold text-amber-700 dark:text-amber-400 mb-2">Effect of Termination</h4>
                        <p class="text-amber-600 dark:text-amber-300 text-sm">
                            Upon termination, your right to use the Service will immediately cease. We may delete your data according to our data retention policies.
                        </p>
                    </div>
                </div>

                <!-- 8. Disclaimer of Warranties -->
                <div class="mb-12">
                    <h2 class="text-3xl font-bold mb-6">8. Disclaimer of Warranties</h2>

                    <div class="p-6 rounded-xl bg-slate-50 dark:bg-slate-800/50 border border-slate-200 dark:border-slate-800">
                        <p class="text-slate-600 dark:text-slate-400 mb-4">
                            THE SERVICE IS PROVIDED "AS IS" AND "AS AVAILABLE" WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, OR NON-INFRINGEMENT.
                        </p>
                        <p class="text-slate-600 dark:text-slate-400">
                            We do not warrant that the Service will be uninterrupted, timely, secure, or error-free, or that any defects will be corrected.
                        </p>
                    </div>
                </div>

                <!-- 9. Limitation of Liability -->
                <div class="mb-12">
                    <h2 class="text-3xl font-bold mb-6">9. Limitation of Liability</h2>

                    <div class="p-6 rounded-xl bg-red-50 dark:bg-red-900/20 border border-red-200 dark:border-red-800">
                        <p class="text-red-600 dark:text-red-300">
                            TO THE MAXIMUM EXTENT PERMITTED BY LAW, TRACKPRO GPS SHALL NOT BE LIABLE FOR ANY INDIRECT, INCIDENTAL, SPECIAL, CONSEQUENTIAL, OR PUNITIVE DAMAGES, INCLUDING WITHOUT LIMITATION, LOSS OF PROFITS, DATA, USE, GOODWILL, OR OTHER INTANGIBLE LOSSES.
                        </p>
                    </div>

                    <div class="mt-6 p-4 rounded-lg bg-slate-50 dark:bg-slate-800/50">
                        <h4 class="font-bold mb-2">Maximum Liability</h4>
                        <p class="text-slate-600 dark:text-slate-400">
                            Our total liability for any claims under these Terms shall not exceed the amount paid by you to us during the six (6) months preceding the claim.
                        </p>
                    </div>
                </div>

                <!-- 10. Governing Law -->
                <div class="mb-12">
                    <h2 class="text-3xl font-bold mb-6">10. Governing Law and Dispute Resolution</h2>

                    <div class="space-y-4">
                        <div class="p-4 rounded-lg border border-slate-200 dark:border-slate-800">
                            <h4 class="font-bold mb-2">Governing Law</h4>
                            <p class="text-slate-600 dark:text-slate-400">
                                These Terms shall be governed by and construed in accordance with the laws of the State of California, without regard to its conflict of law provisions.
                            </p>
                        </div>

                        <div class="p-4 rounded-lg border border-slate-200 dark:border-slate-800">
                            <h4 class="font-bold mb-2">Dispute Resolution</h4>
                            <p class="text-slate-600 dark:text-slate-400">
                                Any disputes arising from these Terms shall be resolved through binding arbitration in San Francisco, California, in accordance with the rules of the American Arbitration Association.
                            </p>
                        </div>
                    </div>
                </div>

                <!-- 11. Changes to Terms -->
                <div class="mb-12">
                    <h2 class="text-3xl font-bold mb-6">11. Changes to Terms</h2>
                    <p class="text-slate-600 dark:text-slate-400 mb-4">
                        We reserve the right to modify or replace these Terms at any time. If a revision is material, we will provide at least 30 days' notice prior to any new terms taking effect.
                    </p>
                    <p class="text-slate-600 dark:text-slate-400">
                        By continuing to access or use our Service after those revisions become effective, you agree to be bound by the revised terms.
                    </p>
                </div>

                <!-- 12. Contact -->
                <div class="mb-12">
                    <h2 class="text-3xl font-bold mb-6">12. Contact Information</h2>
                    <div class="p-6 rounded-xl bg-indigo-50 dark:bg-indigo-900/20">
                        <p class="text-slate-600 dark:text-slate-400 mb-4">
                            For questions about these Terms of Service, please contact us at:
                        </p>
                        <div class="space-y-2">
                            <p class="text-slate-700 dark:text-slate-300">
                                <strong>Legal Department</strong><br>
                                TrackPro GPS<br>
                                123 Legal Avenue, Suite 200<br>
                                San Francisco, CA 94107
                            </p>
                            <p class="text-slate-700 dark:text-slate-300">
                                <strong>Email:</strong> legal@trackpro.com
                            </p>
                            <p class="text-slate-700 dark:text-slate-300">
                                <strong>Phone:</strong> +1 (555) 123-4567
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Quick Acceptance -->
    <section class="py-20 bg-gradient-to-r from-indigo-600 to-purple-700">
        <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
            <div class="p-8 rounded-2xl bg-white/10 backdrop-blur-sm border border-white/20">
                <h2 class="text-2xl font-bold text-white mb-4">Acceptance of Terms</h2>
                <p class="text-indigo-200 mb-6">
                    By using TrackPro GPS services, you acknowledge that you have read, understood, and agree to be bound by these Terms of Service.
                </p>
                <div class="flex flex-col sm:flex-row gap-4 justify-center">
                    <a href="{{ route('register') }}" class="px-6 py-3 bg-white text-indigo-700 font-semibold rounded-xl hover:bg-indigo-50 transition-colors">
                        Create Account
                    </a>
                    <a href="{{ route('contact') }}?subject=Terms%20Questions" class="px-6 py-3 border-2 border-white text-white font-semibold rounded-xl hover:bg-white/10 transition-colors">
                        Questions?
                    </a>
                </div>
            </div>
        </div>
    </section>

@endsection
