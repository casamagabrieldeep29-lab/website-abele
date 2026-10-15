/**
 * Schema as ordered code migrations, applied automatically on deploy (no pasting SQL by hand).
 * Never edit an applied migration: add a new one.
 *
 * Phase 1 holds only SHARED, read-heavy content that is identical for every student: the exam
 * taxonomy and the PUBLISHED questions with their choices. Correct answers and explanations are
 * deliberately NOT stored here: grading stays in Supabase (submit_attempt_answer), so nothing in
 * this database can leak an answer before a student submits.
 */
export const MIGRATIONS: { id: string; sql: string }[] = [
  {
    id: "001_content",
    sql: `
CREATE TABLE exam_areas (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  sort_order INTEGER NOT NULL DEFAULT 0,
  weight_percent REAL
);
CREATE TABLE subjects (
  id TEXT PRIMARY KEY,
  exam_area_id TEXT NOT NULL,
  name TEXT NOT NULL,
  sort_order INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE topics (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  mock_area TEXT,
  exam_area_id TEXT NOT NULL,
  subject_id TEXT
);
CREATE TABLE subtopics (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  topic_id TEXT NOT NULL
);
CREATE TABLE questions (
  id TEXT PRIMARY KEY,
  topic_id TEXT NOT NULL,
  subtopic_id TEXT,
  question_text TEXT NOT NULL,
  question_type TEXT NOT NULL,
  difficulty TEXT,
  category TEXT,
  series_key TEXT,
  series_position INTEGER,
  is_paes INTEGER NOT NULL DEFAULT 0,
  paes_reference TEXT,
  topic_mock_area TEXT,
  additional_mock_areas TEXT NOT NULL DEFAULT '[]'
);
CREATE INDEX questions_topic_idx ON questions (topic_id);
CREATE INDEX questions_subtopic_idx ON questions (subtopic_id);
CREATE TABLE choices (
  id TEXT PRIMARY KEY,
  question_id TEXT NOT NULL,
  choice_text TEXT NOT NULL,
  sort_order INTEGER NOT NULL
);
CREATE INDEX choices_question_idx ON choices (question_id, sort_order);
CREATE TABLE content_meta (
  key TEXT PRIMARY KEY,
  value TEXT NOT NULL
);
`,
  },
];
