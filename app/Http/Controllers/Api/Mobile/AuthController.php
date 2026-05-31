<?php

namespace App\Http\Controllers\Api\Mobile;

use App\Http\Controllers\Controller;
use App\Http\Concerns\PresentsMobileUser;
use App\Http\Concerns\RespondsWithMobileJson;
use App\Models\User;
use App\Services\Mobile\MobileDevicePresenter;
use App\Services\Mobile\MobileEntitlementService;
use App\Services\Tracking\DevicePositionLoader;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Log;
class AuthController extends Controller
{
    use PresentsMobileUser;
    use RespondsWithMobileJson;

    public function __construct(
        private MobileEntitlementService $entitlement,
        private MobileDevicePresenter $presenter,
        private DevicePositionLoader $positionLoader,
    ) {}

    public function login(Request $request)
    {
        $request->validate([
            'email' => 'required|email',
            'password' => 'required|string',
            'device_name' => 'nullable|string|max:255',
            'remember' => 'sometimes|boolean',
        ]);

        $remember = $request->boolean('remember', true);

        Log::info('mobile_login_attempt', [
            'email' => (string) $request->email,
            'device_name' => (string) $request->input('device_name', ''),
            'ip' => $request->ip(),
            'ua' => (string) $request->userAgent(),
        ]);

        $user = User::query()->where('email', $request->email)->first();

        if (! $user) {
            Log::info('mobile_login_failed', ['reason' => 'no_user', 'email' => (string) $request->email]);
            return $this->mobileError('Invalid credentials', 401, 'invalid_credentials');
        }

        $authPassword = $user->getAuthPassword();
        $checked = $authPassword !== '' && Hash::check($request->password, $authPassword);

        Log::info('mobile_login_password_check', [
            'user_id' => $user->id,
            'email' => (string) $user->email,
            'auth_password_len' => strlen($authPassword),
            'hash_check_ok' => $checked,
        ]);

        if (! $checked) {
            return $this->mobileError('Invalid credentials', 401, 'invalid_credentials');
        }

        if (! $this->entitlement->isEndUser($user)) {
            return $this->mobileError('This API is only available for end-user accounts.', 403, 'invalid_role');
        }

        $access = $this->entitlement->evaluate($user);

        if (! $access['allowed']) {
            $status = match ($access['code']) {
                MobileEntitlementService::CODE_ACCOUNT_INACTIVE => 403,
                default => 402,
            };

            return $this->mobileError($access['message'], $status, $access['code']);
        }

        $expiresAt = $remember
            ? null
            : now()->addHours((int) config('mobile_auth.session_hours', 12));

        $tokenResult = $user->createToken(
            $request->input('device_name', 'mobile-app'),
            ['*'],
            $expiresAt,
        );

        $token = $tokenResult->plainTextToken;

        $devices = $this->entitlement->accessibleDevices($user);
        $this->positionLoader->attachLatestToMany($devices);

        return $this->mobileSuccess([
            'token' => $token,
            'token_type' => 'Bearer',
            'remember' => $remember,
            'expires_at' => $tokenResult->accessToken->expires_at?->toIso8601String(),
            'user' => $this->mobileUserPayload($user),
            'permissions' => $this->entitlement->permissionsFor($user),
            'accessible_devices' => $devices->map(fn ($d) => $this->presenter->listItem($d))->values(),
            'subscription' => $this->entitlement->subscriptionSummaryForUser($user),
        ]);
    }

    public function logout(Request $request)
    {
        $request->user()?->currentAccessToken()?->delete();

        return $this->mobileSuccess(['message' => 'Logged out']);
    }
}
