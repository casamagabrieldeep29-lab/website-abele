"use client";

import { useState } from "react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { removeUser } from "../actions";

const CONFIRM_TEXT = "REMOVE";

/** Same type-to-confirm pattern as Settings' own "Delete Account" — the button
    stays disabled until the exact confirmation word is typed; the real check
    happens again server-side in removeUser. */
export function RemoveUserForm({ userId, name }: { userId: string; name: string }) {
  const [expanded, setExpanded] = useState(false);
  const [confirmation, setConfirmation] = useState("");
  const action = removeUser.bind(null, userId);

  if (!expanded) {
    return (
      <Button type="button" variant="destructive" size="sm" onClick={() => setExpanded(true)}>
        Remove
      </Button>
    );
  }

  return (
    <form action={action} className="w-full space-y-2 rounded-md border border-destructive/30 bg-destructive/5 p-2.5">
      <p className="text-xs text-destructive">
        Permanently deletes {name}&apos;s account and study data. This cannot be undone.
      </p>
      <Input
        value={confirmation}
        onChange={(e) => setConfirmation(e.target.value)}
        placeholder={`Type ${CONFIRM_TEXT} to confirm`}
        autoComplete="off"
        className="h-8 text-sm"
      />
      <div className="flex gap-2">
        <Button type="submit" variant="destructive" size="sm" disabled={confirmation !== CONFIRM_TEXT}>
          Confirm remove
        </Button>
        <Button type="button" variant="outline" size="sm" onClick={() => setExpanded(false)}>
          Cancel
        </Button>
      </div>
    </form>
  );
}
