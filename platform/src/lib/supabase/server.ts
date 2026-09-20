import { createServerClient } from "@supabase/ssr";
import { cookies } from "next/headers";

/**
 * Each PKCE sign-in attempt (magic link, resend, etc.) sets its own
 * per-flow "-code-verifier" cookie. The one for a completed exchange gets
 * cleared automatically, but an abandoned attempt (link never clicked, or
 * the numeric-OTP path, which never touches the verifier at all) leaves
 * its cookie behind indefinitely. Call this once a session is established
 * to sweep up anything left over, regardless of which path was used.
 */
export async function clearAuthFlowCookies() {
  const cookieStore = await cookies();
  for (const { name } of cookieStore.getAll()) {
    if (name.endsWith("-code-verifier")) {
      cookieStore.delete(name);
    }
  }
}

export async function createClient() {
  const cookieStore = await cookies();

  return createServerClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!,
    {
      cookies: {
        getAll() {
          return cookieStore.getAll();
        },
        setAll(cookiesToSet) {
          try {
            cookiesToSet.forEach(({ name, value, options }) =>
              cookieStore.set(name, value, options),
            );
          } catch {
            // setAll is called from a Server Component during render, where
            // cookies cannot be written. Safe to ignore because the proxy
            // (see src/proxy.ts) refreshes the session on every request.
          }
        },
      },
    },
  );
}
