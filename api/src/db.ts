import type { Client } from "@libsql/client";
import type { Db, Row, Stmt } from "./types";

/** Per-request counters, logged so row usage stays visible. */
export type DbStats = { statements: number; rowsReturned: number };

/** Wraps a libSQL client. The client is created on first use, so routes like /health need no database. */
export function makeDb(getClient: () => Client, stats?: DbStats): Db {
  let client: Client | null = null;
  const c = () => (client ??= getClient());
  return {
    async query(sql, args = []) {
      const r = await c().execute({ sql, args });
      if (stats) {
        stats.statements++;
        stats.rowsReturned += r.rows.length;
      }
      return r.rows.map((row) => Object.fromEntries(r.columns.map((col, i) => [col, row[i]])) as Row);
    },
    async batch(stmts: Stmt[]) {
      const rs = await c().batch(stmts.map((s) => ({ sql: s.sql, args: s.args ?? [] })), "write");
      if (stats) for (const r of rs) { stats.statements++; stats.rowsReturned += r.rows.length; }
    },
  };
}
