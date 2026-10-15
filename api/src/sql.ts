/** Every query in one place so the guard tests can check each one's plan and cost. */
export const SQL = {
  keepalive: "SELECT 1 AS ok",
  examAreas: "SELECT id, name, sort_order, weight_percent FROM exam_areas ORDER BY sort_order",
  subjects: "SELECT id, exam_area_id, name, sort_order FROM subjects ORDER BY sort_order",
  topics: "SELECT id, name, mock_area, exam_area_id, subject_id FROM topics ORDER BY name",
  subtopics: "SELECT id, name, topic_id FROM subtopics ORDER BY name",
  /** One row per published question; the app turns it into counts and the sorted id list. */
  snapshot: "SELECT id, topic_id, subtopic_id, topic_mock_area, additional_mock_areas FROM questions ORDER BY id",
  questionsByIds: (n: number) =>
    "SELECT id, topic_id, subtopic_id, question_text, question_type, difficulty, category, series_key, " +
    `series_position, is_paes, paes_reference FROM questions WHERE id IN (${Array(n).fill("?").join(",")})`,
  choicesByQuestionIds: (n: number) =>
    `SELECT id, question_id, choice_text, sort_order FROM choices WHERE question_id IN (${Array(n).fill("?").join(",")}) ` +
    "ORDER BY question_id, sort_order",
};
