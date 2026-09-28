import "server-only";
import { GoogleGenAI } from "@google/genai";
import { collectApiKeys } from "./ai";
import { logError } from "./log-error";

export type ReceiptVerification = { verified: boolean; reason: string };

async function askGemini(
  apiKey: string,
  model: string,
  imageBase64: string,
  mimeType: string,
  referenceNumber: string,
): Promise<ReceiptVerification> {
  const client = new GoogleGenAI({ apiKey });
  const response = await client.models.generateContent({
    model,
    contents: [
      {
        role: "user",
        parts: [
          { inlineData: { mimeType, data: imageBase64 } },
          {
            text:
              "This is a screenshot of a GCash/Maya/bank payment confirmation. Check two things strictly — " +
              "when in doubt, answer no rather than guessing yes:\n\n" +
              `(1) REFERENCE NUMBER: the screenshot must show a reference/transaction number that is an EXACT ` +
              `digit-for-digit match to "${referenceNumber}" (you may ignore spacing, dashes, and letter case ` +
              "as pure formatting differences, but every digit must be present and correct — a number that is " +
              "merely similar, a substring, or has even one digit different does NOT count as a match, and " +
              "neither does a reference number that is partially cut off or unreadable in the image).\n\n" +
              '(2) RECIPIENT NAME: the screenshot must show the RECIPIENT (the person being paid, not the ' +
              'sender) as "Gabriel Deep C. Casama", or a partially-masked/truncated version of it (e.g. ' +
              '"GA***L D... C*****A", "Gabriel D. C...", "GA....L DE.P C.", or initials "GDC") — payment apps ' +
              "commonly mask characters with dots/asterisks AND separately cut the display off partway through " +
              "a long name for space, so the surname is frequently not shown at all even on a fully legitimate " +
              "receipt. Treat a name that's simply cut short before the surname (no surname shown, nothing " +
              "shown that conflicts with it) as a MATCH, not a mismatch — only answer no here if a visible " +
              "character actively conflicts with this specific name (e.g. a different first name, or a surname " +
              "that IS shown and doesn't match), not merely because part of the name wasn't displayed.\n\n" +
              "Both conditions must clearly hold for a yes. Reply with EXACTLY one line in this format: " +
              "VERIFIED: <yes|no> | REASON: <one short sentence>.",
          },
        ],
      },
    ],
  });

  const text = response.text?.trim() ?? "";
  const match = /VERIFIED:\s*(yes|no)\s*\|\s*REASON:\s*(.+)/i.exec(text);
  if (!match) throw new Error(`Unclear AI response: ${text.slice(0, 200)}`);
  return { verified: match[1].toLowerCase() === "yes", reason: match[2].trim() };
}

function sleep(ms: number): Promise<void> {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

// A 503 ("model is currently experiencing high demand... temporary") is a
// different failure mode from a 429 quota error — the SAME key usually
// works again a couple seconds later, unlike an exhausted daily quota where
// retrying that key is pointless and the next key should be tried instead.
function isTransientOverload(err: unknown): boolean {
  const message = err instanceof Error ? err.message : String(err);
  return /"code":\s*503|UNAVAILABLE|overloaded|high demand/i.test(message);
}

const OVERLOAD_RETRY_DELAYS_MS = [1500, 3000];

async function askGeminiWithRetry(
  apiKey: string,
  model: string,
  imageBase64: string,
  mimeType: string,
  referenceNumber: string,
): Promise<ReceiptVerification> {
  for (let attempt = 0; ; attempt++) {
    try {
      return await askGemini(apiKey, model, imageBase64, mimeType, referenceNumber);
    } catch (err) {
      if (attempt >= OVERLOAD_RETRY_DELAYS_MS.length || !isTransientOverload(err)) throw err;
      await sleep(OVERLOAD_RETRY_DELAYS_MS[attempt]);
    }
  }
}

/**
 * Asks Gemini's vision model whether an uploaded payment-receipt screenshot
 * plausibly shows the given reference number and Gabriel's name/initials as
 * the recipient — the actual gate for auto-approval on /upgrade (Gabriel's
 * explicit "the picture they upload should match the reference and should
 * show my name initials", 2026-09-28).
 *
 * Tries every configured GEMINI_API_KEY / GEMINI_API_KEY_2 / _3 / ... in
 * order (Gabriel's explicit "i dont want to pay. lets find many more",
 * 2026-09-28) — same collectApiKeys()/one-key-per-free-account pattern
 * already used by getAIProvider() for Teach Me This/Study Assistant, so one
 * account's free-tier daily quota (500/day) running out falls through to
 * the next account's separate allowance instead of failing the request.
 * Add more free accounts' keys as GEMINI_API_KEY_2, _3, ... in Vercel to
 * raise the effective ceiling further; no code change needed for each one.
 * Separately, a transient "model overloaded" 503 (Gabriel's explicit report,
 * 2026-09-28) gets a couple of short retries on the SAME key first — unlike
 * a 429 quota error, an overload usually clears within seconds, so moving
 * straight to the next key isn't necessary.
 *
 * Never throws, and never auto-approves on an inconclusive result: any
 * failure (no key configured, every key's API call failing, unparseable
 * answer) returns verified:false so the request safely falls back to manual
 * review at /admin/payments rather than granting access on a check that
 * didn't actually confirm anything.
 */
export async function verifyReceipt(
  imageBase64: string,
  mimeType: string,
  referenceNumber: string,
): Promise<ReceiptVerification> {
  const apiKeys = collectApiKeys("GEMINI_API_KEY");
  if (apiKeys.length === 0) return { verified: false, reason: "No AI key configured to check receipts automatically." };

  const model = process.env.GEMINI_MODEL ?? "gemini-3.1-flash-lite";
  let lastErr: unknown = null;
  for (const apiKey of apiKeys) {
    try {
      return await askGeminiWithRetry(apiKey, model, imageBase64, mimeType, referenceNumber);
    } catch (err) {
      lastErr = err;
    }
  }
  // Every configured key failed — actionable (add another free account's
  // key), unlike a single request's transient error, so this is worth an
  // alert rather than just a console.error.
  await logError(`receipt-verification (${apiKeys.length} key(s) tried)`, lastErr);
  return { verified: false, reason: describeVerificationError(lastErr) };
}

// Gemini's SDK throws with the raw HTTP error body as the message (a wall of
// JSON) — showing that verbatim as the admin-facing note on /admin/payments
// is unreadable, so recognize the common cases (namely the free-tier daily
// quota, which is easy to hit and not actionable per-request) and otherwise
// fall back to a short, truncated message instead of the full blob.
function describeVerificationError(err: unknown): string {
  const message = err instanceof Error ? err.message : String(err);
  if (/RESOURCE_EXHAUSTED|"code":\s*429/.test(message) || isTransientOverload(err)) {
    return "AI explanation is temporarily unavailable. Please try again.";
  }
  return `Receipt check failed: ${message.slice(0, 150)}`;
}
