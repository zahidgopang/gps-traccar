<?php

namespace App\Services\Billing;

use App\Enums\BillingInvoiceType;
use App\Enums\BillingLineType;
use App\Models\Device;
use App\Models\Subscription;
use App\Models\SubscriptionPlan;
use App\Models\User;
use App\Services\Inventory\InventoryService;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;

class SubscriptionBillingService
{
    public function __construct(
        private BillingInvoiceService $invoices,
        private DeviceCostResolver $deviceCosts,
        private InventoryService $inventory,
    ) {}

    /**
     * @param  array{subscription_plan_id:int,selling_price:float,device_selling_price?:float,client_id:int}  $billing
     */
    public function provisionForSubscription(Subscription $subscription, array $billing, ?User $actor = null): Subscription
    {
        return DB::transaction(function () use ($subscription, $billing, $actor) {
            $plan = SubscriptionPlan::query()->findOrFail($billing['subscription_plan_id']);
            $device = $subscription->device ?? Device::query()->find($subscription->device_id);
            $clientId = (int) $billing['client_id'];

            $companyPrice = (float) $plan->company_price;
            $sellingPrice = (float) $billing['selling_price'];
            $deviceCost = $device
                ? $this->deviceCosts->resolveForClientDevice($device, $clientId)
                : 0.0;
            $deviceSelling = (float) ($billing['device_selling_price'] ?? $deviceCost);

            $subscription->update([
                'subscription_plan_id' => $plan->id,
                'plan' => $plan->name,
                'client_id' => $clientId,
                'company_price' => $companyPrice,
                'selling_price' => $sellingPrice,
                'device_unit_cost' => $deviceCost,
                'device_selling_price' => $deviceSelling,
            ]);

            $platformInvoice = $this->invoices->createInvoice(
                BillingInvoiceType::Platform,
                [[
                    'line_type' => BillingLineType::Subscription->value,
                    'description' => "Plan: {$plan->name} — Device #{$subscription->device_id}",
                    'unit_cost' => $companyPrice,
                    'unit_price' => $companyPrice,
                    'reference_type' => Subscription::class,
                    'reference_id' => $subscription->id,
                ]],
                clientId: $clientId,
                subscriptionId: $subscription->id,
                actor: $actor,
            );

            // End-user invoice: subscription selling price only (device stock invoiced separately).
            $clientInvoice = $this->invoices->createInvoice(
                BillingInvoiceType::Client,
                [[
                    'line_type' => BillingLineType::Subscription->value,
                    'description' => "Subscription: {$plan->name}",
                    'unit_cost' => $companyPrice,
                    'unit_price' => $sellingPrice,
                    'reference_type' => Subscription::class,
                    'reference_id' => $subscription->id,
                ]],
                clientId: $clientId,
                userId: $subscription->user_id,
                subscriptionId: $subscription->id,
                actor: $actor,
            );

            $subscription->update([
                'platform_invoice_id' => $platformInvoice->id,
                'client_invoice_id' => $clientInvoice->id,
            ]);

            if ($subscription->status === 'active' && $device) {
                $this->ensureDeviceStockCommitted($subscription, $device, $clientId, $actor?->id);
            }

            return $subscription->fresh(['platformInvoice', 'clientInvoice', 'subscriptionPlan']);
        });
    }

    public function handleStatusChange(Subscription $subscription, string $previousStatus, ?User $actor = null): void
    {
        if ($subscription->status === 'cancelled' && $previousStatus !== 'cancelled') {
            $this->cancelBilling($subscription, $actor);
            $this->returnDeviceStock($subscription, $actor?->id);
        }
    }

    public function cancelBilling(Subscription $subscription, ?User $actor = null): void
    {
        if ($subscription->platformInvoice) {
            $this->invoices->cancelInvoice($subscription->platformInvoice, $actor);
        }
        if ($subscription->clientInvoice) {
            $this->invoices->cancelInvoice($subscription->clientInvoice, $actor);
        }
    }

    private function ensureDeviceStockCommitted(Subscription $subscription, Device $device, int $clientId, ?int $actorId): void
    {
        $deviceType = Device::canonicalDeviceType($device->device_type ?? $device->category ?? '') ?? 'personal';

        try {
            $this->inventory->consumeForInstall($clientId, $deviceType, (int) $device->id, $actorId);
        } catch (ValidationException) {
            // Already consumed at install time.
        }
    }

    private function returnDeviceStock(Subscription $subscription, ?int $actorId): void
    {
        $device = $subscription->device;
        if (! $device || ! $subscription->client_id) {
            return;
        }

        $deviceType = Device::canonicalDeviceType($device->device_type ?? $device->category ?? '') ?? 'personal';
        $this->inventory->returnFromSubscriptionCancel(
            (int) $subscription->client_id,
            $deviceType,
            (int) $device->id,
            $actorId
        );
    }
}
