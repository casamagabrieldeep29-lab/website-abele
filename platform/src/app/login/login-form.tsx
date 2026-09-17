"use client";

import { useActionState } from "react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { sendMagicLink, type SendMagicLinkResult } from "./actions";

const initialState: SendMagicLinkResult | null = null;

export function LoginForm() {
  const [result, formAction, isPending] = useActionState(sendMagicLink, initialState);

  if (result?.ok) {
    return (
      <div className="rounded-lg border bg-card p-6 text-center">
        <p className="font-medium">Check your email</p>
        <p className="mt-1 text-sm text-muted-foreground">
          We&apos;ve sent you a one-time login link. Open it on this device to sign in.
        </p>
      </div>
    );
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
