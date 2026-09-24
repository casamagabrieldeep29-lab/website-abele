import "server-only";

const RESEND_ENDPOINT = "https://api.resend.com/emails";

/**
 * Sends one email via Resend's API. Inert (silently no-ops) when
 * RESEND_API_KEY isn't set, so a missing/misconfigured key never breaks
 * whatever feature triggered the email — same "optional until configured"
 * pattern as the AI providers in src/lib/ai/. Without a verified sending
 * domain on the Resend account, RESEND_FROM_EMAIL falls back to Resend's
 * shared sandbox address, which can only deliver to the Resend account's
 * own signup address — see the caller for what that means for reaching
 * real students.
 */
export async function sendEmail({ to, subject, html }: { to: string; subject: string; html: string }): Promise<void> {
  const apiKey = process.env.RESEND_API_KEY;
  if (!apiKey) return;

  const from = process.env.RESEND_FROM_EMAIL ?? "ABELIEVER <onboarding@resend.dev>";

  const response = await fetch(RESEND_ENDPOINT, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      Authorization: `Bearer ${apiKey}`,
    },
    body: JSON.stringify({ from, to, subject, html }),
  });

  if (!response.ok) {
    const body = await response.text().catch(() => "");
    console.error(`[email] Resend request failed (${response.status}): ${body.slice(0, 300)}`);
  }
}
