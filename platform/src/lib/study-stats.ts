export type TopicMasteryRow = {
  topic_id: string;
  topic_name: string;
  exam_area_name: string;
  total_attempts: number;
  overall_accuracy: number | null;
  recent_accuracy: number | null;
  mastery: number | null;
  status: "insufficient_data" | "strong" | "developing" | "needs_review";
  last_answered_at: string | null;
};

type AnsweredRow = { answered_at: string | null; is_correct: boolean };

export type StudyStats = {
  questionsAnswered: number;
  overallAccuracy: number | null;
  topicsStudied: number;
  topicsMastered: number;
  streak: number;
  studiedLast7: number;
};

/**
 * Single source of truth for the study statistics shown on both the
 * Dashboard and the Profile page. Both pages fetch the same get_topic_mastery()
 * rows and attempt_answers rows (each already needed them for other things)
 * and pass them through this one function, so the two pages can never
 * disagree on what "Questions Answered" or "Current Streak" means.
 */
export function computeStudyStats(mastery: TopicMasteryRow[], answered: AnsweredRow[]): StudyStats {
  const questionsAnswered = answered.length;
  const overallAccuracy = questionsAnswered
    ? Math.round((100 * answered.filter((a) => a.is_correct).length) / questionsAnswered)
    : null;

  const topicsStudied = mastery.filter((m) => m.total_attempts > 0).length;
  const topicsMastered = mastery.filter((m) => m.status === "strong").length;

  const studyDates = new Set(answered.map((a) => new Date(a.answered_at!).toISOString().slice(0, 10)));
  let streak = 0;
  const cursor = new Date();
  if (!studyDates.has(cursor.toISOString().slice(0, 10))) cursor.setDate(cursor.getDate() - 1);
  while (studyDates.has(cursor.toISOString().slice(0, 10))) {
    streak++;
    cursor.setDate(cursor.getDate() - 1);
  }
  let studiedLast7 = 0;
  const check = new Date();
  for (let i = 0; i < 7; i++) {
    if (studyDates.has(check.toISOString().slice(0, 10))) studiedLast7++;
    check.setDate(check.getDate() - 1);
  }

  return { questionsAnswered, overallAccuracy, topicsStudied, topicsMastered, streak, studiedLast7 };
}
