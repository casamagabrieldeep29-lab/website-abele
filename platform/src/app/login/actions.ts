"use server";

import { redirect } from "next/navigation";
import { clearAuthFlowCookies, createClient } from "@/lib/supabase/server";

export type SendMagicLinkResult = { ok: true; email: string } | { ok: false; message: string };

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
    console.error("[sendMagicLink]", error.status, error.message);
    return {
      ok: false,
      message:
        "We couldn't send a login link to that address. If you believe you should have access, contact your administrator for an invite.",
    };
  }

  return { ok: true, email };
}

export type VerifyOtpResult = { ok: false; message: string } | null;

export async function verifyOtpCode(
  _prev: VerifyOtpResult,
  formData: FormData,
): Promise<VerifyOtpResult> {
  const email = String(formData.get("email") ?? "").trim();
  const token = String(formData.get("token") ?? "").trim();

  if (!token) {
    return { ok: false, message: "Enter the code from your email." };
  }

  const supabase = await createClient();
  const { error } = await supabase.auth.verifyOtp({ email, token, type: "email" });

  if (error) {
    console.error("[verifyOtpCode]", error.status, error.message);
    return { ok: false, message: "That code didn't work — it may be wrong or expired. Try sending a new one." };
  }

  await clearAuthFlowCookies();
  redirect("/dashboard");
}
