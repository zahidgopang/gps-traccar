<?php
// app/Http/Requests/ContactFormRequest.php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class ContactFormRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'name' => 'required|string|max:100',
            'email' => 'required|email|max:100',
            'phone' => 'nullable|string|max:20',
            'company' => 'nullable|string|max:100',
            'subject' => 'required|string|max:200',
            'message' => 'required|string|min:20|max:5000',
            'honeypot' => 'nullable|string', // Hidden field for bots
        ];
    }

    public function messages(): array
    {
        return [
            'name.required' => 'Please enter your name',
            'name.max' => 'Name cannot exceed 100 characters',
            'email.required' => 'Please enter your email address',
            'email.email' => 'Please enter a valid email address',
            'email.max' => 'Email cannot exceed 100 characters',
            'phone.max' => 'Phone number cannot exceed 20 characters',
            'company.max' => 'Company name cannot exceed 100 characters',
            'subject.required' => 'Please enter a subject',
            'subject.max' => 'Subject cannot exceed 200 characters',
            'message.required' => 'Please enter your message',
            'message.min' => 'Your message should be at least 20 characters',
            'message.max' => 'Message cannot exceed 5000 characters',
        ];
    }

    public function prepareForValidation()
    {
        // Store additional metadata
        $this->merge([
            'ip_address' => $this->ip(),
            'user_agent' => $this->userAgent(),
        ]);
    }

    /**
     * Additional validation rules
     */
    public function withValidator($validator)
    {
        $validator->after(function ($validator) {
            // Validate no URLs in name (common spam tactic)
            if (preg_match('/http|www|\.com|\.net|\.org/i', $this->name)) {
                $validator->errors()->add('name', 'Names cannot contain URLs or website addresses.');
            }

            // Validate email format
            if (!filter_var($this->email, FILTER_VALIDATE_EMAIL)) {
                $validator->errors()->add('email', 'Please enter a valid email address.');
            }

            // Validate message doesn't contain too many links
            $linkCount = preg_match_all('/https?:\/\/[^\s]+/', $this->message);
            if ($linkCount > 3) {
                $validator->errors()->add('message', 'Message contains too many links. Please reduce to 3 or fewer.');
            }
        });
    }

    private function validateNoSpamKeywords($validator)
    {
        $spamKeywords = ['viagra', 'casino', 'lottery', 'xxx', 'porn'];
        $message = strtolower($this->message);

        foreach ($spamKeywords as $keyword) {
            if (str_contains($message, $keyword)) {
                $validator->errors()->add('message', 'Your message contains suspicious content.');
                break;
            }
        }
    }

    private function validateNoUrlsInName($validator)
    {
        if (preg_match('/http|www|\.com|\.net/i', $this->name)) {
            $validator->errors()->add('name', 'Names cannot contain URLs.');
        }
    }

    private function validateNoExcessiveCaps($validator)
    {
        $capsRatio = strlen(preg_replace('/[^A-Z]/', '', $this->message)) / max(strlen($this->message), 1);
        if ($capsRatio > 0.5 && strlen($this->message) > 10) {
            $validator->errors()->add('message', 'Please avoid excessive use of capital letters.');
        }
    }
}
