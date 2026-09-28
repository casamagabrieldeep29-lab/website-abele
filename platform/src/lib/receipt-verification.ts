import "server-only";
import { GoogleGenAI } from "@google/genai";

export type ReceiptVerification = { verified: boolean; reason: string };

/**
 * Asks Gemini's vision model whether an uploaded payment-receipt screenshot
 * plausibly shows the given reference number and Gabriel's name/initials as
 * the recipient — the actual gate for auto-approval on /upgrade (Gabriel's
 * explicit "the picture they upload should match the reference and should
 * show my name initials", 2026-09-28).
 *
 * Never throws, and never auto-approves on an inconclusive result: any
 * failure (no key configured, API error, unparseable answer) returns
 * verified:false so the request safely falls back to manual review at
 * /admin/payments rather than granting access on a check that didn't
 * actually confirm anything.
 */
export async function verifyReceipt(
  imageBase64: string,
  mimeType: string,
  referenceNumber: string,
): Promise<ReceiptVerification> {
  const apiKey = process.env.GEMINI_API_KEY;
  if (!apiKey) return { verified: false, reason: "No AI key configured to check receipts automatically." };

  try {
    const client = new GoogleGenAI({ apiKey });
    const model = process.env.GEMINI_MODEL ?? "gemini-3.1-flash-lite";
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
    if (!match) return { verified: false, reason: `Unclear AI response: ${text.slice(0, 200)}` };
    return { verified: match[1].toLowerCase() === "yes", reason: match[2].trim() };
  } catch (err) {
    return {
      verified: false,
      reason: `Receipt check failed: ${err instanceof Error ? err.message : "unknown error"}`,
    };
  }
}
