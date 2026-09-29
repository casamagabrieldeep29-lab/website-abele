"use client";

import { useActionState } from "react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { createNoticeCampaign, type CreateCampaignResult } from "./actions";

const initialState: CreateCampaignResult | null = null;

const FIELD_OPTIONS = [
  { key: "address", label: "Address" },
  { key: "school", label: "School" },
  { key: "password", label: "Password" },
] as const;

export function CreateCampaignForm() {
  const [result, formAction, isPending] = useActionState(createNoticeCampaign, initialState);

  return (
    <form action={formAction} className="space-y-4">
      <div className="space-y-2">
        <Label htmlFor="title">Title</Label>
        <Input id="title" name="title" placeholder="A couple of things to add" required />
      </div>

      <div className="space-y-2">
        <Label htmlFor="message">Message</Label>
        <textarea
          id="message"
          name="message"
          rows={2}
          placeholder="Take a second to fill these in — it helps us reach you and keep your account secure."
          required
          className="w-full rounded-md border border-border bg-background px-3 py-2 text-sm"
        />
      </div>

      <div className="space-y-2">
        <Label>Ask for whichever of these a user is still missing</Label>
        <div className="flex flex-wrap gap-4">
          {FIELD_OPTIONS.map((opt) => (
            <label key={opt.key} className="flex items-center gap-1.5 text-sm">
              <input type="checkbox" name={`target_${opt.key}`} defaultChecked className="size-4" />
              {opt.label}
            </label>
          ))}
        </div>
      </div>

      <div className="grid grid-cols-2 gap-4">
        <div className="space-y-2">
          <Label htmlFor="durationDays">Runs for (days, starting now)</Label>
          <Input id="durationDays" name="durationDays" type="number" min={1} defaultValue={7} required />
        </div>
        <div className="space-y-2">
          <Label htmlFor="timesPerDay">Times per day</Label>
          <Input id="timesPerDay" name="timesPerDay" type="number" min={1} defaultValue={2} required />
        </div>
      </div>

      {result && (
        <p className={`text-sm ${result.ok ? "text-primary" : "text-destructive"}`}>
          {result.ok ? "Campaign created and running." : result.message}
        </p>
      )}

      <Button type="submit" disabled={isPending}>
        {isPending ? "Creating…" : "Create campaign"}
      </Button>
    </form>
  );
}
