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
    await supabase.auth.updateUser({ data: { [FOLLOW_ACK_META_KEY]: new Date().toISOString() } }).catch(() => {});
  }
  const jar = await cookies();
  jar.set(FOLLOW_ACK_COOKIE, "1", { maxAge: 60 * 60 * 24 * 365, path: "/", httpOnly: true, sameSite: "lax", secure: process.env.NODE_ENV === "production" });
  redirect(safeNext(formData.get("next")));
}
