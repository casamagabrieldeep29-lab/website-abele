// Generates a standalone, idempotent .sql file from a content JSON (see
// supabase/seed/content/*.json) that can be pasted directly into the
// Supabase SQL Editor — no .env.local / service-role key needed.
//
// Mirrors import-seed-content.js's exact logic: same difficulty mapping,
// same explanation+flag composition, same dedup keys (topic matched by
// name+exam_area_id, subtopic by name+topic_id, question by
// topic_id+question_text).
//
// Usage: node scripts/generate-import-sql.js supabase/seed/content/boardexampro-vol1.json "ABELE 1st Ed Vol I Answer Key.pdf" > out.sql

const fs = require("fs");

const DIFFICULTY_MAP = { easy: "easy", moderate: "medium", difficult: "hard" };

// Real PRC board exam Area 1/2/3 split (distinct from the 8 TOS exam_areas
// weighting categories) — corrected per the official 2025 ABE Table of
// Specifications (Annex "A"), see supabase/patches/020_correct_area_mapping_
// from_official_tos.sql and 25_DECISION_LOG.md (2026-09-21 entry).
// `topics.mock_area` is NOT NULL with no default on the live schema.
function mockAreaFor(examAreaCode) {
  if (["POWER_ENERGY_MACHINERY", "LAWS_ETHICS", "PROJECT_MGMT_RDE"].includes(examAreaCode)) return "area_1";
  if (["LAND_WATER", "FUNDAMENTALS_SCIENCES", "MATH_BASIC_ENGG"].includes(examAreaCode)) return "area_2";
  return "area_3";
}

function sqlStr(value) {
  if (value === null || value === undefined) return "NULL";
  return `'${String(value).replace(/'/g, "''")}'`;
}

function pgIdent(key) {
  return key.toLowerCase().replace(/[^a-z0-9_]/g, "_");
}

function main() {
  const [, , jsonPath, sourceRef] = process.argv;
  if (!jsonPath || !sourceRef) {
    console.error("Usage: node scripts/generate-import-sql.js <content.json> <sourceRef>");
    process.exit(1);
  }

  const data = JSON.parse(fs.readFileSync(jsonPath, "utf-8"));
  const out = [];

  out.push(`-- Auto-generated from ${jsonPath}`);
  out.push(`-- Source reference: ${sourceRef}`);
  out.push(`-- Idempotent: safe to re-run; skips topics/subtopics/questions that already exist.`);
  out.push(`-- Paste into the Supabase SQL Editor and run.`);
  out.push("");

  for (const group of data.topics) {
    const { exam_area_code, topic_name, subtopics = {}, questions } = group;

    out.push(`-- =====================================================================`);
    out.push(`-- Topic: ${topic_name} (${exam_area_code}) — ${questions.length} question(s)`);
    out.push(`-- =====================================================================`);
    out.push(`DO $$`);
    out.push(`DECLARE`);
    out.push(`  v_exam_area_id uuid;`);
    out.push(`  v_topic_id uuid;`);
    out.push(`  v_question_id uuid;`);
    const subKeys = Object.keys(subtopics);
    for (const key of subKeys) {
      out.push(`  v_sub_${pgIdent(key)} uuid;`);
    }
    out.push(`BEGIN`);
    out.push(`  SELECT id INTO v_exam_area_id FROM public.exam_areas WHERE code = ${sqlStr(exam_area_code)};`);
    out.push(`  IF v_exam_area_id IS NULL THEN`);
    out.push(`    RAISE EXCEPTION 'Exam area not found: ${exam_area_code}';`);
    out.push(`  END IF;`);
    out.push("");
    const mockArea = mockAreaFor(exam_area_code);
    out.push(`  SELECT id INTO v_topic_id FROM public.topics WHERE name = ${sqlStr(topic_name)} AND exam_area_id = v_exam_area_id;`);
    out.push(`  IF v_topic_id IS NULL THEN`);
    out.push(`    INSERT INTO public.topics (exam_area_id, name, mock_area) VALUES (v_exam_area_id, ${sqlStr(topic_name)}, ${sqlStr(mockArea)}) RETURNING id INTO v_topic_id;`);
    out.push(`  END IF;`);

    for (const [key, subName] of Object.entries(subtopics)) {
      const varName = `v_sub_${pgIdent(key)}`;
      out.push("");
      out.push(`  SELECT id INTO ${varName} FROM public.subtopics WHERE name = ${sqlStr(subName)} AND topic_id = v_topic_id;`);
      out.push(`  IF ${varName} IS NULL THEN`);
      out.push(`    INSERT INTO public.subtopics (topic_id, name) VALUES (v_topic_id, ${sqlStr(subName)}) RETURNING id INTO ${varName};`);
      out.push(`  END IF;`);
    }

    for (const q of questions) {
      const subVar = q.sub && subKeys.includes(q.sub) ? `v_sub_${pgIdent(q.sub)}` : "NULL";
      const flagNote = q.flag ? ` [FLAGGED FOR REVIEW: ${q.flag}]` : "";
      const explanationRaw = q.explanation || q.flag ? `${q.explanation || ""}${flagNote}`.trim() : null;
      const difficulty = DIFFICULTY_MAP[q.diff] || q.diff || null;
      const isRecalled = Boolean(q.recalled_batch);
      const recalledBatch = q.recalled_batch || null;
      const isPaes = Boolean(q.is_paes || q.paes_reference);
      const paesReference = q.paes_reference || null;

      out.push("");
      out.push(`  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = ${sqlStr(q.q)};`);
      out.push(`  IF v_question_id IS NULL THEN`);
      out.push(`    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, status, is_recalled, recalled_batch, is_paes, paes_reference)`);
      out.push(
        // source/source_reference deliberately never populated — per standing
        // instruction, nothing on the site shows or discloses source attribution.
        `    VALUES (v_topic_id, ${subVar}, ${sqlStr(q.q)}, 'single_choice', ${sqlStr(difficulty)}, ${sqlStr(explanationRaw)}, 'draft', ${isRecalled}, ${sqlStr(recalledBatch)}, ${isPaes}, ${sqlStr(paesReference)})`
      );
      out.push(`    RETURNING id INTO v_question_id;`);
      out.push("");
      out.push(`    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES`);
      const choiceLines = q.choices.map(
        (text, idx) => `      (v_question_id, ${sqlStr(text)}, ${idx === q.answer ? "true" : "false"}, ${idx})`
      );
      out.push(choiceLines.join(",\n") + ";");
      out.push(`  END IF;`);
    }

    out.push(`END $$;`);
    out.push("");
  }

  process.stdout.write(out.join("\n") + "\n");
}

main();
