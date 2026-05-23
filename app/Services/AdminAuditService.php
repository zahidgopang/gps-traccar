<?php

namespace App\Services;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Auth;

class AdminAuditService
{
    public const LOG_NAME = 'admin';

    public function log(
        string $action,
        string $description,
        ?Model $subject = null,
        array $properties = []
    ): void {
        $admin = Auth::user();

        $logger = activity(self::LOG_NAME)
            ->event($action)
            ->withProperties(array_merge([
                'ip' => request()?->ip(),
                'url' => request()?->fullUrl(),
                'method' => request()?->method(),
            ], $properties));

        if ($admin) {
            $logger->causedBy($admin);
        }

        if ($subject) {
            $logger->performedOn($subject);
        }

        $logger->log($description);
    }

    public function logCreated(Model $subject, string $label, array $extra = []): void
    {
        $this->log('created', "Created {$label}", $subject, $extra);
    }

    public function logUpdated(Model $subject, string $label, array $extra = []): void
    {
        $this->log('updated', "Updated {$label}", $subject, $extra);
    }

    public function logDeleted(Model $subject, string $label, array $extra = []): void
    {
        $this->log('deleted', "Deleted {$label}", $subject, $extra);
    }
}
