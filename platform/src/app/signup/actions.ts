"use server";

import { createAdminClient } from "@/lib/supabase/admin";
import { createClient } from "@/lib/supabase/server";
import { submitPaymentRequest } from "@/app/upgrade/actions";
import type { PaymentMethodKey } from "@/lib/payment-methods";

const VALID_METHODS: PaymentMethodKey[] = ["gcash", "maya", "landbank"];
const VALID_ACADEMIC_STATUSES = ["student", "reviewee"] as const;
type AcademicStatus = (typeof VALID_ACADEMIC_STATUSES)[number];

function readAcademicFields(formData: FormData): { school: string | null; academicStatus: AcademicStatus | null } {
  const school = String(formData.get("school") ?? "").trim();
  const academicStatusRaw = String(formData.get("academicStatus") ?? "");
  const academicStatus = VALID_ACADEMIC_STATUSES.includes(academicStatusRaw as AcademicStatus)
    ? (academicStatusRaw as AcademicStatus)
    : null;
  return { school: school || null, academicStatus };
}

export type SignUpAndSubmitPaymentResult = { ok: false; message: string } | null;

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
  const { school, academicStatus } = readAcademicFields(formData);

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
  await admin.from("profiles").update(profileUpdate).eq("id", created.user.id);

  const supabase = await createClient();
  const { error: signInError } = await supabase.auth.signInWithPassword({ email, password });
  if (signInError) {
    console.error("[signUpAndSubmitPayment] signInWithPassword", signInError.status, signInError.message);
    return { ok: false, message: "Your account was created, but signing you in failed — try signing in manually." };
  }

  await submitPaymentRequest(formData);
  return null;
}

export type SignupSubmitResult = { kind: "error"; message: string } | null;

/** Single entry point SignupForm's one form submits to — always a payment method + reference number + receipt, always through signUpAndSubmitPayment. May redirect() on success (a thrown Next.js signal, not a real exception), which propagates through this wrapper exactly like it would through a direct call. */
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
  if (!result) return null;
  return { kind: "error", message: result.message };
}
