"use client";

import { useActionState } from "react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { sendMagicLink, verifyOtpCode, type SendMagicLinkResult, type VerifyOtpResult } from "./actions";

const initialSendState: SendMagicLinkResult | null = null;
const initialVerifyState: VerifyOtpResult = null;

function CodeForm({ email }: { email: string }) {
  const [result, formAction, isPending] = useActionState(verifyOtpCode, initialVerifyState);

  return (
    <div className="rounded-lg border bg-card p-6">
      <p className="font-medium">Check your email</p>
      <p className="mt-1 text-sm text-muted-foreground">
        We&apos;ve sent a login link to <strong>{email}</strong>. You can click it, or — if the
        link says it&apos;s expired (some email apps open links automatically to scan them) —
        enter the code from the same email instead.
      </p>

      <form action={formAction} className="mt-4 space-y-3">
        <input type="hidden" name="email" value={email} />
        <div className="space-y-2">
          <Label htmlFor="token">Login code</Label>
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

export function LoginForm() {
  const [result, formAction, isPending] = useActionState(sendMagicLink, initialSendState);

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
        {isPending ? "Sending link…" : "Send login link"}
      </Button>

      <p className="text-center text-xs text-muted-foreground">
        Access is invite-only. If you haven&apos;t been invited yet, contact your
        administrator.
      </p>
    </form>
  );
}
