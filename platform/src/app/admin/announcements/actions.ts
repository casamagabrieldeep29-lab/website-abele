"use server";

import { revalidatePath } from "next/cache";
import { requireAdmin } from "@/lib/auth/require-admin";
import { createAdminClient } from "@/lib/supabase/admin";
import type { NoticeTargetField } from "@/lib/notice-campaigns";

export type CreateCampaignResult = { ok: true } | { ok: false; message: string };

const VALID_TARGET_FIELDS: NoticeTargetField[] = ["address", "school", "password"];

export async function createNoticeCampaign(
  _prev: CreateCampaignResult | null,
  formData: FormData,
): Promise<CreateCampaignResult> {
  const { user } = await requireAdmin();

  const title = String(formData.get("title") ?? "").trim();
  const message = String(formData.get("message") ?? "").trim();
  const targetFields = VALID_TARGET_FIELDS.filter((f) => formData.get(`target_${f}`) === "on");
  const durationDays = Number(formData.get("durationDays"));
  const timesPerDay = Number(formData.get("timesPerDay"));

  if (!title || !message) {
    return { ok: false, message: "Title and message are required." };
  }
  if (targetFields.length === 0) {
    return { ok: false, message: "Pick at least one field to ask for." };
  }
  if (!Number.isFinite(durationDays) || durationDays < 1) {
    return { ok: false, message: "Duration must be at least 1 day." };
  }
  if (!Number.isFinite(timesPerDay) || timesPerDay < 1) {
    return { ok: false, message: "Times per day must be at least 1." };
  }

  const admin = createAdminClient();
  const startsAt = new Date();
  const endsAt = new Date(startsAt.getTime() + durationDays * 24 * 60 * 60 * 1000);

  const { error } = await admin.from("notice_campaigns").insert({
    title,
    message,
    target_fields: targetFields,
    starts_at: startsAt.toISOString(),
    ends_at: endsAt.toISOString(),
    times_per_day: timesPerDay,
    created_by: user.id,
  });
  if (error) return { ok: false, message: error.message };

  revalidatePath("/admin/announcements");
  return { ok: true };
}

export async function setNoticeCampaignActive(campaignId: string, active: boolean) {
  await requireAdmin();
  const admin = createAdminClient();
  await admin.from("notice_campaigns").update({ active }).eq("id", campaignId);
  revalidatePath("/admin/announcements");
}
