import { createRemoteJWKSet, jwtVerify } from "jose";
import type { AuthUser, Env } from "./types";

let jwks: ReturnType<typeof createRemoteJWKSet> | null = null;

/** Verifies a Supabase access token (keys from the project's JWKS endpoint, cached per Worker instance). */
export async function verifySupabaseToken(token: string, env: Env): Promise<AuthUser | null> {
  if (!env.AUTH_JWKS_URL) return null;
  try {
    jwks ??= createRemoteJWKSet(new URL(env.AUTH_JWKS_URL));
    const { payload } = await jwtVerify(token, jwks);
    if (!payload.sub) return null;
    return { id: String(payload.sub), email: (payload.email as string) || null };
  } catch (e) {
    // Reason only (e.g. ERR_JWT_EXPIRED). Never log the token.
    console.log("auth rejected:", (e as { code?: string }).code ?? (e as Error).name);
    return null;
  }
}
