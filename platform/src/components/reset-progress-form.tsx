"use client";

import { useActionState, useState } from "react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import {
  sendResetProgressCode,
  confirmResetProgress,
  type SendCodeResult,
  type ResetProgressResult,
} from "@/app/settings/actions";

const initialSendState: SendCodeResult | null = null;
const initialConfirmState: ResetProgressResult | null = null;

function CodeForm({ email, onCancel }: { email: string; onCancel: () => void }) {
  const [result, formAction, isPending] = useActionState(confirmResetProgress, initialConfirmState);

  if (result?.ok) {
    return (
      <div className="space-y-1 rounded-md border border-success/30 bg-success/5 px-3 py-2 text-sm text-success">
        <p>Your progress has been reset. Your account and saved notes/bookmarks are untouched.</p>
        <p className="text-xs opacity-80">{result.summary}</p>
      </div>
    );
  }

  return (
    <div className="space-y-3 rounded-md border border-destructive/30 bg-destructive/5 p-3">
      <p className="text-sm text-destructive">
        We sent a code to <strong>{email}</strong>. Enter it to permanently reset all your
        practice/mock history, mastery, and flashcard progress. Your day streak is kept. This
        cannot be undone.
      </p>
      <form action={formAction} className="space-y-2">
        <Label htmlFor="reset-token" className="text-xs">
          Verification code
        </Label>
        <Input
          id="reset-token"
          name="token"
          inputMode="numeric"
          autoComplete="one-time-code"
          placeholder="Code from your email"
          required
          className="h-9"
        />
        {result && !result.ok && <p className="text-sm text-destructive">{result.message}</p>}
        <div className="flex gap-2">
          <Button type="submit" variant="destructive" size="sm" disabled={isPending}>
            {isPending ? "Verifying…" : "Confirm reset"}
          </Button>
          <Button type="button" variant="outline" size="sm" onClick={onCancel}>
            Cancel
          </Button>
        </div>
      </form>
    </div>
  );
}

export function ResetProgressForm() {
  const [expanded, setExpanded] = useState(false);
  const [sendResult, sendAction, isSending] = useActionState(sendResetProgressCode, initialSendState);

  if (!expanded) {
    return (
      <Button type="button" variant="destructive" size="sm" onClick={() => setExpanded(true)}>
        Reset My Progress
      </Button>
    );
  }

  if (sendResult?.ok) {
    return <CodeForm email={sendResult.email} onCancel={() => setExpanded(false)} />;
  }

  return (
    <div className="space-y-3 rounded-md border border-destructive/30 bg-destructive/5 p-3">
      <p className="text-sm text-destructive">
        This permanently wipes all your practice/mock history, mastery, and flashcard progress.
        Your account, saved notes, bookmarks, and day streak stay untouched. This cannot be
        undone.
      </p>
      <form action={sendAction} className="space-y-2">
        {sendResult && !sendResult.ok && <p className="text-sm text-destructive">{sendResult.message}</p>}
        <div className="flex gap-2">
          <Button type="submit" variant="destructive" size="sm" disabled={isSending}>
            {isSending ? "Sending code…" : "Send verification code"}
          </Button>
          <Button type="button" variant="outline" size="sm" onClick={() => setExpanded(false)}>
            Cancel
          </Button>
        </div>
      </form>
    </div>
  );
}
