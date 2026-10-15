import { createClient } from "@libsql/client/web";
import { createApp } from "./app";
import { verifySupabaseToken } from "./auth";
import { makeDb, type DbStats } from "./db";
import { SQL } from "./sql";
import type { Env } from "./types";

const turso = (env: Env) => () => createClient({ url: env.TURSO_URL!, authToken: env.TURSO_TOKEN });

export default {
  async fetch(req: Request, env: Env): Promise<Response> {
    const stats: DbStats = { statements: 0, rowsReturned: 0 };
    const cache = (globalThis as unknown as { caches?: { default: Cache } }).caches?.default;
    const app = createApp({
      db: makeDb(turso(env), stats),
      env,
      verifyToken: (t) => verifySupabaseToken(t, env),
      cache: cache
        ? {
            match: async (url) => cache.match(new Request(url)),
            put: async (url, res) => cache.put(new Request(url), res),
          }
        : undefined,
    });
    const res = await app.fetch(req);
    // Row usage per request. Visible in Workers Logs; costs no database work.
    if (stats.statements) console.log("db", new URL(req.url).pathname, JSON.stringify(stats));
    return res;
  },

  // Daily keep-alive: free Turso databases are archived after about 10 idle days.
  async scheduled(_e: unknown, env: Env) {
    await makeDb(turso(env)).query(SQL.keepalive);
  },
};
