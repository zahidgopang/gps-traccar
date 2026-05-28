@extends('user.layout_user')

@section('title', 'Change Password — FalconEyeGPS')

@push('styles')
    <style>
        .password-header {
            display: flex;
            align-items: center;
            margin-bottom: 2rem;
            padding-bottom: 1.5rem;
            border-bottom: 1px solid rgba(0, 0, 0, 0.1);
        }

        .password-icon {
            width: 64px;
            height: 64px;
            background: linear-gradient(135deg, #F59E0B, #D97706);
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.5rem;
            margin-right: 1.5rem;
            box-shadow: 0 8px 25px rgba(245, 158, 11, 0.3);
        }

        .password-header h4 {
            color: var(--text-primary);
            font-weight: 700;
            margin-bottom: 0.25rem;
        }

        .password-header p {
            color: var(--text-secondary);
            margin-bottom: 0;
        }

        .password-card {
            background: #fff;
            border-radius: 20px;
            padding: 2.5rem;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.08);
            border: 1px solid rgba(0, 0, 0, 0.05);
            max-width: 600px;
            margin: 0 auto;
            transition: all 0.3s ease;
        }

        .password-card:hover {
            box-shadow: 0 12px 40px rgba(0, 0, 0, 0.12);
            transform: translateY(-2px);
        }

        .password-strength {
            margin-top: 0.5rem;
        }

        .strength-meter {
            height: 6px;
            background: #e9ecef;
            border-radius: 3px;
            margin-bottom: 0.5rem;
            overflow: hidden;
        }

        .strength-fill {
            height: 100%;
            width: 0%;
            border-radius: 3px;
            transition: all 0.3s ease;
        }

        .strength-requirements {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .strength-requirements li {
            display: flex;
            align-items: center;
            margin-bottom: 0.5rem;
            font-size: 0.875rem;
            color: var(--text-secondary);
        }

        .strength-requirements li i {
            margin-right: 0.5rem;
            font-size: 0.75rem;
        }

        .requirement-met {
            color: var(--success);
        }

        .requirement-not-met {
            color: var(--text-secondary);
        }

        .password-toggle {
            position: absolute;
            right: 1rem;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            color: var(--text-secondary);
            cursor: pointer;
            z-index: 10;
        }

        .password-input-group {
            position: relative;
        }

        .form-control-password {
            background: #fff;
            border: 2px solid rgba(0, 0, 0, 0.1);
            border-radius: 12px;
            padding: 0.75rem 1rem;
            padding-right: 3rem;
            color: var(--text-primary);
            transition: all 0.3s ease;
            width: 100%;
        }

        .form-control-password:focus {
            border-color: var(--primary-blue);
            box-shadow: 0 0 0 3px rgba(25, 118, 210, 0.1);
            background: #fff;
        }

        .form-control-password.is-invalid {
            border-color: var(--danger);
        }

        .form-control-password.is-valid {
            border-color: var(--success);
        }

        .invalid-feedback {
            display: flex;
            align-items: center;
            margin-top: 0.25rem;
            font-size: 0.875rem;
        }

        .password-hints {
            background: rgba(25, 118, 210, 0.05);
            border: 1px solid rgba(25, 118, 210, 0.1);
            border-radius: 12px;
            padding: 1.5rem;
            margin-top: 2rem;
        }

        .password-hints h6 {
            color: var(--text-primary);
            font-weight: 600;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
        }

        .password-hints h6 i {
            margin-right: 0.75rem;
            color: var(--primary-blue);
        }

        .password-hints ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .password-hints li {
            display: flex;
            align-items: flex-start;
            margin-bottom: 0.75rem;
            color: var(--text-secondary);
            font-size: 0.875rem;
        }

        .password-hints li i {
            margin-right: 0.75rem;
            color: var(--primary-blue);
            margin-top: 0.125rem;
        }

        .btn-update-password {
            background: linear-gradient(135deg, #F59E0B, #D97706);
            border: none;
            color: white;
            border-radius: 12px;
            padding: 0.875rem 2rem;
            font-weight: 600;
            font-size: 1rem;
            transition: all 0.3s ease;
            width: 100%;
            margin-top: 1.5rem;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .btn-update-password:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(245, 158, 11, 0.3);
            background: linear-gradient(135deg, #D97706, #B45309);
        }

        .btn-update-password:disabled {
            opacity: 0.6;
            cursor: not-allowed;
            transform: none;
            box-shadow: none;
        }

        .password-success {
            background: rgba(16, 185, 129, 0.1);
            border: 1px solid rgba(16, 185, 129, 0.2);
            border-radius: 12px;
            padding: 1.5rem;
            margin-bottom: 2rem;
        }

        .password-success .success-icon {
            width: 48px;
            height: 48px;
            background: var(--success);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.25rem;
            margin: 0 auto 1rem;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .password-card {
                padding: 1.5rem;
            }

            .password-header {
                flex-direction: column;
                text-align: center;
            }

            .password-icon {
                margin-right: 0;
                margin-bottom: 1rem;
            }

            .password-hints {
                padding: 1rem;
            }
        }

        @media (max-width: 576px) {
            .password-card {
                padding: 1.25rem;
            }

            .btn-update-password {
                padding: 0.75rem 1.5rem;
                font-size: 0.875rem;
            }
        }
    </style>
@endpush

@section('content')

    <div class="container dashboard-container">

        <!-- Header -->
        <div class="password-header">
            <div class="password-icon">
                <i class="fas fa-lock"></i>
            </div>
            <div>
                <h4>Change Password</h4>
                <p>Update your account password for enhanced security</p>
            </div>
        </div>

        <!-- Main Form Card -->
        <div class="password-card">
            <!-- Success Message -->
            @if(session('success'))
                <div class="password-success text-center">
                    <div class="success-icon">
                        <i class="fas fa-check"></i>
                    </div>
                    <h5 class="mb-2" style="color: var(--success);">Password Updated Successfully!</h5>
                    <p class="text-muted mb-0">Your password has been changed. Please use your new password for future logins.</p>
                </div>
            @endif

            <!-- Password Update Form -->
            <form method="POST" action="{{ route('user.password.update') }}" id="passwordForm">
                @csrf

                <!-- Current Password -->
                <div class="mb-4">
                    <label class="form-label fw-semibold">Current Password</label>
                    <div class="password-input-group">
                        <input type="password" name="current_password"
                               class="form-control-password @error('current_password') is-invalid @enderror"
                               placeholder="Enter your current password"
                               id="currentPassword"
                               required>
                        <button type="button" class="password-toggle" data-target="currentPassword">
                            <i class="fas fa-eye"></i>
                        </button>
                        @error('current_password')
                        <div class="invalid-feedback">
                            <i class="fas fa-exclamation-circle me-2"></i> {{ $message }}
                        </div>
                        @enderror
                    </div>
                </div>

                <!-- New Password -->
                <div class="mb-4">
                    <label class="form-label fw-semibold">New Password</label>
                    <div class="password-input-group">
                        <input type="password" name="new_password"
                               class="form-control-password @error('new_password') is-invalid @enderror"
                               placeholder="Enter your new password"
                               id="newPassword"
                               required>
                        <button type="button" class="password-toggle" data-target="newPassword">
                            <i class="fas fa-eye"></i>
                        </button>
                        @error('new_password')
                        <div class="invalid-feedback">
                            <i class="fas fa-exclamation-circle me-2"></i> {{ $message }}
                        </div>
                        @enderror
                    </div>

                    <!-- Password Strength Meter -->
                    <div class="password-strength">
                        <div class="strength-meter">
                            <div class="strength-fill" id="strengthFill"></div>
                        </div>
                        <ul class="strength-requirements" id="strengthRequirements">
                            <li id="reqLength">
                                <i class="fas fa-circle"></i> At least 8 characters
                            </li>
                            <li id="reqUppercase">
                                <i class="fas fa-circle"></i> One uppercase letter
                            </li>
                            <li id="reqLowercase">
                                <i class="fas fa-circle"></i> One lowercase letter
                            </li>
                            <li id="reqNumber">
                                <i class="fas fa-circle"></i> One number
                            </li>
                            <li id="reqSpecial">
                                <i class="fas fa-circle"></i> One special character
                            </li>
                        </ul>
                    </div>
                </div>

                <!-- Confirm New Password -->
                <div class="mb-4">
                    <label class="form-label fw-semibold">Confirm New Password</label>
                    <div class="password-input-group">
                        <input type="password" name="new_password_confirmation"
                               class="form-control-password"
                               placeholder="Re-enter your new password"
                               id="confirmPassword"
                               required>
                        <button type="button" class="password-toggle" data-target="confirmPassword">
                            <i class="fas fa-eye"></i>
                        </button>
                    </div>
                    <div class="mt-2" id="passwordMatch"></div>
                </div>

                <!-- Submit Button -->
                <button type="submit" class="btn-update-password" id="updateButton">
                    <i class="fas fa-check-circle me-2"></i> Update Password
                </button>
            </form>

            <!-- Password Hints -->
            <div class="password-hints">
                <h6><i class="fas fa-lightbulb"></i> Password Tips</h6>
                <ul>
                    <li>
                        <i class="fas fa-check"></i>
                        <div>Use a mix of uppercase and lowercase letters</div>
                    </li>
                    <li>
                        <i class="fas fa-check"></i>
                        <div>Include numbers and special characters (!@#$%^&*)</div>
                    </li>
                    <li>
                        <i class="fas fa-check"></i>
                        <div>Avoid using personal information like birthdays</div>
                    </li>
                    <li>
                        <i class="fas fa-check"></i>
                        <div>Don't reuse passwords from other accounts</div>
                    </li>
                    <li>
                        <i class="fas fa-check"></i>
                        <div>Consider using a password manager for strong, unique passwords</div>
                    </li>
                </ul>
            </div>
        </div>

    </div>

@endsection

@push('scripts')
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const passwordForm = document.getElementById('passwordForm');
            const newPasswordInput = document.getElementById('newPassword');
            const confirmPasswordInput = document.getElementById('confirmPassword');
            const updateButton = document.getElementById('updateButton');
            const strengthFill = document.getElementById('strengthFill');
            const strengthRequirements = document.getElementById('strengthRequirements');

            // Password toggle functionality
            document.querySelectorAll('.password-toggle').forEach(button => {
                button.addEventListener('click', function() {
                    const targetId = this.getAttribute('data-target');
                    const targetInput = document.getElementById(targetId);
                    const icon = this.querySelector('i');

                    if (targetInput.type === 'password') {
                        targetInput.type = 'text';
                        icon.classList.remove('fa-eye');
                        icon.classList.add('fa-eye-slash');
                    } else {
                        targetInput.type = 'password';
                        icon.classList.remove('fa-eye-slash');
                        icon.classList.add('fa-eye');
                    }
                });
            });

            // Password strength checker
            newPasswordInput.addEventListener('input', function() {
                const password = this.value;
                let strength = 0;

                // Check requirements
                const hasLength = password.length >= 8;
                const hasUppercase = /[A-Z]/.test(password);
                const hasLowercase = /[a-z]/.test(password);
                const hasNumber = /[0-9]/.test(password);
                const hasSpecial = /[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/.test(password);

                // Update requirement indicators
                updateRequirement('reqLength', hasLength);
                updateRequirement('reqUppercase', hasUppercase);
                updateRequirement('reqLowercase', hasLowercase);
                updateRequirement('reqNumber', hasNumber);
                updateRequirement('reqSpecial', hasSpecial);

                // Calculate strength
                if (hasLength) strength += 20;
                if (hasUppercase) strength += 20;
                if (hasLowercase) strength += 20;
                if (hasNumber) strength += 20;
                if (hasSpecial) strength += 20;

                // Update strength meter
                strengthFill.style.width = `${strength}%`;

                // Update strength color
                if (strength < 40) {
                    strengthFill.style.backgroundColor = 'var(--danger)';
                } else if (strength < 80) {
                    strengthFill.style.backgroundColor = 'var(--warning)';
                } else {
                    strengthFill.style.backgroundColor = 'var(--success)';
                }

                // Validate password match
                validatePasswordMatch();
            });

            // Confirm password validation
            confirmPasswordInput.addEventListener('input', validatePasswordMatch);

            function validatePasswordMatch() {
                const passwordMatchDiv = document.getElementById('passwordMatch');
                const newPassword = newPasswordInput.value;
                const confirmPassword = confirmPasswordInput.value;

                if (!confirmPassword) {
                    passwordMatchDiv.innerHTML = '';
                    return;
                }

                if (newPassword === confirmPassword) {
                    if (newPassword) {
                        passwordMatchDiv.innerHTML = `
                        <div class="text-success d-flex align-items-center">
                            <i class="fas fa-check-circle me-2"></i>
                            Passwords match
                        </div>
                    `;
                        confirmPasswordInput.classList.remove('is-invalid');
                        confirmPasswordInput.classList.add('is-valid');
                    }
                } else {
                    passwordMatchDiv.innerHTML = `
                    <div class="text-danger d-flex align-items-center">
                        <i class="fas fa-times-circle me-2"></i>
                        Passwords do not match
                    </div>
                `;
                    confirmPasswordInput.classList.remove('is-valid');
                    confirmPasswordInput.classList.add('is-invalid');
                }
            }

            function updateRequirement(elementId, isMet) {
                const element = document.getElementById(elementId);
                const icon = element.querySelector('i');

                if (isMet) {
                    element.classList.add('requirement-met');
                    element.classList.remove('requirement-not-met');
                    icon.classList.remove('fa-circle');
                    icon.classList.add('fa-check-circle');
                    icon.style.color = 'var(--success)';
                } else {
                    element.classList.remove('requirement-met');
                    element.classList.add('requirement-not-met');
                    icon.classList.remove('fa-check-circle');
                    icon.classList.add('fa-circle');
                    icon.style.color = 'var(--text-secondary)';
                }
            }

            // Form submission handling
            passwordForm.addEventListener('submit', function(e) {
                const newPassword = newPasswordInput.value;
                const confirmPassword = confirmPasswordInput.value;

                // Validate password match
                if (newPassword !== confirmPassword) {
                    e.preventDefault();
                    alert('Passwords do not match. Please confirm your new password.');
                    confirmPasswordInput.focus();
                    return;
                }

                // Validate password strength
                const hasLength = newPassword.length >= 8;
                const hasUppercase = /[A-Z]/.test(newPassword);
                const hasLowercase = /[a-z]/.test(newPassword);
                const hasNumber = /[0-9]/.test(newPassword);
                const hasSpecial = /[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/.test(newPassword);

                const strength = (hasLength + hasUppercase + hasLowercase + hasNumber + hasSpecial) * 20;

                if (strength < 60) {
                    e.preventDefault();
                    alert('Please use a stronger password. Your password should include uppercase letters, lowercase letters, numbers, and special characters.');
                    newPasswordInput.focus();
                    return;
                }

                // Show loading state
                const originalText = updateButton.innerHTML;
                updateButton.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i> Updating...';
                updateButton.disabled = true;

                // Re-enable button after 3 seconds (for demo)
                setTimeout(() => {
                    updateButton.innerHTML = originalText;
                    updateButton.disabled = false;
                }, 3000);
            });

            // Initial validation
            validatePasswordMatch();
        });
    </script>
@endpush
