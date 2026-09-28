import { NextRequest, NextResponse } from "next/server";
import { logError } from "@/lib/log-error";
import { checkRateLimit, getClientIp } from "@/lib/rate-limit";

// Lets app/error.tsx and app/global-error.tsx (Client Components — they
// can't import the server-only logError directly) report a real render
// crash the same way server-side failures already are. No auth required —
// a crash can happen to a signed-out visitor too — so this is IP rate
// limited (a real user hitting genuine crashes won't come close to 10/5min;
// this is purely to stop someone scripting POSTs here to spam the webhook).
const LIMIT = 10;
const WINDOW_SECONDS = 5 * 60;

export async function POST(req: NextRequest) {
  const ip = await getClientIp();
  const allowed = await checkRateLimit(`log-client-error:${ip}`, LIMIT, WINDOW_SECONDS);
  if (!allowed) return NextResponse.json({ ok: false }, { status: 429 });

  let body: { context?: string; message?: string };
  try {
    body = await req.json();
  } catch {
    return NextResponse.json({ ok: false }, { status: 400 });
  }

  const context = String(body.context ?? "client").slice(0, 100);
  const message = String(body.message ?? "unknown client error").slice(0, 500);
  await logError(context, new Error(message));

  return NextResponse.json({ ok: true });
}
