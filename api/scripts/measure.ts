/** Measures each endpoint against the local exported database: bytes, time and database rows. */
import { createClient } from "@libsql/client";
import { createApp } from "../src/app";
import { makeDb, type DbStats } from "../src/db";

const client = createClient({ url: "file:.local/abeliever.db" });
const ids = (await client.execute("SELECT id FROM questions ORDER BY id LIMIT 20")).rows.map((r) => String(r.id));

async function run(label: string, path: string) {
  const stats: DbStats = { statements: 0, rowsReturned: 0 };
  const app = createApp({
    db: makeDb(() => client, stats),
    env: {},
    verifyToken: async () => ({ id: "u", email: null }),
  });
  const t0 = performance.now();
  const res = await app.request(path, { headers: { authorization: "Bearer x" } });
  const text = await res.text();
  const ms = performance.now() - t0;
  console.log(`${label.padEnd(26)} ${String(res.status)}  ${(text.length / 1024).toFixed(1).padStart(8)} KB  ${ms.toFixed(0).padStart(5)} ms  db statements ${stats.statements}, rows ${stats.rowsReturned}`);
}

await run("taxonomy", "/v1/taxonomy");
await run("snapshot (all ids)", "/v1/snapshot");
await run("questions x1", `/v1/questions?ids=${ids[0]}`);
await run("questions x10 (a session)", `/v1/questions?ids=${ids.slice(0, 10).join(",")}`);
await run("questions x20", `/v1/questions?ids=${ids.join(",")}`);
client.close();
