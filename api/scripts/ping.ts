import { loadDevVars } from "./env";

// Connectivity check for the Turso settings. Prints only status codes and short messages, never the token.
loadDevVars();
const url = (process.env.TURSO_URL ?? "").replace(/^libsql:\/\//, "https://");
const token = process.env.TURSO_TOKEN ?? "";
console.log("token shape: length", token.length, "| looks like a JWT (3 dot-separated parts):", token.split(".").length === 3);
const res = await fetch(`${url}/v2/pipeline`, {
  method: "POST",
  headers: { Authorization: `Bearer ${token}`, "Content-Type": "application/json" },
  body: JSON.stringify({ requests: [{ type: "execute", stmt: { sql: "SELECT 1 AS ok" } }, { type: "close" }] }),
});
const text = await res.text();
console.log("status:", res.status, "|", text.slice(0, 160).replace(token, "[token]"));
