"use server";

import { createClient } from "@/lib/supabase/server";
import { getSessionUser } from "@/lib/auth/session";
import { getPublishedReviewerEntries } from "@/lib/shared-content";

export type ReviewerEntryDetail = {
  table_content: string | null;
  variables: string | null;
  notes: string | null;
};

const MAX_IDS = 300;
const UUID_RE = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;

/**
 * The Reviewers and PAES Library pages only send each entry's short fields up
 * front; the heavy ones (full table text, variable definitions, notes — about a
 * third of the payload) are fetched here when a student actually opens a group.
 * Served from the shared cached snapshot, so it costs no Supabase egress.
 */
export async function getReviewerDetails(ids: string[]): Promise<Record<string, ReviewerEntryDetail>> {
  const supabase = await createClient();
  const user = await getSessionUser(supabase);
  if (!user) return {};

  const wanted = new Set(ids.filter((id) => typeof id === "string" && UUID_RE.test(id)).slice(0, MAX_IDS));
  if (wanted.size === 0) return {};

  const all = await getPublishedReviewerEntries();
  const out: Record<string, ReviewerEntryDetail> = {};
  for (const e of all) {
    if (wanted.has(e.id)) {
      out[e.id] = { table_content: e.table_content, variables: e.variables, notes: e.notes };
    }
  }
  return out;
}
