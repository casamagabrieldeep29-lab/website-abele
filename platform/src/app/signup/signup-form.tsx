"use client";

import { useActionState, useEffect, useState } from "react";
import { useRouter } from "next/navigation";
import Link from "next/link";
import { CheckCircle2, Loader2 } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import type { PaymentMethodInfo, PaymentMethodKey } from "@/lib/payment-methods";
import { submitSignup, type SignupSubmitResult } from "./actions";

const initialSubmitState: SignupSubmitResult = null;

// Same reasoning as upgrade-form.tsx's identical constants: deliberately not
// instant (Gabriel's explicit "autoapproval shouldnt be flash like 1
// second. it should take 20 seconds to 1 minutes", 2026-09-28).
const MIN_VERIFY_DELAY_MS = 20_000;
const MAX_VERIFY_DELAY_MS = 60_000;

const METHODS: { key: PaymentMethodKey; label: string }[] = [
  { key: "gcash", label: "GCash" },
  { key: "maya", label: "Maya" },
  { key: "landbank", label: "Landbank" },
];

type AcademicStatus = "student" | "reviewee";

/** The real GCash/Maya/Landbank account to pay, shown as soon as a method is chosen. Same account data /upgrade already shows. */
function PaymentDetails({ method }: { method: PaymentMethodInfo }) {
  return (
    <div className="rounded-lg border border-border bg-background p-4 text-left">
      <p className="text-sm font-semibold">{method.label}</p>
      <p className="mt-1 text-sm">{method.accountName}</p>
      <p className="font-mono text-sm">{method.accountNumber}</p>
    </div>
  );
}

export function SignupForm({ paymentMethods }: { paymentMethods: PaymentMethodInfo[] }) {
  const router = useRouter();
  const [result, formAction, isPending] = useActionState(submitSignup, initialSubmitState);
  // Nothing is pre-selected — the 3 payment methods are the encouraged path
  // and deliberately aren't pre-highlighted as if one were already chosen.
  // No more "skip payment" option — every account must pay, upload a
  // reference number, and attach a receipt screenshot (Gabriel's explicit
  // "let's not have free trial. all must pay", 2026-09-28).
  const [intent, setIntent] = useState<PaymentMethodKey | null>(null);
  const [school, setSchool] = useState("");
  const [academicStatus, setAcademicStatus] = useState<AcademicStatus | "">("");
  const [address, setAddress] = useState("");
  const [fileName, setFileName] = useState<string | null>(null);
  // Derived from `result`, not its own setState-in-effect -- the effect
  // below only owns the side effect (the delayed navigation), not state
  // that's already computable from render inputs.
  const verifying = result?.kind === "payment_result";

  const chosenMethod = intent ? paymentMethods.find((m) => m.key === intent) ?? null : null;

  useEffect(() => {
    if (result?.kind !== "payment_result") return;
    const delayMs = MIN_VERIFY_DELAY_MS + Math.random() * (MAX_VERIFY_DELAY_MS - MIN_VERIFY_DELAY_MS);
    const timer = setTimeout(() => {
      router.push(result.autoApproved ? "/upgrade?approved=1" : "/upgrade?submitted=1");
    }, delayMs);
    return () => clearTimeout(timer);
  }, [result, router]);

  const busy = isPending || verifying;

  return (
    <div className="space-y-5">
      <div>
        <p className="text-sm font-semibold">How would you like to pay?</p>
        <div className="mt-3 space-y-2">
          {METHODS.map((m) => (
            <button
              key={m.key}
              type="button"
              onClick={() => setIntent(m.key)}
              className={`flex w-full items-center justify-between rounded-lg border px-3.5 py-2.5 text-left text-sm transition-colors ${
                intent === m.key
                  ? "border-primary bg-primary/5 font-medium text-primary"
                  : "border-border hover:bg-muted"
              }`}
            >
              {m.label}
              {intent === m.key && <CheckCircle2 className="size-4 shrink-0" />}
            </button>
          ))}
        </div>
        {chosenMethod && <div className="mt-3"><PaymentDetails method={chosenMethod} /></div>}
      </div>

      <form action={formAction} className="space-y-4">
        <input type="hidden" name="intent" value={intent ?? ""} />
        {chosenMethod && <input type="hidden" name="method" value={chosenMethod.key} />}

        <div className="space-y-2">
          <Label htmlFor="fullName">Full name</Label>
          <Input id="fullName" name="fullName" placeholder="e.g. Juan Dela Cruz" required autoComplete="name" disabled={busy} />
        </div>

        <div className="space-y-2">
          <Label htmlFor="school">School</Label>
          <Input
            id="school"
            name="school"
            placeholder="e.g. Central Luzon State University"
            value={school}
            onChange={(e) => setSchool(e.target.value)}
            autoComplete="organization"
            disabled={busy}
          />
        </div>

        <div className="space-y-2">
          <Label>Status</Label>
          <div className="grid grid-cols-2 gap-2">
            {(
              [
                { key: "student", label: "Still studying" },
                { key: "reviewee", label: "Reviewing for the boards" },
              ] as const
            ).map((opt) => (
              <button
                key={opt.key}
                type="button"
                onClick={() => setAcademicStatus(opt.key)}
                disabled={busy}
                className={`rounded-lg border px-3 py-2 text-xs font-medium transition-colors ${
                  academicStatus === opt.key
                    ? "border-primary bg-primary/5 text-primary"
                    : "border-border text-muted-foreground hover:bg-muted"
                }`}
              >
                {opt.label}
              </button>
            ))}
          </div>
          <input type="hidden" name="academicStatus" value={academicStatus} />
        </div>

        <div className="space-y-2">
          <Label htmlFor="address">Address</Label>
          <Input
            id="address"
            name="address"
            placeholder="e.g. Brgy. San Isidro, General Santos City"
            value={address}
            onChange={(e) => setAddress(e.target.value)}
            autoComplete="street-address"
            disabled={busy}
          />
        </div>

        <div className="space-y-2">
          <Label htmlFor="email">Email address</Label>
          <Input
            id="email"
            name="email"
            type="email"
            placeholder="you@example.com"
            required
            autoComplete="email"
            disabled={busy}
          />
        </div>

        <div className="space-y-2">
          <Label htmlFor="password">Password</Label>
          <Input
            id="password"
            name="password"
            type="password"
            placeholder="At least 8 characters — needed to sign you in instantly"
            autoComplete="new-password"
            minLength={8}
            required
            disabled={busy}
          />
        </div>

        {chosenMethod && (
          <>
            <div className="space-y-2">
              <Label htmlFor="referenceNumber">Reference / transaction number</Label>
              <Input id="referenceNumber" name="referenceNumber" required placeholder="e.g. 1234567890123" disabled={busy} />
              <p className="text-xs text-muted-foreground">
                Type it exactly as shown on your receipt (same spacing and digits) for the fastest approval.
              </p>
            </div>

            <div className="space-y-2">
              <Label htmlFor="payerName">Your name on the payment (optional)</Label>
              <Input id="payerName" name="payerName" placeholder="If different from your account name" disabled={busy} />
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
          </>
        )}

        {result?.kind === "error" && (
          <p className="text-sm text-destructive">{result.message}</p>
        )}

        <Button type="submit" className="w-full" disabled={busy || !chosenMethod}>
          {busy ? (
            <span className="flex items-center justify-center gap-2">
              <Loader2 className="size-4 animate-spin" />
              {verifying ? "Verifying your receipt…" : "Setting up…"}
            </span>
          ) : chosenMethod ? (
            "I've paid — submit and continue"
          ) : (
            "Pick a payment method above"
          )}
        </Button>

        {verifying && (
          <p className="rounded-md border border-primary/30 bg-primary/5 px-3 py-2 text-center text-sm font-medium text-primary">
            Please wait — do not close or exit this tab. This can take a few seconds to a minute.
          </p>
        )}

        <p className="text-center text-xs text-muted-foreground">
          By signing up, you agree to our{" "}
          <Link href="/privacy" className="text-primary hover:underline">
            Privacy Policy
          </Link>
          .
        </p>

        <p className="text-center text-xs text-muted-foreground">
          Already have an account?{" "}
          <Link href="/login" className="text-primary hover:underline">
            Sign in
          </Link>
        </p>
      </form>
    </div>
  );
}
