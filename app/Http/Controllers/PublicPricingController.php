<?php

namespace App\Http\Controllers;

use App\Models\SubscriptionPlan;

class PublicPricingController extends Controller
{
    public function __invoke()
    {
        $plans = SubscriptionPlan::query()
            ->publicActive()
            ->orderBy('billing_cycle')
            ->orderBy('sort_order')
            ->orderBy('name')
            ->get();

        return view('pricing', compact('plans'));
    }
}
