"use server";

import { redirect } from "next/navigation";
import { clearAuthFlowCookies, createClient } from "@/lib/supabase/server";
import { createAdminClient } from "@/lib/supabase/admin";
import { getSiteUrl } from "@/lib/site-url";
import type { PaymentMethodKey } from "@/lib/payment-methods";

const VALID_METHODS: PaymentMethodKey[] = ["gcash", "maya", "landbank"];
const VALID_ACADEMIC_STATUSES = ["student", "reviewee"] as const;
type AcademicStatus = (typeof VALID_ACADEMIC_STATUSES)[number];

function redirectTargetFor(intent: string): string {
  return VALID_METHODS.includes(intent as PaymentMethodKey) ? `/upgrade?method=${intent}` : "/dashboard";
}

function readAcademicFields(formData: FormData): { school: string | null; academicStatus: AcademicStatus | null } {
  const school = String(formData.get("school") ?? "").trim();
  const academicStatusRaw = String(formData.get("academicStatus") ?? "");
  const academicStatus = VALID_ACADEMIC_STATUSES.includes(academicStatusRaw as AcademicStatus)
    ? (academicStatusRaw as AcademicStatus)
    : null;
  return { school: school || null, academicStatus };
}

export type SendSignupLinkResult = { ok: true; email: string; intent: string } | { ok: false; message: string };

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
 *
 * `intent` (a payment method key, or "" for "skip, start my trial") carries
 * a student's choice on the picker through to wherever they land after
 * verifying — /upgrade pre-selected to that method, or straight to
 * /dashboard for the trial. Nothing is charged here; there's no gateway to
 * charge through and no account yet to attach a payment_requests row to —
 * this only steers where they land once one exists. school/academicStatus
 * are carried the same way (as hidden fields through CodeForm) since the
 * profile row can't be written until verifySignupOtpCode below actually has
 * a session for it.
 */
export async function sendSignupMagicLink(
  _prev: SendSignupLinkResult | null,
  formData: FormData,
): Promise<SendSignupLinkResult> {
  const email = String(formData.get("email") ?? "").trim();
  const intent = String(formData.get("intent") ?? "");

  if (!email || !email.includes("@")) {
    return { ok: false, message: "Enter a valid email address." };
  }

  const supabase = await createClient();
  const siteUrl = await getSiteUrl();
  const next = redirectTargetFor(intent);

  const { error } = await supabase.auth.signInWithOtp({
    email,
    options: {
      emailRedirectTo: `${siteUrl}/auth/callback?next=${encodeURIComponent(next)}`,
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

  return { ok: true, email, intent };
}

export type VerifySignupOtpResult = { ok: false; message: string } | null;

/** Same OTP verification as login's verifyOtpCode, plus writing the school/academicStatus carried through from the signup form once a session actually exists, then redirecting per the carried-through intent instead of always to /dashboard. */
export async function verifySignupOtpCode(
  _prev: VerifySignupOtpResult,
  formData: FormData,
): Promise<VerifySignupOtpResult> {
  const email = String(formData.get("email") ?? "").trim();
  const token = String(formData.get("token") ?? "").trim();
  const intent = String(formData.get("intent") ?? "");
  const { school, academicStatus } = readAcademicFields(formData);

  const supabase = await createClient();
  const { error } = await supabase.auth.verifyOtp({ email, token, type: "email" });

  if (error) {
    console.error("[verifySignupOtpCode]", error.status, error.message);
    return { ok: false, message: "That code didn't work — it may be wrong or expired. Try sending a new one." };
  }

  if (school || academicStatus) {
    const { data: { user } } = await supabase.auth.getUser();
    if (user) {
      await supabase.from("profiles").update({ school, academic_status: academicStatus }).eq("id", user.id);
    }
  }

  await clearAuthFlowCookies();
  redirect(redirectTargetFor(intent));
}

export type SignUpWithPasswordResult =
  | { ok: true; needsConfirmation: true; email: string }
  | { ok: false; message: string }
  | null;

/**
 * Password-based alternative to the magic-link flow above, added alongside
 * it (not replacing it) per Gabriel's explicit "allow passwords na". Uses
 * the admin client to write school/academic_status right after signUp()
 * rather than the regular RLS-scoped client, because whether a session
 * exists immediately depends on this Supabase project's "confirm email"
 * setting — data.user.id (and the profiles row handle_new_user() already
 * created for it) exists either way, so this one write path covers both.
 */
export async function signUpWithPassword(
  _prev: SignUpWithPasswordResult,
  formData: FormData,
): Promise<SignUpWithPasswordResult> {
  const email = String(formData.get("email") ?? "").trim();
  const password = String(formData.get("password") ?? "");
  const intent = String(formData.get("intent") ?? "");
  const { school, academicStatus } = readAcademicFields(formData);

  if (!email || !email.includes("@")) {
    return { ok: false, message: "Enter a valid email address." };
  }
  if (password.length < 8) {
    return { ok: false, message: "Password must be at least 8 characters." };
  }

  const supabase = await createClient();
  const siteUrl = await getSiteUrl();
  const next = redirectTargetFor(intent);

  const { data, error } = await supabase.auth.signUp({
    email,
    password,
    options: {
      emailRedirectTo: `${siteUrl}/auth/callback?next=${encodeURIComponent(next)}`,
    },
  });

  if (error) {
    console.error("[signUpWithPassword]", error.status, error.message);
    return { ok: false, message: error.message || "Couldn't create that account. Try again." };
  }

  if (data.user && (school || academicStatus)) {
    const admin = createAdminClient();
    await admin.from("profiles").update({ school, academic_status: academicStatus }).eq("id", data.user.id);
  }

  if (data.session) {
    // Email confirmation isn't required on this project — already signed in.
    redirect(next);
  }

  return { ok: true, needsConfirmation: true, email };
}

export type SignupSubmitResult =
  | { kind: "magic_link"; email: string; intent: string }
  | { kind: "password_confirm"; email: string }
  | { kind: "error"; message: string }
  | null;

/**
 * Single entry point SignupForm's one form submits to — branches to
 * signUpWithPassword above when a password was entered, sendSignupMagicLink
 * otherwise, and normalizes both into one result shape so the form only
 * needs one useActionState hook. Both underlying functions may redirect()
 * on success (a thrown Next.js signal, not a real exception) — that
 * propagates through this wrapper exactly like it would through a direct
 * call, so a successful password signup with immediate session still
 * navigates away without this function needing to do anything extra.
 */
export async function submitSignup(_prev: SignupSubmitResult, formData: FormData): Promise<SignupSubmitResult> {
  const password = String(formData.get("password") ?? "");

  if (password) {
    const result = await signUpWithPassword(null, formData);
    if (!result) return null;
    if (!result.ok) return { kind: "error", message: result.message };
    return { kind: "password_confirm", email: result.email };
  }

  const result = await sendSignupMagicLink(null, formData);
  if (!result.ok) return { kind: "error", message: result.message };
  return { kind: "magic_link", email: result.email, intent: result.intent };
}
