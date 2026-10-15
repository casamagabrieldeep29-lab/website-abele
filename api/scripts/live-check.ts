/**
 * Live check of the deployed Worker with a REAL Supabase login. Creates a throwaway account (random
 * password, never printed), signs in, calls the Worker, then deletes the account. Prints only
 * statuses, sizes and timings.
 */
import { existsSync, readFileSync } from "node:fs";
import { randomBytes } from "node:crypto";

function loadEnv(path: string) {
  if (!existsSync(path)) return;
  for (const line of readFileSync(path, "utf8").split(/\r?\n/)) {
    const m = /^([A-Z_]+)=(.*)$/.exec(line);
    if (m && !(m[1] in process.env)) process.env[m[1]] = m[2].trim().replace(/^["']|["']$/g, "");
  }
}
loadEnv("../platform/.env.local");
const URL_ = process.env.NEXT_PUBLIC_SUPABASE_URL!, ANON = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!, SERVICE = process.env.SUPABASE_SERVICE_ROLE_KEY!;
const API = "https://api.abelieverofficial.com";

const email = `api-live-check-${Date.now()}@abeliever.invalid`;
const password = randomBytes(18).toString("base64url");
let userId = "";
try {
  const created = await fetch(`${URL_}/auth/v1/admin/users`, {
    method: "POST",
    headers: { apikey: SERVICE, Authorization: `Bearer ${SERVICE}`, "Content-Type": "application/json" },
    body: JSON.stringify({ email, password, email_confirm: true }),
  });
  userId = ((await created.json()) as { id?: string }).id ?? "";
  console.log("test account created:", created.status);

  const login = await fetch(`${URL_}/auth/v1/token?grant_type=password`, {
    method: "POST",
    headers: { apikey: ANON, "Content-Type": "application/json" },
    body: JSON.stringify({ email, password }),
  });
  const token = ((await login.json()) as { access_token?: string }).access_token ?? "";
  console.log("sign-in:", login.status, "| token received:", token.length > 100);

  const call = async (label: string, path: string) => {
    const t0 = performance.now();
    const res = await fetch(API + path, { headers: { Authorization: `Bearer ${token}` } });
    const body = await res.text();
    console.log(`${label.padEnd(24)} ${res.status}  ${(body.length / 1024).toFixed(1).padStart(7)} KB  ${(performance.now() - t0).toFixed(0).padStart(5)} ms  cache-control: ${res.headers.get("cache-control")}`);
    return body;
  };
  await call("taxonomy", "/v1/taxonomy");
  const snap = JSON.parse(await call("snapshot (cold)", "/v1/snapshot")) as { ids: string[] };
  await call("snapshot (repeat)", "/v1/snapshot");
  const ids = snap.ids.slice(0, 10);
  const qBody = await call("questions x10", `/v1/questions?ids=${ids.join(",")}`);
  await call("questions x10 (repeat)", `/v1/questions?ids=${ids.join(",")}`);
  const qs = JSON.parse(qBody) as { choices: unknown[] }[];
  console.log("published ids:", snap.ids.length, "| questions returned:", qs.length, "| 4 choices each:", qs.every((q) => q.choices.length === 4), "| leaks an answer field:", /is_correct|explanation/.test(qBody));
} finally {
  if (userId) {
    const del = await fetch(`${URL_}/auth/v1/admin/users/${userId}`, { method: "DELETE", headers: { apikey: SERVICE, Authorization: `Bearer ${SERVICE}` } });
    console.log("test account deleted:", del.status);
  }
}
