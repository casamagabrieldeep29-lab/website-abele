import "server-only";

/**
 * Central error reporter for server-side failures that matter (payments,
 * auth, AI verification) — flagged 2026-09-28 that production errors were
 * only ever console.error'd, invisible unless someone happened to check
 * Vercel's logs. Posts to a Slack/Discord "Incoming Webhook" URL when
 * ERROR_WEBHOOK_URL is set (both accept the same simple {"text": "..."}
 * payload, so either works with zero extra code).
 *
 * Deliberately NOT a full APM SDK (Sentry etc.): this Next.js version has
 * enough undocumented breaking changes from a normal Next release (see
 * AGENTS.md) that adding a build-time-instrumenting SDK blind, with no way
 * to verify it against a live preview in this sandbox (Google Fonts blocks
 * that), is a bigger risk than it's worth right now. This is the pragmatic
 * first step — swap in a real APM later once that tradeoff changes.
 *
 * Never throws — a broken webhook must never crash the request whose error
 * it's trying to report.
 */
export async function logError(context: string, err: unknown): Promise<void> {
  const message = err instanceof Error ? err.message : String(err);
  console.error(`[${context}]`, message);

  const webhookUrl = process.env.ERROR_WEBHOOK_URL;
  if (!webhookUrl) return;

  try {
    await fetch(webhookUrl, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ text: `🚨 ABELIEVER error [${context}]: ${message.slice(0, 500)}` }),
    });
  } catch (webhookErr) {
    console.error("[logError] webhook delivery failed:", webhookErr instanceof Error ? webhookErr.message : webhookErr);
  }
}
