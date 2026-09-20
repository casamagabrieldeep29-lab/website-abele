import "server-only";
import { getAuthContext } from "@/lib/auth/session";

/**
 * Non-redirecting admin check for student-facing pages that need to
 * conditionally reveal admin-only details (e.g. raw question counts)
 * without gating the whole page behind requireAdmin(). Reads from the
 * same request-scoped cache the (app) layout and requireAdmin() use, so
 * this never re-fetches the profile row on its own.
 */
export async function checkIsAdmin(): Promise<boolean> {
  const { profile } = await getAuthContext();
  return profile?.role === "admin";
}
