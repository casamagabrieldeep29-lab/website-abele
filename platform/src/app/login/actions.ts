"use server";

import { redirect } from "next/navigation";
import { clearAuthFlowCookies, createClient } from "@/lib/supabase/server";
import { getSiteUrl } from "@/lib/site-url";
import { checkRateLimit, getClientIp } from "@/lib/rate-limit";

// Two-tier budget, covering both OTP-email-bombing and password
// brute-forcing (flagged as a public-launch blocker, 2026-09-28):
//
//   1. Tight per (IP, email) pair — stops someone hammering ONE account's
//      password or OTP from one source.
//   2. Loose per IP alone — a backstop against pure volumetric abuse
//      (scripted spam across many emails from one source), set high enough
//      that it should never fire on real traffic.
//
// FIXED 2026-10-02: this used to be a single `login:${ip}` bucket at 15/15min
// shared by EVERY login attempt from that IP regardless of whose account —
// caused a real incident where every user got logged out together, because
// Philippine mobile carriers commonly put thousands of distinct real users
// behind one carrier-grade-NAT IP (and getClientIp()'s old "unknown" string
// fallback made it worse by sharing one bucket across every caller the
// x-forwarded-for header was missing for, see rate-limit.ts). Keying by
// (ip, email) means different people's accounts on the same shared IP no
// longer share a budget; the pure-IP bucket is now wide enough to absorb a
// realistic burst of organic logins from one campus/carrier network.
const LOGIN_PAIR_LIMIT = 10;
const LOGIN_PAIR_WINDOW_SECONDS = 15 * 60;
const LOGIN_IP_LIMIT = 100;
const LOGIN_IP_WINDOW_SECONDS = 15 * 60;

async function checkLoginRateLimit(email: string): Promise<boolean> {
  const ip = await getClientIp();
  const [pairAllowed, ipAllowed] = await Promise.all([
    checkRateLimit(`login:${ip}:${email.toLowerCase()}`, LOGIN_PAIR_LIMIT, LOGIN_PAIR_WINDOW_SECONDS),
    checkRateLimit(`login-ip:${ip}`, LOGIN_IP_LIMIT, LOGIN_IP_WINDOW_SECONDS),
  ]);
  return pairAllowed && ipAllowed;
}

export type SendMagicLinkResult = { ok: true; email: string } | { ok: false; message: string };

export async function sendMagicLink(
  _prev: SendMagicLinkResult | null,
  formData: FormData,
): Promise<SendMagicLinkResult> {
  const email = String(formData.get("email") ?? "").trim();

  if (!email || !email.includes("@")) {
    return { ok: false, message: "Enter a valid email address." };
  }

  if (!(await checkLoginRateLimit(email))) {
    return { ok: false, message: "Too many attempts for that account. Please wait a bit and try again." };
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

  if (!(await checkLoginRateLimit(email))) {
    return { ok: false, message: "Too many attempts for that account. Please wait a bit and try again." };
  }

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
