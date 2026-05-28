<?php
// app/Http/Controllers/ContactController.php

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

class ContactController extends Controller
{
    public function show()
    {
        return view('frontend.contact');
    }

    public function submit(ContactFormRequest $request)
    {
        // Honeypot validation (bots fill this invisible field)
        if (! empty($request->honeypot)) {
            Log::warning('Contact form honeypot triggered', [
                'ip' => $request->ip(),
                'honeypot' => $request->honeypot,
            ]);

            // Return success to bot but don't actually process
            return response()->json([
                'success' => true,
                'message' => 'Thank you for your message!',
            ]);
        }

        // Rate limiting: max 1 attempt per IP per 30 minutes
        $key = 'contact-form:'.$request->ip();

        if (RateLimiter::tooManyAttempts($key, 1)) {
            return response()->json([
                'success' => false,
                'message' => 'Too many submission attempts. Please try again in 30 minutes.',
            ], 429);
        }

        RateLimiter::hit($key, 1800);

        if ($this->isSpam($request)) {
            Log::warning('Contact form spam detected', [
                'ip' => $request->ip(),
                'email' => $request->email,
            ]);

            return response()->json([
                'success' => false,
                'message' => 'Your message appears to be spam. Please contact us directly if this is an error.',
            ], 422);
        }

        try {
            $contactMessage = DB::transaction(function () use ($request) {
                return ContactMessage::create([
                    'name' => $request->name,
                    'email' => $request->email,
                    'phone' => $request->phone,
                    'company' => $request->company,
                    'subject' => $request->subject,
                    'message' => $request->message,
                    'ip_address' => $request->ip(),
                    'user_agent' => $request->userAgent(),
                    'metadata' => [
                        'form_source' => 'contact_page',
                        'referrer' => $request->headers->get('referer'),
                        'timezone' => $request->header('X-Timezone', 'UTC'),
                        'submission_time' => now()->toIso8601String(),
                    ],
                ]);
            });

            $this->sendContactEmails($contactMessage);

            Log::info('New contact message submitted', [
                'id' => $contactMessage->id,
                'email' => $contactMessage->email,
                'subject' => $contactMessage->subject,
                'ip' => $contactMessage->ip_address,
            ]);

            return response()->json([
                'success' => true,
                'message' => 'Thank you for your message! We\'ll get back to you within 24 hours.',
                'ticket_number' => 'TP-'.str_pad((string) $contactMessage->id, 6, '0', STR_PAD_LEFT),
            ]);
        } catch (\Throwable $e) {
            Log::error('Contact form submission failed', [
                'error' => $e->getMessage(),
                'ip' => $request->ip(),
            ]);

            return response()->json([
                'success' => false,
                'message' => 'Something went wrong. Please try again or contact us directly.',
                'error' => config('app.debug') ? $e->getMessage() : null,
            ], 500);
        }
    }

    /**
     * @return list<string>
     */
    private function adminRecipients(): array
    {
        $emails = collect(config('mail.admin_emails', []))
            ->filter(fn ($email) => is_string($email) && filter_var(trim($email), FILTER_VALIDATE_EMAIL))
            ->map(fn ($email) => trim($email))
            ->unique()
            ->values()
            ->all();

        if ($emails !== []) {
            return $emails;
        }

        $fallback = config('contact.email');

        return is_string($fallback) && filter_var($fallback, FILTER_VALIDATE_EMAIL)
            ? [$fallback]
            : [];
    }

    private function sendContactEmails(ContactMessage $contactMessage): void
    {
        try {
            Mail::to($contactMessage->email)->send(new ContactConfirmationMail($contactMessage));
        } catch (\Throwable $e) {
            Log::warning('Contact confirmation email failed', [
                'message_id' => $contactMessage->id,
                'error' => $e->getMessage(),
            ]);
        }

        foreach ($this->adminRecipients() as $adminEmail) {
            try {
                Mail::to($adminEmail)->send(new ContactNotificationMail($contactMessage));
            } catch (\Throwable $e) {
                Log::warning('Contact admin notification email failed', [
                    'message_id' => $contactMessage->id,
                    'admin_email' => $adminEmail,
                    'error' => $e->getMessage(),
                ]);
            }
        }
    }

    /**
     * Basic spam detection
     */
    private function isSpam($request): bool
    {
        $spamPatterns = [
            '/viagra/i',
            '/casino/i',
            '/lottery/i',
            '/xxx/i',
            '/porn/i',
        ];

        $fieldsToCheck = [
            'name' => $request->name,
            'email' => $request->email,
            'subject' => $request->subject,
            'message' => $request->message,
        ];

        foreach ($fieldsToCheck as $value) {
            foreach ($spamPatterns as $pattern) {
                if (preg_match($pattern, (string) $value)) {
                    return true;
                }
            }
        }

        return false;
    }

    /**
     * Check rate limit status
     */
    public function checkRateLimit(Request $request)
    {
        $key = 'contact-form:'.$request->ip();
        $remaining = RateLimiter::remaining($key, 1);
        $availableIn = RateLimiter::availableIn($key);

        return response()->json([
            'remaining' => $remaining,
            'available_in_seconds' => $availableIn,
            'too_many_attempts' => RateLimiter::tooManyAttempts($key, 1),
        ]);
    }
}
