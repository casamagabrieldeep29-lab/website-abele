"use server";

import { createAdminClient } from "@/lib/supabase/admin";
import { createClient } from "@/lib/supabase/server";
import { submitPaymentRequest } from "@/app/upgrade/actions";
import type { PaymentMethodKey } from "@/lib/payment-methods";
import { checkRateLimit, getClientIp } from "@/lib/rate-limit";
import { logError } from "@/lib/log-error";

// Account creation has no CAPTCHA and is fully scriptable otherwise — two
// tiers, same reasoning as login/actions.ts's checkLoginRateLimit (fixed
// 2026-10-02 after the same single-IP-bucket design locked out real users
// sharing a carrier-NAT IP): a tight per (IP, email) pair stops repeat
// signup spam for the one address, and a much looser per-IP ceiling is a
// backstop against pure scripted mass account creation, wide enough to
// absorb a real burst of organic signups from one shared network.
const SIGNUP_PAIR_LIMIT = 3;
const SIGNUP_PAIR_WINDOW_SECONDS = 60 * 60;
const SIGNUP_IP_LIMIT = 30;
const SIGNUP_IP_WINDOW_SECONDS = 60 * 60;

const VALID_METHODS: PaymentMethodKey[] = ["gcash", "maya", "landbank"];
const VALID_ACADEMIC_STATUSES = ["student", "reviewee"] as const;
type AcademicStatus = (typeof VALID_ACADEMIC_STATUSES)[number];

function readOptionalProfileFields(formData: FormData): {
  school: string | null;
  academicStatus: AcademicStatus | null;
  address: string | null;
} {
  const school = String(formData.get("school") ?? "").trim();
  const academicStatusRaw = String(formData.get("academicStatus") ?? "");
  const academicStatus = VALID_ACADEMIC_STATUSES.includes(academicStatusRaw as AcademicStatus)
    ? (academicStatusRaw as AcademicStatus)
    : null;
  const address = String(formData.get("address") ?? "").trim();
  return { school: school || null, academicStatus, address: address || null };
}

export type SignUpAndSubmitPaymentResult =
  | { ok: true; autoApproved: boolean }
  | { ok: false; message: string };

/**
 * The only self-serve signup path — per Gabriel's "let's not have free
 * trial. all must pay. and upload their reference. and the screenshot of
 * receipt" (2026-09-28): no more "skip payment, start a free trial" branch.
 * admin.createUser() with email_confirm: true creates an already-confirmed
 * account directly (no confirmation email round trip), the student is
 * signed in immediately with the password they just set, their profile is
 * explicitly moved off the 'trial' column default to 'pending' (see patch
 * 043_pending_plan.sql — proxy.ts gates 'pending' unconditionally, same as
 * an expired trial, until an admin approves the payment at /admin/payments),
 * and their payment is submitted through the exact same submitPaymentRequest()
 * /upgrade itself uses (now-required receipt upload + AI verification +
 * payment_requests insert) — reused, not reimplemented, now that a real
 * session exists for it to read via supabase.auth.getUser(). That call may
 * flip 'pending' straight to 'subscriber' if the receipt auto-approves.
 */
export async function signUpAndSubmitPayment(formData: FormData): Promise<SignUpAndSubmitPaymentResult> {
  const email = String(formData.get("email") ?? "").trim();
  const password = String(formData.get("password") ?? "");
  const fullName = String(formData.get("fullName") ?? "").trim();
  const { school, academicStatus, address } = readOptionalProfileFields(formData);

  if (!email || !email.includes("@")) {
    return { ok: false, message: "Enter a valid email address." };
  }
  if (!fullName) {
    return { ok: false, message: "Enter your full name." };
  }
  if (password.length < 8) {
    return {
      ok: false,
      message: "Set a password (at least 8 characters) — this lets us create your account instantly, no email wait.",
    };
  }

  const ip = await getClientIp();
  const [pairAllowed, ipAllowed] = await Promise.all([
    checkRateLimit(`signup:${ip}:${email.toLowerCase()}`, SIGNUP_PAIR_LIMIT, SIGNUP_PAIR_WINDOW_SECONDS),
    checkRateLimit(`signup-ip:${ip}`, SIGNUP_IP_LIMIT, SIGNUP_IP_WINDOW_SECONDS),
  ]);
  if (!pairAllowed) {
    return { ok: false, message: "Too many signup attempts for that address. Please wait a bit and try again." };
  }
  if (!ipAllowed) {
    return { ok: false, message: "Too many signup attempts from your network. Please wait a bit and try again." };
  }

  const admin = createAdminClient();
  const { data: created, error: createError } = await admin.auth.admin.createUser({
    email,
    password,
    email_confirm: true,
  });

  if (createError || !created.user) {
    console.error("[signUpAndSubmitPayment] createUser", createError?.status, createError?.message);
    return { ok: false, message: createError?.message ?? "Couldn't create that account. Try again." };
  }

  const profileUpdate: Record<string, string | null> = { plan: "pending", display_name: fullName };
  if (school) profileUpdate.school = school;
  if (academicStatus) profileUpdate.academic_status = academicStatus;
  if (address) profileUpdate.address = address;
  await admin.from("profiles").update(profileUpdate).eq("id", created.user.id);

  const supabase = await createClient();
  const { error: signInError } = await supabase.auth.signInWithPassword({ email, password });
  if (signInError) {
    await logError("signUpAndSubmitPayment.signInWithPassword", signInError);
    return { ok: false, message: "Your account was created, but signing you in failed — try signing in manually." };
  }

  const paymentResult = await submitPaymentRequest(null, formData);
  if (!paymentResult?.ok) {
    if (paymentResult?.error === "duplicate-reference") {
      return {
        ok: false,
        message:
          "That reference number has already been used for another account. Double-check what you typed, or message us if you believe this is a mistake.",
      };
    }
    await logError("signUpAndSubmitPayment.submitPaymentRequest", paymentResult?.error ?? "no result returned");
    return {
      ok: false,
      message:
        "Your account was created, but submitting your payment failed — sign in and try again from /upgrade.",
    };
  }
  return { ok: true, autoApproved: paymentResult.autoApproved };
}

export type SignupSubmitResult =
  | { kind: "error"; message: string }
  | { kind: "payment_result"; autoApproved: boolean }
  | null;

/** Single entry point SignupForm's one form submits to — always a payment method + reference number + receipt, always through signUpAndSubmitPayment. Returns a "payment_result" on success (instead of redirecting itself) so the client can hold it behind the same delayed-reveal spinner as /upgrade's own form — see submitPaymentRequest's doc comment for why that delay can't live server-side. */
export async function submitSignup(_prev: SignupSubmitResult, formData: FormData): Promise<SignupSubmitResult> {
  const intent = String(formData.get("intent") ?? "");

  if (!VALID_METHODS.includes(intent as PaymentMethodKey)) {
    return { kind: "error", message: "Pick a payment method to continue." };
  }

  if (!String(formData.get("fullName") ?? "").trim()) {
    return { kind: "error", message: "Enter your full name." };
  }

  const referenceNumber = String(formData.get("referenceNumber") ?? "").trim();
  if (!referenceNumber) {
    return { kind: "error", message: "Enter your payment reference number to continue." };
  }

  const receipt = formData.get("receipt");
  if (!(receipt instanceof File) || receipt.size === 0) {
    return { kind: "error", message: "Attach a screenshot of your receipt to continue." };
  }

  const result = await signUpAndSubmitPayment(formData);
  if (!result.ok) return { kind: "error", message: result.message };
  return { kind: "payment_result", autoApproved: result.autoApproved };
}
