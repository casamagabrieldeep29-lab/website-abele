import "server-only";
import { redirect } from "next/navigation";
import { getAuthContext } from "@/lib/auth/session";

/**
 * Call at the top of any admin-only Server Component. Redirects to /login
 * if not authenticated, or /dashboard if authenticated but not an admin.
 * Reads from the same request-scoped cache the (app) layout uses, so on a
 * page under that layout this doesn't repeat the getUser()/profile lookup
 * the layout already did.
 */
export async function requireAdmin() {
  const { user, profile } = await getAuthContext();

  if (!user) {
    redirect("/login");
  }

  if (profile?.role !== "admin") {
    redirect("/dashboard");
  }

  return { user, profile };
}
