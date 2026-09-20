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
// weighting categories) — mapping decided with Gabriel, see
// supabase/patches/007_mock_exam_areas.sql and 25_DECISION_LOG.md
// (2026-09-19, "Mock Exam rebuilt to match the real PRC ABE board exam").
// `topics.mock_area` is NOT NULL with no default on the live schema.
function mockAreaFor(examAreaCode) {
  if (["POWER_ENERGY_MACHINERY", "LAWS_ETHICS"].includes(examAreaCode)) return "area_1";
  if (examAreaCode === "LAND_WATER") return "area_2";
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
  const author = data._meta?.author || "Board Exam Pro";
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

      out.push("");
      out.push(`  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = ${sqlStr(q.q)};`);
      out.push(`  IF v_question_id IS NULL THEN`);
      out.push(`    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)`);
      out.push(
        `    VALUES (v_topic_id, ${subVar}, ${sqlStr(q.q)}, 'single_choice', ${sqlStr(difficulty)}, ${sqlStr(explanationRaw)}, ${sqlStr(author)}, ${sqlStr(sourceRef)}, 'draft')`
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
