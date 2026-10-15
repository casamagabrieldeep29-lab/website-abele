import { createClient } from "@libsql/client";
import { mkdirSync } from "node:fs";
import { applyMigrations } from "../src/migrate";
import { loadDevVars } from "./env";

loadDevVars();

// Production: TURSO_URL + TURSO_TOKEN from the environment. Local default: a file database
// in api/.local/ so nothing needs a login while developing.
mkdirSync(".local", { recursive: true });
const url = process.env.TURSO_URL ?? "file:.local/abeliever.db";
const client = createClient({ url, authToken: process.env.TURSO_TOKEN });
const applied = await applyMigrations(client);
console.log(applied.length ? `applied: ${applied.join(", ")}` : "database is up to date");
client.close();
