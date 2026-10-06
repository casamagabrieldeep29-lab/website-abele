/**
 * Optional diagnostic: set SUPABASE_EGRESS_LOG=1 (locally or in Vercel env) and
 * every Supabase response made by server code is logged with its size, e.g.
 *   [egress] 41.2KB  GET /rest/v1/reviewer_entries?select=...
 * Also set SUPABASE_EGRESS_LOG_FILE=<path> to append "epochMs bytes method path" lines to a
 * file for scripted analysis. Off by default (zero overhead). Supabase Free caps egress at 5 GB/month, so
 * when usage jumps, turn this on for an hour and sort the logs by size to find
 * the query responsible instead of guessing.
 */
export const supabaseFetch: typeof fetch | undefined =
  process.env.SUPABASE_EGRESS_LOG === "1"
    ? async (input, init) => {
        const res = await fetch(input, init);
        try {
          const declared = Number(res.headers.get("content-length"));
          const bytes = declared > 0 ? declared : (await res.clone().arrayBuffer()).byteLength;
          const url = new URL(typeof input === "string" ? input : input instanceof URL ? input.href : input.url);
          const path = (url.pathname + url.search).slice(0, 140);
          console.log(`[egress] ${(bytes / 1024).toFixed(1).padStart(8)}KB  ${(init?.method ?? "GET").padEnd(5)} ${path}`);
          const file = process.env.SUPABASE_EGRESS_LOG_FILE;
          if (file) {
            const { appendFileSync } = await import("node:fs");
            appendFileSync(file, `${Date.now()} ${bytes} ${init?.method ?? "GET"} ${path}\n`);
          }
        } catch {
          // Logging must never affect the request.
        }
        return res;
      }
    : undefined;
