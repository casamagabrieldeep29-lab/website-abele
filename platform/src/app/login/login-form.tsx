"use client";

import { useActionState } from "react";
import Link from "next/link";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { submitLogin, verifyOtpCode, type SubmitLoginResult, type VerifyOtpResult } from "./actions";

const initialSubmitState: SubmitLoginResult = null;
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
  const [result, formAction, isPending] = useActionState(submitLogin, initialSubmitState);

  if (result?.kind === "magic_link") {
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

      <div className="space-y-2">
        <Label htmlFor="password">Password (optional)</Label>
        <Input
          id="password"
          name="password"
          type="password"
          placeholder="Leave blank to sign in with an emailed code instead"
          autoComplete="current-password"
        />
      </div>

      {result?.kind === "error" && (
        <p className="text-sm text-destructive">{result.message}</p>
      )}

      <Button type="submit" className="w-full" disabled={isPending}>
        {isPending ? "Signing in…" : "Sign in"}
      </Button>

      <p className="text-center text-xs text-muted-foreground">
        Don&apos;t have an account yet?{" "}
        <Link href="/signup" className="text-primary hover:underline">
          Sign up
        </Link>
      </p>
    </form>
  );
}
