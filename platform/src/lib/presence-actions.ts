"use server";

import { createClient } from "@/lib/supabase/server";

/**
 * Heartbeat for the admin "who's active" indicator (see patch
 * 033_presence.sql) — called from PresenceHeartbeat on every authenticated
 * page, roughly once a minute while the tab is visible. A no-op for signed-
 * out visitors (e.g. /login) rather than an error, since this fires
 * unconditionally from the root layout.
 */
export async function pingPresence() {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) return;

  await supabase.from("profiles").update({ last_seen_at: new Date().toISOString() }).eq("id", user.id);
}
