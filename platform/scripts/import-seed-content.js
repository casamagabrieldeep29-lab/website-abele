// Imports a structured question-bank JSON file (see supabase/seed/content/*.json
// for the format) directly into Supabase using the service role key.
//
// Usage (run from the platform/ directory):
//   node scripts/import-seed-content.js supabase/seed/content/area1-tambong-part1.json "ABELE TOP 1/ATTRC/TAMBONG/Area 1/AREA1-2022.pdf"
//
// Idempotent: re-running skips topics/subtopics/questions that already exist
// (topics/subtopics matched by name, questions matched by exact question_text
// within the same topic).

const fs = require("fs");
const path = require("path");
const { createClient } = require("@supabase/supabase-js");

// Content JSON uses the source materials' own difficulty labels
// (easy/moderate/difficult); the DB schema's check constraint expects
// easy/medium/hard.
const DIFFICULTY_MAP = { easy: "easy", moderate: "medium", difficult: "hard" };

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
  const [, , jsonPath, sourceRef] = process.argv;
  if (!jsonPath || !sourceRef) {
    console.error("Usage: node scripts/import-seed-content.js <content.json> <sourceRef>");
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
    questionsCreated = 0,
    questionsSkipped = 0,
    choicesCreated = 0;
  const flagged = [];

  for (const group of data.topics) {
    const { exam_area_code, topic_name, subtopics = {}, questions } = group;

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
        .insert({ exam_area_id: examArea.id, name: topic_name })
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

    for (const q of questions) {
      const { data: existing } = await supabase
        .from("questions")
        .select("id")
        .eq("topic_id", topicId)
        .eq("question_text", q.q)
        .maybeSingle();

      if (existing) {
        questionsSkipped++;
        continue;
      }

      const subtopicId = q.sub ? subtopicIdByKey[q.sub] ?? null : null;
      const flagNote = q.flag ? ` [FLAGGED FOR REVIEW: ${q.flag}]` : "";
      const explanation = q.explanation || q.flag ? `${q.explanation || ""}${flagNote}`.trim() : null;

      const { data: questionRow, error: qErr } = await supabase
        .from("questions")
        .insert({
          topic_id: topicId,
          subtopic_id: subtopicId,
          question_text: q.q,
          question_type: "single_choice",
          difficulty: DIFFICULTY_MAP[q.diff] || q.diff,
          explanation,
          source: data._meta.author,
          source_reference: sourceRef,
          status: "draft",
        })
        .select("id")
        .single();
      if (qErr) throw new Error(`Failed to insert question "${q.q.slice(0, 40)}...": ${qErr.message}`);
      questionsCreated++;

      if (q.flag) flagged.push(q.q);

      const choiceRows = q.choices.map((text, idx) => ({
        question_id: questionRow.id,
        choice_text: text,
        is_correct: idx === q.answer,
        sort_order: idx,
      }));
      const { error: cErr } = await supabase.from("choices").insert(choiceRows);
      if (cErr) throw new Error(`Failed to insert choices for question ${questionRow.id}: ${cErr.message}`);
      choicesCreated += choiceRows.length;
    }
  }

  console.log("Import complete:");
  console.log(`  topics created:     ${topicsCreated}`);
  console.log(`  subtopics created:  ${subtopicsCreated}`);
  console.log(`  questions created:  ${questionsCreated}`);
  console.log(`  questions skipped (already existed): ${questionsSkipped}`);
  console.log(`  choices created:    ${choicesCreated}`);
  if (flagged.length) {
    console.log(`\n${flagged.length} question(s) imported with a review flag:`);
    flagged.forEach((q) => console.log(`  - ${q.slice(0, 90)}...`));
  }
}

main().catch((err) => {
  console.error("Import failed:", err.message);
  process.exit(1);
});
