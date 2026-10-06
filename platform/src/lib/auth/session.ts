import "server-only";
import { cache } from "react";
import { createClient } from "@/lib/supabase/server";

export type SessionUser = { id: string; email: string | undefined };

/**
 * Who is signed in, verified LOCALLY from the session JWT's signature
 * (signing keys are cached in-process) instead of asking Supabase Auth over the
 * network. getUser() costs one Auth request on every page view — three per view
 * before this — and Auth traffic counts against Supabase's egress and was the
 * service that fell over under load. Use this for read-only page rendering; the
 * database still enforces row-level security off the same JWT. Anything that
 * CHANGES data (server actions, API routes) keeps the stricter auth.getUser(),
 * which also notices a session that was revoked server-side.
 */
export async function getSessionUser(
  supabase: Awaited<ReturnType<typeof createClient>>,
): Promise<SessionUser | null> {
  const { data } = await supabase.auth.getClaims();
  const claims = data?.claims;
  if (!claims?.sub) return null;
  return { id: claims.sub, email: typeof claims.email === "string" ? claims.email : undefined };
}

export type SessionProfile = { role: string; display_name: string | null; current_streak: number };

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
  const user = await getSessionUser(supabase);

  if (!user) {
    return { supabase, user: null, profile: null as SessionProfile | null };
  }

  const { data: profile } = await supabase
    .from("profiles")
    .select("role, display_name, current_streak")
    .eq("id", user.id)
    .single();

  return { supabase, user, profile: (profile as SessionProfile | null) ?? null };
});
