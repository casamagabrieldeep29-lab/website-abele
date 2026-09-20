import "server-only";
import { cache } from "react";
import { createClient } from "@/lib/supabase/server";

export type SessionProfile = { role: string; display_name: string | null };

/**
 * getUser() plus the profiles row it gates almost every page on were each
 * being fetched independently by the (app) layout, the page itself, and
 * (on admin pages) requireAdmin() again — every one a real network round
 * trip to Supabase, on every single navigation. Wrapped in React.cache() so
 * every Server Component rendered within one request shares the same
 * result instead of re-fetching it. Scoped to one request only (per React's
 * own cache semantics) — never shared across users or requests.
 */
export const getAuthContext = cache(async () => {
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();

  if (!user) {
    return { supabase, user: null, profile: null as SessionProfile | null };
  }

  const { data: profile } = await supabase
    .from("profiles")
    .select("role, display_name")
    .eq("id", user.id)
    .single();

  return { supabase, user, profile: (profile as SessionProfile | null) ?? null };
});
