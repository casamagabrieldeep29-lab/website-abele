import "server-only";
import { GoogleGenAI } from "@google/genai";
import { collectApiKeys } from "./ai";

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
              'sender) as "Gabriel Deep C. Casama", or a partially-masked version of it (e.g. "GA***L D... ' +
              'C*****A", "Gabriel D. C...", or initials "GDC") — payment apps commonly mask part of a name ' +
              "with dots or asterisks. The visible characters must be consistent with this specific name, not " +
              "just any name.\n\n" +
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
      return await askGemini(apiKey, model, imageBase64, mimeType, referenceNumber);
    } catch (err) {
      lastErr = err;
    }
  }
  return { verified: false, reason: describeVerificationError(lastErr) };
}

// Gemini's SDK throws with the raw HTTP error body as the message (a wall of
// JSON) — showing that verbatim as the admin-facing note on /admin/payments
// is unreadable, so recognize the common cases (namely the free-tier daily
// quota, which is easy to hit and not actionable per-request) and otherwise
// fall back to a short, truncated message instead of the full blob.
function describeVerificationError(err: unknown): string {
  const message = err instanceof Error ? err.message : String(err);
  if (/RESOURCE_EXHAUSTED|"code":\s*429/.test(message)) {
    return "AI explanation is temporarily unavailable. Please try again.";
  }
  return `Receipt check failed: ${message.slice(0, 150)}`;
}
