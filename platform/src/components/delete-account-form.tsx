"use client";

import { useState } from "react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";

const CONFIRM_TEXT = "DELETE";

/**
 * Deliberate two-step confirmation: the button stays disabled until the
 * user types "DELETE" exactly. The actual account/data deletion is enforced
 * server-side (settings/actions.ts checks the same value again) — this is
 * just the UI gate, never trusted as the real check.
 */
export function DeleteAccountForm({ action }: { action: (formData: FormData) => Promise<void> }) {
  const [expanded, setExpanded] = useState(false);
  const [confirmation, setConfirmation] = useState("");

  if (!expanded) {
    return (
      <Button type="button" variant="destructive" size="sm" onClick={() => setExpanded(true)}>
        Delete Account
      </Button>
    );
  }

  return (
    <form action={action} className="max-w-sm space-y-3 rounded-md border border-destructive/30 bg-destructive/5 p-3">
      <p className="text-sm text-destructive">
        This permanently removes your ABELIEVER account and associated data. This cannot be undone.
      </p>
      <div className="space-y-1.5">
        <label htmlFor="confirmation" className="text-xs text-muted-foreground">
          Type <span className="font-mono font-semibold">DELETE</span> to confirm
        </label>
        <Input
          id="confirmation"
          name="confirmation"
          value={confirmation}
          onChange={(e) => setConfirmation(e.target.value)}
          autoComplete="off"
        />
      </div>
      <div className="flex gap-2">
        <Button type="submit" variant="destructive" size="sm" disabled={confirmation !== CONFIRM_TEXT}>
          Permanently delete my account
        </Button>
        <Button type="button" variant="outline" size="sm" onClick={() => setExpanded(false)}>
          Cancel
        </Button>
      </div>
    </form>
  );
}
