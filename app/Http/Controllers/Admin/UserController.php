<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\User;
use App\Services\AdminAuditService;
use Illuminate\Http\Request;
class UserController extends Controller
{
    public function __construct(
        private AdminAuditService $audit,
    ) {}

    public function index(Request $request)
    {
        $q = User::query();

        if ($search = $request->query('q')) {
            $q->where(function ($w) use ($search) {
                $w->where('name', 'like', "%{$search}%")
                    ->orWhere('email', 'like', "%{$search}%");
            });
        }

        $users = $q->orderByDesc('id')->paginate(15)->withQueryString();

        return view('admin.users.index', compact('users'));
    }

    public function create()
    {
        return view('admin.users.create');
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'name' => 'required|string|max:120',
            'email' => 'required|email|unique:tc_users,email',
            'password' => 'required|min:6',
            'role' => 'required|in:admin,user',
            'status' => 'required|in:active,inactive',
            'country_code' => 'nullable|string|max:6',
            'phone' => 'nullable|string|max:20',
        ]);

        $plainPassword = $request->input('password');
        unset($data['password']);
        $data['country_code'] = $data['country_code'] ?? '';
        $data['phone'] = $data['phone'] ?? '';

        $user = new User($data);
        $user->password = $plainPassword;
        $user->setTraccarPlainPasswordForNextSave($plainPassword);
        $user->save();

        $this->audit->logCreated($user, "user {$user->email}", [
            'role' => $user->role,
            'status' => $user->status,
        ]);

        return redirect()->route('admin.users.index')->with('success', 'User created successfully.');
    }

    public function edit(User $user)
    {
        return view('admin.users.edit', compact('user'));
    }

    public function update(Request $request, User $user)
    {
        $data = $request->validate([
            'name' => 'required|string|max:120',
            'email' => 'required|email|unique:tc_users,email,' . $user->id,
            'password' => 'nullable|min:6',
            'role' => 'required|in:admin,user',
            'status' => 'required|in:active,inactive',
            'country_code' => 'nullable|string|max:6',
            'phone' => 'nullable|string|max:20',
        ]);

        $data['country_code'] = $data['country_code'] ?? '';
        $data['phone'] = $data['phone'] ?? '';

        if ($request->filled('password')) {
            $user->setTraccarPlainPasswordForNextSave($request->input('password'));
            $user->password = $request->input('password');
        }

        $user->fill($data);
        $user->save();

        $this->audit->logUpdated($user, "user {$user->email}", [
            'role' => $user->role,
            'status' => $user->status,
        ]);

        return redirect()->route('admin.users.index')->with('success', 'User updated successfully.');
    }

    public function destroy(User $user)
    {
        if ($user->email === 'admin@demo.test') {
            return back()->with('error', 'Default admin cannot be deleted.');
        }

        $email = $user->email;

        $user->delete();

        $this->audit->log('deleted', "Deleted user {$email}");

        return redirect()->route('admin.users.index')->with('success', 'User deleted successfully.');
    }

    public function toggleStatus(Request $request, User $user)
    {
        if ($user->id === $request->user()->id) {
            return response()->json([
                'success' => false,
                'message' => 'You cannot change your own account status here.',
            ], 422);
        }

        if ($user->email === 'admin@demo.test') {
            return response()->json([
                'success' => false,
                'message' => 'The default admin account cannot be deactivated.',
            ], 422);
        }

        $validated = $request->validate([
            'status' => 'required|in:active,inactive',
        ]);

        $user->update(['status' => $validated['status']]);

        $label = $validated['status'] === 'active' ? 'Active' : 'Inactive';

        $this->audit->logUpdated($user, "user {$user->email} status", [
            'status' => $user->status,
        ]);

        return response()->json([
            'success' => true,
            'status' => $user->status,
            'label' => $label,
            'message' => "User account is now {$label}.",
        ]);
    }
}
