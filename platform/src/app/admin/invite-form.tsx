"use client";

import { useActionState } from "react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { inviteUser, type InviteResult } from "./actions";

const initialState: InviteResult | null = null;

export function InviteForm() {
  const [result, formAction, isPending] = useActionState(inviteUser, initialState);

  return (
    <form action={formAction} className="space-y-4">
      <div className="space-y-2">
        <Label htmlFor="email">Email address to invite</Label>
        <Input
          id="email"
          name="email"
          type="email"
          placeholder="reviewee@example.com"
          required
          autoComplete="off"
        />
      </div>

      <div className="space-y-2">
        <Label htmlFor="plan">Plan</Label>
        <select
          id="plan"
          name="plan"
          defaultValue="trial"
          className="w-full rounded-md border border-border bg-background px-3 py-2 text-sm"
        >
          <option value="trial">Free Trial (14 days, starts now)</option>
          <option value="subscriber">Subscriber</option>
        </select>
      </div>

      {result && (
        <p className={`text-sm ${result.ok ? "text-primary" : "text-destructive"}`}>
          {result.ok
            ? `Invite sent to ${result.email}.`
            : result.message}
        </p>
      )}

      <Button type="submit" disabled={isPending}>
        {isPending ? "Sending invite…" : "Send invite"}
      </Button>
    </form>
  );
}
