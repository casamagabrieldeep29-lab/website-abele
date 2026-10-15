import { existsSync, readFileSync } from "node:fs";

/** Loads KEY=value lines from api/.dev.vars (git-ignored) into process.env, without overriding real env vars. */
export function loadDevVars(path = ".dev.vars") {
  if (!existsSync(path)) return;
  for (const line of readFileSync(path, "utf8").split(/\r?\n/)) {
    const m = /^([A-Z_]+)=(.*)$/.exec(line);
    if (m && !(m[1] in process.env)) process.env[m[1]] = m[2].trim().replace(/^["']|["']$/g, "");
  }
}
