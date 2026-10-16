"use server";

import { cookies } from "next/headers";
import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import { FOLLOW_ACK_COOKIE, FOLLOW_ACK_META_KEY } from "@/lib/social-links";

/** Only same-site paths are allowed as the place to go next. */
function safeNext(raw: FormDataEntryValue | null): string {
  const next = typeof raw === "string" ? raw : "";
  return next.startsWith("/") && !next.startsWith("//") && !next.startsWith("/follow") ? next : "/dashboard";
}

/**
 * Records that the student passed the one-time "follow our pages" announcement. Stored on the account
 * (auth user_metadata, so it follows them to other devices) and in a long-lived cookie (so this device
 * stops asking immediately, before the next token refresh carries the new metadata).
 * Facebook cannot tell us whether someone really followed, so this is an honor-system step.
 */
export async function acknowledgeFollow(formData: FormData) {
  const supabase = await createClient();
  const { data } = await supabase.auth.getUser();
  if (data.user) {
    // A failure here only means other devices may ask once more; this device is covered by the cookie.
    try {
      await supabase.auth.updateUser({ data: { [FOLLOW_ACK_META_KEY]: new Date().toISOString() } });
      // The flag lives in the access token's claims, which only change when the token is refreshed. Refresh it
      // now so the new token (stored in the same session cookies that keep students signed in) carries the flag.
      await supabase.auth.refreshSession();
    } catch {
      // Not fatal: the device cookie below still lets this device through.
    }
  }
  const jar = await cookies();
  // Not a secret (just "1"), so it doesn't need to be httpOnly.
  jar.set(FOLLOW_ACK_COOKIE, "1", { maxAge: 60 * 60 * 24 * 365, path: "/", httpOnly: false, sameSite: "lax", secure: process.env.NODE_ENV === "production" });
  redirect(safeNext(formData.get("next")));
}
