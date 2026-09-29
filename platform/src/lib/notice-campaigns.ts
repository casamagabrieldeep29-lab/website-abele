import "server-only";
import type { SupabaseClient } from "@supabase/supabase-js";

export type NoticeTargetField = "address" | "school" | "password";

export type ActiveNoticeCampaign = {
  id: string;
  title: string;
  message: string;
  /** Only the fields this specific user is still missing — never the full
   *  campaign target list, so the modal never re-asks for something the
   *  user already filled in. */
  missingFields: NoticeTargetField[];
};

type ProfileGaps = { address: string | null; school: string | null; has_password: boolean };

function missingFieldsFor(profile: ProfileGaps, targetFields: string[]): NoticeTargetField[] {
  const missing: NoticeTargetField[] = [];
  if (targetFields.includes("address") && !profile.address) missing.push("address");
  if (targetFields.includes("school") && !profile.school) missing.push("school");
  if (targetFields.includes("password") && !profile.has_password) missing.push("password");
  return missing;
}

/**
 * Decides whether to show the signed-in user a notice-campaign popup right
 * now, and if so, logs that view immediately (so the times_per_day cap is
 * correct even if the render that follows never completes) — mirrors the
 * (app) layout's existing showProfilePrompt check, just generalized to a
 * schedulable, admin-authored campaign instead of one hardcoded flag.
 *
 * Only ever considers the single most recently created campaign that's
 * currently in its active window — campaigns aren't expected to overlap in
 * practice, and showing two at once would be confusing regardless.
 *
 * Returns null whenever there's nothing to show: no active campaign, the
 * user already has everything that campaign asks for, or they've already
 * been shown it the campaign's configured number of times today.
 */
export async function getActiveNoticeCampaignForUser(
  supabase: SupabaseClient,
  userId: string,
  profile: ProfileGaps,
): Promise<ActiveNoticeCampaign | null> {
  const { data: campaign } = await supabase
    .from("notice_campaigns")
    .select("id, title, message, target_fields, times_per_day")
    .order("created_at", { ascending: false })
    .limit(1)
    .maybeSingle();
  if (!campaign) return null;

  const missingFields = missingFieldsFor(profile, campaign.target_fields);
  if (missingFields.length === 0) return null;

  const startOfToday = new Date();
  startOfToday.setHours(0, 0, 0, 0);
  const { count } = await supabase
    .from("notice_campaign_views")
    .select("id", { count: "exact", head: true })
    .eq("campaign_id", campaign.id)
    .eq("user_id", userId)
    .gte("shown_at", startOfToday.toISOString());
  if ((count ?? 0) >= campaign.times_per_day) return null;

  await supabase.from("notice_campaign_views").insert({ campaign_id: campaign.id, user_id: userId });

  return { id: campaign.id, title: campaign.title, message: campaign.message, missingFields };
}
