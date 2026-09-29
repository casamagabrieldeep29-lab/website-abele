"use client";

import { useRef, useState } from "react";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogDescription, DialogFooter } from "@/components/ui/dialog";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { saveNoticeCampaignResponse } from "@/app/settings/notice-campaign-actions";
import type { ActiveNoticeCampaign } from "@/lib/notice-campaigns";

const FIELD_LABELS: Record<ActiveNoticeCampaign["missingFields"][number], { label: string; placeholder: string }> = {
  address: { label: "Address", placeholder: "e.g. Brgy. San Isidro, General Santos City" },
  school: { label: "School", placeholder: "e.g. Central Luzon State University" },
  password: { label: "Set a password", placeholder: "Leave blank to keep signing in with an emailed code" },
};

/**
 * Renders an admin-scheduled notice campaign (src/lib/notice-campaigns.ts
 * decides when one applies and to which fields) — unlike
 * ProfileCompletionModal's permanent single dismiss, closing this one
 * (Save or Maybe later) doesn't set any "never again" flag: the layout's
 * server-side view count is what caps how often it reappears, so it's
 * expected to come back later the same day or on a future visit within the
 * campaign's window.
 */
export function NoticeCampaignModal({ campaign }: { campaign: ActiveNoticeCampaign }) {
  const [open, setOpen] = useState(true);
  const [pending, setPending] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const formRef = useRef<HTMLFormElement>(null);

  async function handleSave() {
    setPending(true);
    setError(null);
    const formData = new FormData(formRef.current ?? undefined);
    const result = await saveNoticeCampaignResponse(formData);
    setPending(false);
    if (!result.ok) {
      setError(result.error);
      return;
    }
    setOpen(false);
  }

  return (
    <Dialog open={open} onOpenChange={(next) => setOpen(next)}>
      <DialogContent>
        <DialogHeader>
          <DialogTitle>{campaign.title}</DialogTitle>
          <DialogDescription>{campaign.message}</DialogDescription>
        </DialogHeader>

        <form ref={formRef} className="space-y-4" onSubmit={(e) => { e.preventDefault(); void handleSave(); }}>
          {campaign.missingFields.map((field) => (
            <div key={field} className="space-y-2">
              <Label htmlFor={`notice-${field}`}>{FIELD_LABELS[field].label}</Label>
              <Input
                id={`notice-${field}`}
                name={field}
                type={field === "password" ? "password" : "text"}
                placeholder={FIELD_LABELS[field].placeholder}
                autoComplete={field === "password" ? "new-password" : field === "address" ? "street-address" : "organization"}
                minLength={field === "password" ? 8 : undefined}
              />
            </div>
          ))}

          {error && <p className="text-sm text-destructive">{error}</p>}
        </form>

        <DialogFooter>
          <Button type="button" variant="ghost" onClick={() => setOpen(false)} disabled={pending}>
            Maybe later
          </Button>
          <Button type="button" onClick={handleSave} disabled={pending}>
            {pending ? "Saving…" : "Save"}
          </Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}
