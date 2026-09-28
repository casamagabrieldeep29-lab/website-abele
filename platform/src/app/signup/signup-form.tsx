"use client";

import { useActionState, useState } from "react";
import Link from "next/link";
import { CheckCircle2 } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import type { PaymentMethodKey } from "@/lib/payment-methods";
import { submitSignup, verifySignupOtpCode, type SignupSubmitResult, type VerifySignupOtpResult } from "./actions";

const initialSubmitState: SignupSubmitResult = null;
const initialVerifyState: VerifySignupOtpResult = null;

const METHODS: { key: PaymentMethodKey; label: string }[] = [
  { key: "gcash", label: "GCash" },
  { key: "maya", label: "Maya" },
  { key: "landbank", label: "Landbank" },
];

type AcademicStatus = "student" | "reviewee";

function CodeForm({
  email,
  intent,
  school,
  academicStatus,
}: {
  email: string;
  intent: string;
  school: string;
  academicStatus: AcademicStatus | "";
}) {
  const [result, formAction, isPending] = useActionState(verifySignupOtpCode, initialVerifyState);

  return (
    <div className="rounded-lg border bg-card p-6">
      <p className="font-medium">Check your email</p>
      <p className="mt-1 text-sm text-muted-foreground">
        We&apos;ve sent a signup link to <strong>{email}</strong>. You can click it, or — if the
        link says it&apos;s expired (some email apps open links automatically to scan them) —
        enter the code from the same email instead.
      </p>

      <form action={formAction} className="mt-4 space-y-3">
        <input type="hidden" name="email" value={email} />
        <input type="hidden" name="intent" value={intent} />
        <input type="hidden" name="school" value={school} />
        <input type="hidden" name="academicStatus" value={academicStatus} />
        <div className="space-y-2">
          <Label htmlFor="token">Signup code</Label>
          <Input
            id="token"
            name="token"
            inputMode="numeric"
            autoComplete="one-time-code"
            placeholder="Code from your email"
            required
          />
        </div>

        {result && !result.ok && (
          <p className="text-sm text-destructive">{result.message}</p>
        )}

        <Button type="submit" className="w-full" disabled={isPending}>
          {isPending ? "Verifying…" : "Verify code"}
        </Button>
      </form>
    </div>
  );
}

export function SignupForm() {
  const [result, formAction, isPending] = useActionState(submitSignup, initialSubmitState);
  // Nothing is pre-selected — the 3 payment methods are the encouraged path
  // and deliberately aren't pre-highlighted as if one were already chosen.
  // null = no choice made yet, "" = explicitly skipped (free trial), a
  // PaymentMethodKey = that method chosen. The submit button only mentions
  // "free trial" once "" is chosen on purpose, never as the unstated
  // default — picking a method just changes where the student lands after
  // verifying (see actions.ts's redirectTargetFor); nothing is charged here.
  const [intent, setIntent] = useState<PaymentMethodKey | "" | null>(null);
  const [school, setSchool] = useState("");
  const [academicStatus, setAcademicStatus] = useState<AcademicStatus | "">("");

  if (result?.kind === "magic_link") {
    return <CodeForm email={result.email} intent={result.intent} school={school} academicStatus={academicStatus} />;
  }

  if (result?.kind === "password_confirm") {
    return (
      <div className="rounded-lg border bg-card p-6 text-center">
        <p className="font-medium">Check your email</p>
        <p className="mt-1 text-sm text-muted-foreground">
          We&apos;ve sent a confirmation link to <strong>{result.email}</strong>. Click it to finish setting up your
          account.
        </p>
      </div>
    );
  }

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
        <button
          type="button"
          onClick={() => setIntent("")}
          className={`mt-3 text-xs underline-offset-2 hover:underline ${
            intent === "" ? "font-medium text-foreground" : "text-muted-foreground"
          }`}
        >
          Skip — I&apos;ll pay later, start my free trial instead
        </button>
      </div>

      <form action={formAction} className="space-y-4">
        <input type="hidden" name="intent" value={intent ?? ""} />

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
          <Label htmlFor="password">Password (optional)</Label>
          <Input
            id="password"
            name="password"
            type="password"
            placeholder="Leave blank to sign in with an emailed code instead"
            autoComplete="new-password"
            minLength={8}
          />
        </div>

        {result?.kind === "error" && (
          <p className="text-sm text-destructive">{result.message}</p>
        )}

        <Button type="submit" className="w-full" disabled={isPending}>
          {isPending
            ? "Setting up…"
            : intent
              ? `Continue with ${METHODS.find((m) => m.key === intent)?.label}`
              : intent === ""
                ? "Start my free trial"
                : "Continue"}
        </Button>

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
