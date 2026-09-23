// Imports a structured reviewer-content JSON file (formulas/tables/constants
// for the /reviewers page) into Supabase using the service role key.
//
// Usage (run from the platform/ directory):
//   node scripts/import-reviewer-content.js supabase/seed/reviewers/<file>.json
//
// Idempotent: re-running skips topics/subtopics/entries that already exist
// (topics/subtopics matched by name, reviewer_entries matched by exact
// title within the same topic).
//
// JSON shape:
// {
//   "_meta": { "source": "...", "extraction_method": "...", "extracted_date": "...", "topic_mapping_notes": [...] },
//   "topics": [
//     {
//       "exam_area_code": "LAND_WATER",
//       "topic_name": "Existing or new topic name",
//       "subtopics": { "KEY": "Display Name" },   // optional
//       "entries": [
//         {
//           "kind": "formula",              // "formula" | "table" | "constant"
//           "sub": "KEY",                    // optional, matches subtopics key above
//           "title": "Reynolds Number",
//           "formula": "Re = vDρ/μ",         // for kind=formula
//           "variables": "v = velocity, D = pipe diameter, ρ = density, μ = viscosity",
//           "symbol": "g",                   // for kind=constant
//           "value": "9.81", "unit": "m/s²",     // for kind=constant
//           "table_content": "...",          // for kind=table (plain text/ASCII table)
//           "description": "One-line context.",
//           "notes": "Optional extra note."
//         }
//       ]
//     }
//   ]
// }

const fs = require("fs");
const path = require("path");
const { createClient } = require("@supabase/supabase-js");

// Real PRC board exam Area 1/2/3 split (distinct from the 8 TOS exam_areas
// weighting categories) — see supabase/patches/020_correct_area_mapping_
// from_official_tos.sql and 25_DECISION_LOG.md (2026-09-21 entry).
// `topics.mock_area` is NOT NULL with no default on the live schema, so any
// newly-created topic needs one.
function mockAreaFor(examAreaCode) {
  if (["POWER_ENERGY_MACHINERY", "LAWS_ETHICS", "PROJECT_MGMT_RDE"].includes(examAreaCode)) return "area_1";
  if (["LAND_WATER", "FUNDAMENTALS_SCIENCES", "MATH_BASIC_ENGG"].includes(examAreaCode)) return "area_2";
  return "area_3";
}

function loadEnvLocal() {
  const envPath = path.join(__dirname, "..", ".env.local");
  const raw = fs.readFileSync(envPath, "utf-8");
  const env = {};
  for (const line of raw.split("\n")) {
    const trimmed = line.trim();
    if (!trimmed || trimmed.startsWith("#")) continue;
    const eq = trimmed.indexOf("=");
    if (eq === -1) continue;
    env[trimmed.slice(0, eq).trim()] = trimmed.slice(eq + 1).trim();
  }
  return env;
}

async function main() {
  const [, , jsonPath] = process.argv;
  if (!jsonPath) {
    console.error("Usage: node scripts/import-reviewer-content.js <content.json>");
    process.exit(1);
  }

  const env = loadEnvLocal();
  if (!env.SUPABASE_SERVICE_ROLE_KEY) {
    console.error("SUPABASE_SERVICE_ROLE_KEY is not set in .env.local");
    process.exit(1);
  }

  const supabase = createClient(env.NEXT_PUBLIC_SUPABASE_URL, env.SUPABASE_SERVICE_ROLE_KEY, {
    auth: { autoRefreshToken: false, persistSession: false },
  });

  const data = JSON.parse(fs.readFileSync(jsonPath, "utf-8"));

  let topicsCreated = 0,
    subtopicsCreated = 0,
    entriesCreated = 0,
    entriesSkipped = 0;

  for (const group of data.topics) {
    const { exam_area_code, topic_name, subtopics = {}, entries } = group;

    const { data: examArea, error: eaErr } = await supabase
      .from("exam_areas")
      .select("id")
      .eq("code", exam_area_code)
      .single();
    if (eaErr || !examArea) {
      throw new Error(`Exam area not found: ${exam_area_code} (${eaErr?.message})`);
    }

    let { data: topicRow } = await supabase
      .from("topics")
      .select("id")
      .eq("name", topic_name)
      .eq("exam_area_id", examArea.id)
      .maybeSingle();

    if (!topicRow) {
      const { data: inserted, error } = await supabase
        .from("topics")
        .insert({ exam_area_id: examArea.id, name: topic_name, mock_area: mockAreaFor(exam_area_code) })
        .select("id")
        .single();
      if (error) throw new Error(`Failed to insert topic "${topic_name}": ${error.message}`);
      topicRow = inserted;
      topicsCreated++;
    }
    const topicId = topicRow.id;

    const subtopicIdByKey = {};
    for (const [key, subName] of Object.entries(subtopics)) {
      let { data: subRow } = await supabase
        .from("subtopics")
        .select("id")
        .eq("name", subName)
        .eq("topic_id", topicId)
        .maybeSingle();

      if (!subRow) {
        const { data: inserted, error } = await supabase
          .from("subtopics")
          .insert({ topic_id: topicId, name: subName })
          .select("id")
          .single();
        if (error) throw new Error(`Failed to insert subtopic "${subName}": ${error.message}`);
        subRow = inserted;
        subtopicsCreated++;
      }
      subtopicIdByKey[key] = subRow.id;
    }

    for (const e of entries) {
      const { data: existing } = await supabase
        .from("reviewer_entries")
        .select("id")
        .eq("topic_id", topicId)
        .eq("title", e.title)
        .maybeSingle();

      if (existing) {
        entriesSkipped++;
        continue;
      }

      const subtopicId = e.sub ? subtopicIdByKey[e.sub] ?? null : null;

      const { error: insErr } = await supabase.from("reviewer_entries").insert({
        kind: e.kind,
        title: e.title,
        topic_id: topicId,
        subtopic_id: subtopicId,
        formula: e.formula ?? null,
        variables: e.variables ?? null,
        symbol: e.symbol ?? null,
        value: e.value ?? null,
        unit: e.unit ?? null,
        table_content: e.table_content ?? null,
        description: e.description ?? null,
        notes: e.notes ?? null,
        source: data._meta?.source ?? null,
        status: "draft",
      });
      if (insErr) throw new Error(`Failed to insert entry "${e.title}": ${insErr.message}`);
      entriesCreated++;
    }
  }

  console.log("Import complete:");
  console.log(`  topics created:      ${topicsCreated}`);
  console.log(`  subtopics created:   ${subtopicsCreated}`);
  console.log(`  entries created:     ${entriesCreated}`);
  console.log(`  entries skipped (already existed): ${entriesSkipped}`);
}

main().catch((err) => {
  console.error("Import failed:", err.message);
  process.exit(1);
});
