<?php
// app/Http\Controllers/ContactController.php

namespace App\Http\Controllers;

use App\Http\Requests\ContactFormRequest;
use App\Models\ContactMessage;
use App\Mail\ContactConfirmationMail;
use App\Mail\ContactNotificationMail;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\RateLimiter;
use Illuminate\Http\Request;
use Spatie\Activitylog\Models\Activity;

class ContactController extends Controller
{
    public function show()
    {
        return view('frontend.contact');
    }

    public function submit(ContactFormRequest $request)
    {
        // Honeypot validation (bots fill this invisible field)
        if (!empty($request->honeypot)) {

            activity('contact')
                ->withProperties([
                    'ip' => $request->ip(),
                    'user_agent' => $request->userAgent(),
                ])
                ->log('Contact form honeypot triggered');

            Log::channel('contact')->warning('Honeypot triggered', [
                'ip' => $request->ip(),
                'honeypot' => $request->honeypot
            ]);

            // Return success to bot but don't actually process
            return response()->json([
                'success' => true,
                'message' => 'Thank you for your message!'
            ]);
        }

        // Rate limiting: max 3 attempts per IP per 5 minutes
        $key = 'contact-form:' . $request->ip();

        if (RateLimiter::tooManyAttempts($key, 1)) {
            $seconds = RateLimiter::availableIn($key);

            activity('contact')
                ->withProperties([
                    'ip' => $request->ip(),
                    'available_in_seconds' => RateLimiter::availableIn($key),
                ])
                ->log('Contact form rate limit exceeded');

            return response()->json([
                'success' => false,
                'message' => 'Too many submission attempts. Please try again in 30 minutes.'
            ], 429);
        }

        RateLimiter::hit($key, 1800); // 30 minutes decay

        DB::beginTransaction();

        try {
            // Additional spam validation
            if ($this->isSpam($request)) {

                activity('contact')
                    ->withProperties([
                        'email' => $request->email,
                        'ip' => $request->ip(),
                    ])
                    ->log('Contact form spam detected');

                Log::channel('contact')->warning('Spam detected', [
                    'ip' => $request->ip(),
                    'email' => $request->email
                ]);

                return response()->json([
                    'success' => false,
                    'message' => 'Your message appears to be spam. Please contact us directly if this is an error.'
                ], 422);
            }

            // Create contact message
            $contactMessage = ContactMessage::create([
                'name' => $request->name,
                'email' => $request->email,
                'phone' => $request->phone,
                'company' => $request->company,
                'subject' => $request->subject,
                'message' => $request->message,
                'ip_address' => $request->ip,
                'user_agent' => $request->userAgent(),
                'metadata' => [
                    'form_source' => 'contact_page',
                    'referrer' => $request->headers->get('referer'),
                    'timezone' => $request->header('X-Timezone', 'UTC'),
                    'submission_time' => now()->toIso8601String(),
                ]
            ]);

            activity('contact')
                ->performedOn($contactMessage)
                ->causedBy(auth()->user()) // null for guests (OK)
                ->withProperties([
                    'ticket_number' => 'TP-' . str_pad($contactMessage->id, 6, '0', STR_PAD_LEFT),
                    'email' => $contactMessage->email,
                    'ip' => $request->ip(),
                ])
                ->log('Contact message submitted');

            // Send confirmation email to customer
            Mail::to($contactMessage->email)->send(new ContactConfirmationMail($contactMessage));

            // Send notification to admin team
            $adminEmails = config('mail.admin_emails', [
                env('MAIL_USERNAME', 'support@trackpro.com')
            ]);

            foreach ($adminEmails as $adminEmail) {
                Mail::to($adminEmail)->send(new ContactNotificationMail($contactMessage));
            }

            activity('contact')
                ->performedOn($contactMessage)
                ->withProperties([
                    'sent_to_user' => true,
                    'admin_recipients' => count($adminEmails),
                ])
                ->log('Contact notification emails sent');

            // Log the submission
            Log::channel('contact')->info('New contact message submitted', [
                'id' => $contactMessage->id,
                'email' => $contactMessage->email,
                'subject' => $contactMessage->subject,
                'ip' => $contactMessage->ip
            ]);

            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Thank you for your message! We\'ll get back to you within 24 hours.',
                'ticket_number' => 'TP-' . str_pad($contactMessage->id, 6, '0', STR_PAD_LEFT)
            ]);

        } catch (\Exception $e) {
            DB::rollBack();

            activity('contact')
                ->withProperties([
                    'error' => $e->getMessage(),
                    'ip' => $request->ip(),
                ])
                ->log('Contact form submission failed');

            Log::channel('contact')->error('Contact form submission failed', [
                'error' => $e->getMessage(),
                'trace' => $e->getTraceAsString(),
                'ip' => $request->ip()
            ]);

            return response()->json([
                'success' => false,
                'message' => 'Something went wrong. Please try again or contact us directly.',
                'error' => config('app.debug') ? $e->getMessage() : null
            ], 500);
        }
    }

    /**
     * Basic spam detection
     */
    private function isSpam($request): bool
    {
        // Check for suspicious patterns
        $spamPatterns = [
            '/viagra/i',
            '/casino/i',
            '/lottery/i',
            '/xxx/i',
            '/porn/i',
            '/[A-Z]{5,}/', // Excessive caps
            '/http(s)?:\/\/[^\s]*/', // URLs
        ];

        $fieldsToCheck = [
            'name' => $request->name,
            'email' => $request->email,
            'subject' => $request->subject,
            'message' => $request->message,
        ];

        foreach ($fieldsToCheck as $field => $value) {
            foreach ($spamPatterns as $pattern) {
                if (preg_match($pattern, $value)) {
                    return true;
                }
            }
        }

        // Check for gibberish (too many random characters)
        $message = $request->message;
        if (strlen($message) > 50) {
            $uniqueChars = count(array_unique(str_split($message)));
            $charRatio = $uniqueChars / strlen($message);

            // High ratio of unique characters often indicates gibberish
            if ($charRatio > 0.8) {
                return true;
            }
        }

        return false;
    }

    /**
     * Check rate limit status
     */
    public function checkRateLimit(Request $request)
    {
        $key = 'contact-form:' . $request->ip();
        $remaining = RateLimiter::remaining($key, 1);
        $availableIn = RateLimiter::availableIn($key);

        return response()->json([
            'remaining' => $remaining,
            'available_in_seconds' => $availableIn,
            'too_many_attempts' => RateLimiter::tooManyAttempts($key, 1)
        ]);
    }
}
