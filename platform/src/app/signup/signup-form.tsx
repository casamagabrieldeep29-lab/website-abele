"use client";

import { useActionState } from "react";
import Link from "next/link";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { verifyOtpCode, type VerifyOtpResult } from "@/app/login/actions";
import { sendSignupMagicLink, type SendSignupLinkResult } from "./actions";

const initialSendState: SendSignupLinkResult | null = null;
const initialVerifyState: VerifyOtpResult = null;

function CodeForm({ email }: { email: string }) {
  const [result, formAction, isPending] = useActionState(verifyOtpCode, initialVerifyState);

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
  const [result, formAction, isPending] = useActionState(sendSignupMagicLink, initialSendState);

  if (result?.ok) {
    return <CodeForm email={result.email} />;
  }

  return (
    <form action={formAction} className="space-y-4">
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

      {result && !result.ok && (
        <p className="text-sm text-destructive">{result.message}</p>
      )}

      <Button type="submit" className="w-full" disabled={isPending}>
        {isPending ? "Sending link…" : "Start my free trial"}
      </Button>

      <p className="text-center text-xs text-muted-foreground">
        Already have an account?{" "}
        <Link href="/login" className="text-primary hover:underline">
          Sign in
        </Link>
      </p>
    </form>
  );
}
