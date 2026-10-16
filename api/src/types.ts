export type Row = Record<string, string | number | null>;
export type Stmt = { sql: string; args?: (string | number | null)[] };

/** Minimal database surface the app needs, so tests can use an in-memory libSQL file. */
export type Db = {
  query(sql: string, args?: (string | number | null)[]): Promise<Row[]>;
  batch(stmts: Stmt[]): Promise<void>;
};

export type AuthUser = { id: string; email: string | null };

export type Env = {
  TURSO_URL?: string;
  TURSO_TOKEN?: string;
  /** Shared secret the Next.js server sends as X-Internal-Key (server-to-server, never in a browser). */
  INTERNAL_KEY?: string;
  AUTH_JWKS_URL?: string;
  SUPABASE_URL?: string;
  ALLOWED_ORIGINS?: string;
  RATE_LIMITER?: { limit(o: { key: string }): Promise<{ success: boolean }> };
};
