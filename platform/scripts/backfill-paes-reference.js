// Backfills reviewer_entries.paes_reference by parsing "PAES <number>" out of
// each row's title (e.g. "PAES 401 — Swine Housing: Definitions" -> "PAES 401").
// Idempotent: only touches rows where paes_reference is currently null and the
// title actually matches. Run after 027_paes_reviewer_entries.sql has been
// applied (adds the column) — errors clearly if the column doesn't exist yet.
//
// Usage: node scripts/backfill-paes-reference.js

require("dotenv").config({ path: ".env.local" });
const { createClient } = require("@supabase/supabase-js");

const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL,
  process.env.SUPABASE_SERVICE_ROLE_KEY,
);

const PAES_TITLE_RE = /PAES\s+(\d{3,4})/i;

async function main() {
  const { data: rows, error } = await supabase
    .from("reviewer_entries")
    .select("id, title, paes_reference")
    .is("paes_reference", null);

  if (error) {
    console.error("Query failed (has the 027 migration been applied yet?):", error.message);
    process.exit(1);
  }

  console.log(`Found ${rows.length} rows with paes_reference IS NULL.`);

  let updated = 0;
  let skipped = 0;
  for (const row of rows) {
    const match = row.title.match(PAES_TITLE_RE);
    if (!match) {
      skipped++;
      continue;
    }
    const paesReference = `PAES ${match[1]}`;
    const { error: updateError } = await supabase
      .from("reviewer_entries")
      .update({ paes_reference: paesReference })
      .eq("id", row.id);
    if (updateError) {
      console.error(`Failed to update ${row.id} (${row.title}):`, updateError.message);
      continue;
    }
    updated++;
  }

  console.log(`Updated: ${updated}. Skipped (no "PAES <number>" in title): ${skipped}.`);

  const { count } = await supabase
    .from("reviewer_entries")
    .select("id", { count: "exact", head: true })
    .not("paes_reference", "is", null);
  console.log(`Total rows now tagged with paes_reference: ${count}.`);
}

main();
