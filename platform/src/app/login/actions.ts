"use server";

import { redirect } from "next/navigation";
import { clearAuthFlowCookies, createClient } from "@/lib/supabase/server";
import { getSiteUrl } from "@/lib/site-url";

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
  const siteUrl = await getSiteUrl();

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
        "We couldn't find an account for that address. If you're new here, sign up instead.",
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

export type SignInWithPasswordResult = { ok: false; message: string } | null;

/** Password-based alternative to the magic-link flow above, for anyone who set a password at signup. */
export async function signInWithPassword(
  _prev: SignInWithPasswordResult,
  formData: FormData,
): Promise<SignInWithPasswordResult> {
  const email = String(formData.get("email") ?? "").trim();
  const password = String(formData.get("password") ?? "");

  const supabase = await createClient();
  const { error } = await supabase.auth.signInWithPassword({ email, password });

  if (error) {
    console.error("[signInWithPassword]", error.status, error.message);
    return { ok: false, message: "Wrong email or password." };
  }

  redirect("/dashboard");
}

export type SubmitLoginResult =
  | { kind: "magic_link"; email: string }
  | { kind: "error"; message: string }
  | null;

/**
 * Single entry point LoginForm's one form submits to — branches to
 * signInWithPassword above when a password was entered, sendMagicLink
 * otherwise. Mirrors signup's submitSignup for the same reason: one form,
 * one useActionState hook, instead of juggling two independent action
 * states in the same component.
 */
export async function submitLogin(_prev: SubmitLoginResult, formData: FormData): Promise<SubmitLoginResult> {
  const password = String(formData.get("password") ?? "");

  if (password) {
    const result = await signInWithPassword(null, formData);
    if (!result) return null;
    return { kind: "error", message: result.message };
  }

  const result = await sendMagicLink(null, formData);
  if (!result.ok) return { kind: "error", message: result.message };
  return { kind: "magic_link", email: result.email };
}
