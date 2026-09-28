"use client";

import { useActionState, useState } from "react";
import Link from "next/link";
import { CheckCircle2 } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import type { PaymentMethodInfo, PaymentMethodKey } from "@/lib/payment-methods";
import { submitSignup, type SignupSubmitResult } from "./actions";

const initialSubmitState: SignupSubmitResult = null;

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
  const [result, formAction, isPending] = useActionState(submitSignup, initialSubmitState);
  // Nothing is pre-selected — the 3 payment methods are the encouraged path
  // and deliberately aren't pre-highlighted as if one were already chosen.
  // No more "skip payment" option — every account must pay, upload a
  // reference number, and attach a receipt screenshot (Gabriel's explicit
  // "let's not have free trial. all must pay", 2026-09-28).
  const [intent, setIntent] = useState<PaymentMethodKey | null>(null);
  const [school, setSchool] = useState("");
  const [academicStatus, setAcademicStatus] = useState<AcademicStatus | "">("");
  const [fileName, setFileName] = useState<string | null>(null);

  const chosenMethod = intent ? paymentMethods.find((m) => m.key === intent) ?? null : null;

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
          <Input id="fullName" name="fullName" placeholder="e.g. Juan Dela Cruz" required autoComplete="name" />
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
          <Label htmlFor="email">Email address</Label>
          <Input
            id="email"
            name="email"
            type="email"
            placeholder="you@example.com"
            required
            autoComplete="email"
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
          />
        </div>

        {chosenMethod && (
          <>
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
          </>
        )}

        {result?.kind === "error" && (
          <p className="text-sm text-destructive">{result.message}</p>
        )}

        <Button type="submit" className="w-full" disabled={isPending || !chosenMethod}>
          {isPending ? "Setting up…" : chosenMethod ? "I've paid — submit and continue" : "Pick a payment method above"}
        </Button>

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
