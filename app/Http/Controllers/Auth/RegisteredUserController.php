<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Models\User;
use App\Services\Traccar\TraccarEntityProvisioner;
use App\Support\Traccar\TraccarMode;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use Illuminate\Validation\Rules;
use Illuminate\View\View;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Auth;

class RegisteredUserController extends Controller
{
    public function create(): View
    {
        return view('auth.register');
    }

    public function store(Request $request)
    {
        // Log registration attempt for debugging
        Log::info('Registration attempt started', [
            'email' => $request->email,
            'ip' => $request->ip(),
            'user_agent' => $request->userAgent()
        ]);

        // ---------------- reCAPTCHA v3 ----------------
        $token = $request->input('g-recaptcha-response');

        if (!$token) {
            Log::warning('reCAPTCHA token missing', ['email' => $request->email]);

            if ($request->wantsJson() || $request->ajax()) {
                return response()->json([
                    'success' => false,
                    'errors' => ['g-recaptcha-response' => ['Security token missing. Please try again.']]
                ], 422);
            }

            return back()->withErrors([
                'g-recaptcha-response' => 'Security token missing. Please try again.'
            ])->withInput();
        }

        $response = Http::asForm()->post(
            'https://www.google.com/recaptcha/api/siteverify',
            [
                'secret'   => config('captcha.secret'),
                'response' => $token,
                'remoteip' => $request->ip(),
            ]
        );

        $data = $response->json();

        if (
            empty($data['success']) ||
            ($data['action'] ?? '') !== 'register' ||
            ($data['score'] ?? 0) < 0.3
        ) {
            Log::warning('reCAPTCHA verification failed', [
                'email' => $request->email,
                'score' => $data['score'] ?? null,
                'action' => $data['action'] ?? null
            ]);

            activity()
                ->withProperties([
                    'type' => 'recaptcha_failed',
                    'email' => $request->email,
                    'ip' => $request->ip(),
                    'score' => $data['score'] ?? null,
                    'action' => $data['action'] ?? null,
                ])
                ->log('reCAPTCHA v3 blocked registration');

            if ($request->wantsJson() || $request->ajax()) {
                return response()->json([
                    'success' => false,
                    'errors' => ['g-recaptcha-response' => ['Security check failed. Please try again.']]
                ], 422);
            }

            return back()->withErrors([
                'g-recaptcha-response' => 'Security check failed. Please try again.'
            ])->withInput();
        }

        // ---------------- FORM VALIDATION ----------------
        try {
            $validated = $request->validate([
                'name' => ['required', 'string', 'max:255'],
                'email' => ['required', 'string', 'lowercase', 'email', 'max:255', 'unique:tc_users,email'],
                'country_code' => ['required', 'string', 'max:6'],
                'phone' => ['required', 'string', 'min:7', 'max:20'],
                'password' => ['required', 'confirmed', Rules\Password::defaults()],
                'terms' => ['required', 'accepted'],
            ]);

            Log::info('Form validation passed', ['email' => $validated['email']]);

        } catch (\Illuminate\Validation\ValidationException $e) {
            Log::warning('Form validation failed', [
                'errors' => $e->errors(),
                'email' => $request->email
            ]);

            if ($request->wantsJson() || $request->ajax()) {
                return response()->json([
                    'success' => false,
                    'errors' => $e->errors(),
                    'message' => 'Please fix the validation errors'
                ], 422);
            }

            throw $e;
        }

        // ---------------- CREATE USER ----------------
        try {
            $user = new User([
                'name' => $validated['name'],
                'email' => $validated['email'],
                'country_code' => $validated['country_code'],
                'phone' => preg_replace('/\D/', '', $validated['phone']),
            ]);
            $user->password = $validated['password'];
            $user->setTraccarPlainPasswordForNextSave($validated['password']);
            $user->save();

            Log::info('User created successfully', ['user_id' => $user->id, 'email' => $user->email]);

        } catch (\Exception $e) {
            Log::error('User creation failed', [
                'error' => $e->getMessage(),
                'email' => $validated['email']
            ]);

            if ($request->wantsJson() || $request->ajax()) {
                return response()->json([
                    'success' => false,
                    'message' => 'Failed to create user account. Please try again.'
                ], 500);
            }

            return back()->withErrors([
                'email' => 'Failed to create account. Please try again.'
            ])->withInput();
        }


        activity()
            ->causedBy($user)
            ->withProperties([
                'type' => 'registration_success',
                'recaptcha_score' => $data['score'],
                'ip_address' => $request->ip(),
                'user_agent' => $request->userAgent(),
            ])
            ->log('New user registered');

        Auth::login($user);

        if ($request->wantsJson() || $request->ajax()) {
            return response()->json([
                'success' => true,
                'message' => 'Registration successful!',
                'redirect' => route('dashboard'),
                'user_email' => $user->email,
            ]);
        }

        return redirect()->route('dashboard')
            ->with('success', 'Registration successful! Welcome aboard.');
    }
}
