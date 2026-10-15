import type { Client } from "@libsql/client";
import { MIGRATIONS } from "./migrations";

/** Applies migrations not yet recorded in _migrations, in order. Returns the ids it applied. */
export async function applyMigrations(client: Client, now = Date.now()): Promise<string[]> {
  await client.execute("CREATE TABLE IF NOT EXISTS _migrations (id TEXT PRIMARY KEY, applied_at INTEGER NOT NULL)");
  const done = new Set((await client.execute("SELECT id FROM _migrations")).rows.map((r) => String(r.id)));
  const applied: string[] = [];
  for (const m of MIGRATIONS) {
    if (done.has(m.id)) continue;
    await client.executeMultiple(m.sql);
    await client.execute({ sql: "INSERT INTO _migrations (id, applied_at) VALUES (?, ?)", args: [m.id, now] });
    applied.push(m.id);
  }
  return applied;
}
