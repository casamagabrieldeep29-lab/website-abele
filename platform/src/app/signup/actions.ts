"use server";

import { createClient } from "@/lib/supabase/server";
import { getSiteUrl } from "@/lib/site-url";

export type SendSignupLinkResult = { ok: true; email: string } | { ok: false; message: string };

/**
 * The self-serve counterpart to login/actions.ts's sendMagicLink — same
 * passwordless OTP mechanism, but with shouldCreateUser flipped to true.
 * Deliberately kept as its own function rather than a shared one with a
 * flag: login's whole point is that an unrecognized email does NOT create
 * an account, and that gate is easy to lose track of if the two paths share
 * one implementation. A brand-new auth.users row here is exactly what
 * hands off to handle_new_user() (schema.sql) and the profiles table's own
 * column defaults (plan='trial', trial_started_at=now() — patch
 * 032_subscriber_plan.sql), which is the same trial every invited user
 * already starts on, just triggered by the student instead of an admin.
 */
export async function sendSignupMagicLink(
  _prev: SendSignupLinkResult | null,
  formData: FormData,
): Promise<SendSignupLinkResult> {
  const email = String(formData.get("email") ?? "").trim();

  if (!email || !email.includes("@")) {
    return { ok: false, message: "Enter a valid email address." };
  }

  const supabase = await createClient();
  const siteUrl = await getSiteUrl();

  const { error } = await supabase.auth.signInWithOtp({
    email,
    options: {
      emailRedirectTo: `${siteUrl}/auth/callback`,
      shouldCreateUser: true,
    },
  });

  if (error) {
    console.error("[sendSignupMagicLink]", error.status, error.message);
    return {
      ok: false,
      message: "We couldn't send a signup link to that address. Double-check it and try again.",
    };
  }

  return { ok: true, email };
}
