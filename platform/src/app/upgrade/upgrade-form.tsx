"use client";

import { useActionState, useEffect, useState } from "react";
import { useRouter } from "next/navigation";
import { Loader2 } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import type { PaymentMethodKey } from "@/lib/payment-methods";
import { submitPaymentRequest, type SubmitPaymentResult } from "./actions";

const initialState: SubmitPaymentResult = null;

// Deliberately not instant (Gabriel's explicit "autoapproval shouldnt be
// flash like 1 second. it should take 20 seconds to 1 minutes", 2026-09-28)
// — the real check already finished server-side by the time `result` comes
// back; this just paces how soon it's revealed.
const MIN_VERIFY_DELAY_MS = 20_000;
const MAX_VERIFY_DELAY_MS = 60_000;

export function UpgradeForm({ defaultMethod }: { defaultMethod: PaymentMethodKey }) {
  const router = useRouter();
  const [method, setMethod] = useState<PaymentMethodKey>(defaultMethod);
  const [fileName, setFileName] = useState<string | null>(null);
  const [result, formAction, isPending] = useActionState(submitPaymentRequest, initialState);
  // Derived from `result`, not its own setState-in-effect -- the effect
  // below only owns the side effect (the delayed navigation), not state
  // that's already computable from render inputs.
  const verifying = Boolean(result?.ok);

  useEffect(() => {
    if (!result?.ok) return;
    const delayMs = MIN_VERIFY_DELAY_MS + Math.random() * (MAX_VERIFY_DELAY_MS - MIN_VERIFY_DELAY_MS);
    const timer = setTimeout(() => {
      router.push(result.autoApproved ? "/upgrade?approved=1" : "/upgrade?submitted=1");
    }, delayMs);
    return () => clearTimeout(timer);
  }, [result, router]);

  const busy = isPending || verifying;

  return (
    <form action={formAction} className="space-y-4 rounded-lg border border-border bg-card p-4">
      <div className="space-y-2">
        <Label htmlFor="method">Which one did you pay with?</Label>
        <select
          id="method"
          name="method"
          value={method}
          onChange={(e) => setMethod(e.target.value as PaymentMethodKey)}
          disabled={busy}
          className="w-full rounded-md border border-border bg-background px-3 py-2 text-sm"
        >
          <option value="gcash">GCash</option>
          <option value="maya">Maya</option>
          <option value="landbank">Landbank</option>
        </select>
      </div>

      <div className="space-y-2">
        <Label htmlFor="referenceNumber">Reference / transaction number</Label>
        <Input id="referenceNumber" name="referenceNumber" required disabled={busy} placeholder="e.g. 1234567890123" />
      </div>

      <div className="space-y-2">
        <Label htmlFor="payerName">Your name on the payment (optional)</Label>
        <Input id="payerName" name="payerName" disabled={busy} placeholder="If different from your account name" />
      </div>

      <div className="space-y-2">
        <Label htmlFor="receipt">Receipt screenshot</Label>
        <input
          id="receipt"
          name="receipt"
          type="file"
          accept="image/*"
          required
          disabled={busy}
          onChange={(e) => setFileName(e.target.files?.[0]?.name ?? null)}
          className="block w-full text-sm text-muted-foreground file:mr-3 file:rounded-md file:border file:border-border file:bg-secondary file:px-3 file:py-1.5 file:text-sm file:font-medium file:text-secondary-foreground disabled:opacity-60"
        />
        {fileName && <p className="text-xs text-muted-foreground">Selected: {fileName}</p>}
        <p className="text-xs text-muted-foreground">
          Must clearly show the reference number above and the recipient&apos;s name — we&apos;ll check it
          automatically and approve you instantly if it matches, or verify it by hand within a day.
        </p>
      </div>

      {result && !result.ok && (
        <p className="text-sm text-destructive">
          {result.error === "missing-fields"
            ? "Pick a payment method, enter your reference number, and attach a receipt screenshot."
            : "Couldn't submit that — please try again."}
        </p>
      )}

      <Button type="submit" disabled={busy} className="w-full">
        {busy ? (
          <span className="flex items-center justify-center gap-2">
            <Loader2 className="size-4 animate-spin" />
            {verifying ? "Verifying your receipt…" : "Submitting…"}
          </span>
        ) : (
          "Submit payment"
        )}
      </Button>

      {verifying && (
        <p className="rounded-md border border-primary/30 bg-primary/5 px-3 py-2 text-center text-sm font-medium text-primary">
          Please wait — do not close or exit this tab. This can take a few seconds to a minute.
        </p>
      )}
    </form>
  );
}
