<?php

namespace App\Http\Controllers\Api\Mobile;

use App\Http\Controllers\Controller;
use App\Http\Concerns\RespondsWithMobileJson;
use App\Services\Mobile\MobileEntitlementService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Log;

class ProfileController extends Controller
{
    use RespondsWithMobileJson;

    public function __construct(
        private MobileEntitlementService $entitlement,
    ) {}

    public function show(Request $request)
    {
        $user = $request->user();

        return $this->mobileSuccess([
            'user' => [
                'id' => $user->id,
                'name' => $user->name,
                'email' => $user->email,
                'phone' => $user->phone,
                'country_code' => $user->country_code,
                'status' => $user->status ?? 'active',
            ],
            'permissions' => $this->entitlement->permissionsFor($user),
            'subscription' => $this->entitlement->subscriptionSummaryForUser($user),
        ]);
    }

    public function update(Request $request)
    {
        $user = $request->user();

        $validated = $request->validate([
            'name' => 'required|string|max:150',
            'email' => 'required|email|unique:tc_users,email,' . $user->id,
            'phone' => 'nullable|string|max:20',
            'country_code' => 'nullable|string|max:5',
        ]);

        if (array_key_exists('country_code', $validated)) {
            $validated['country_code'] = $this->normalizeDialCode($validated['country_code']);
        }

        $user->fill($validated);
        $user->save();

        return $this->mobileSuccess([
            'user' => [
                'id' => $user->id,
                'name' => $user->name,
                'email' => $user->email,
                'phone' => $user->phone,
                'country_code' => $user->country_code,
            ],
            'message' => 'Profile updated successfully.',
        ]);
    }

    public function changePassword(Request $request)
    {
        $request->validate([
            'current_password' => 'required|string',
            'new_password' => 'required|string|min:6|confirmed',
        ]);

        $user = $request->user();

        $authPassword = $user->getAuthPassword();
        $checked = $authPassword !== '' && Hash::check($request->current_password, $authPassword);

        Log::info('mobile_change_password_check', [
            'user_id' => $user->id,
            'auth_password_len' => strlen($authPassword),
            'hash_check_ok' => $checked,
        ]);

        if (! $checked) {
            return $this->mobileError('Current password is incorrect', 422, 'invalid_password');
        }

        $user->password = Hash::make($request->new_password);
        $user->save();

        return $this->mobileSuccess(['message' => 'Password updated successfully.']);
    }

    private function normalizeDialCode(?string $value): ?string
    {
        if ($value === null) {
            return null;
        }

        $v = trim($value);
        if ($v === '') {
            return null;
        }

        // Accept "971" and normalize to "+971".
        if ($v[0] !== '+') {
            $v = '+' . $v;
        }

        // Keep only + and digits.
        $v = '+' . preg_replace('/\D+/', '', $v);

        // Safety limit (web uses maxlength 5 like +971, +966, +92).
        if (strlen($v) > 6) {
            $v = substr($v, 0, 6);
        }

        return $v;
    }
}
