import "server-only";
import type { createClient } from "@/lib/supabase/server";

/**
 * Non-redirecting admin check for student-facing pages that need to
 * conditionally reveal admin-only details (e.g. raw question counts)
 * without gating the whole page behind requireAdmin().
 */
export async function checkIsAdmin(
  supabase: Awaited<ReturnType<typeof createClient>>,
  userId: string,
): Promise<boolean> {
  const { data: profile } = await supabase
    .from("profiles")
    .select("role")
    .eq("id", userId)
    .single();

  return profile?.role === "admin";
}
