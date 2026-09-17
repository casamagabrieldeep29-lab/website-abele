"use server";

import { createClient } from "@/lib/supabase/server";

export type SendMagicLinkResult = { ok: true } | { ok: false; message: string };

export async function sendMagicLink(
  _prev: SendMagicLinkResult | null,
  formData: FormData,
): Promise<SendMagicLinkResult> {
  const email = String(formData.get("email") ?? "").trim();

  if (!email || !email.includes("@")) {
    return { ok: false, message: "Enter a valid email address." };
  }

  const supabase = await createClient();
  const siteUrl = process.env.NEXT_PUBLIC_SITE_URL ?? "http://localhost:3000";

  const { error } = await supabase.auth.signInWithOtp({
    email,
    options: {
      emailRedirectTo: `${siteUrl}/auth/callback`,
      shouldCreateUser: false,
    },
  });

  if (error) {
    return {
      ok: false,
      message:
        "We couldn't send a login link to that address. If you believe you should have access, contact your administrator for an invite.",
    };
  }

  return { ok: true };
}
