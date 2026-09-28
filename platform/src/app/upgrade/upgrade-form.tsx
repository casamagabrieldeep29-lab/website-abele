"use client";

import { useState } from "react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import type { PaymentMethodKey } from "@/lib/payment-methods";
import { submitPaymentRequest } from "./actions";

export function UpgradeForm({ defaultMethod }: { defaultMethod: PaymentMethodKey }) {
  const [method, setMethod] = useState<PaymentMethodKey>(defaultMethod);
  const [fileName, setFileName] = useState<string | null>(null);
  const [pending, setPending] = useState(false);

  return (
    <form
      action={submitPaymentRequest}
      onSubmit={() => setPending(true)}
      className="space-y-4 rounded-lg border border-border bg-card p-4"
    >
      <div className="space-y-2">
        <Label htmlFor="method">Which one did you pay with?</Label>
        <select
          id="method"
          name="method"
          value={method}
          onChange={(e) => setMethod(e.target.value as PaymentMethodKey)}
          className="w-full rounded-md border border-border bg-background px-3 py-2 text-sm"
        >
          <option value="gcash">GCash</option>
          <option value="maya">Maya</option>
          <option value="landbank">Landbank</option>
        </select>
      </div>

      <div className="space-y-2">
        <Label htmlFor="referenceNumber">Reference / transaction number</Label>
        <Input id="referenceNumber" name="referenceNumber" required placeholder="e.g. 1234567890123" />
      </div>

      <div className="space-y-2">
        <Label htmlFor="payerName">Your name on the payment (optional)</Label>
        <Input id="payerName" name="payerName" placeholder="If different from your account name" />
      </div>

      <div className="space-y-2">
        <Label htmlFor="receipt">Receipt screenshot</Label>
        <input
          id="receipt"
          name="receipt"
          type="file"
          accept="image/*"
          required
          onChange={(e) => setFileName(e.target.files?.[0]?.name ?? null)}
          className="block w-full text-sm text-muted-foreground file:mr-3 file:rounded-md file:border file:border-border file:bg-secondary file:px-3 file:py-1.5 file:text-sm file:font-medium file:text-secondary-foreground"
        />
        {fileName && <p className="text-xs text-muted-foreground">Selected: {fileName}</p>}
        <p className="text-xs text-muted-foreground">
          Must clearly show the reference number above and the recipient&apos;s name — we&apos;ll check it
          automatically and approve you instantly if it matches, or verify it by hand within a day.
        </p>
      </div>

      <Button type="submit" disabled={pending} className="w-full">
        {pending ? "Submitting…" : "Submit payment"}
      </Button>
    </form>
  );
}
