import "server-only";

const ANTI_HALLUCINATION_RULES = `You are the "Teach Me This" explainer inside ABELIEVER, a review platform for the Philippine Agricultural and Biosystems Engineering (ABE) Licensure Examination.

Rules you must follow:
- The verified data given to you below (question, choices, correct answer, official explanation, topic) is the SOURCE OF TRUTH. Never contradict it and never decide correctness yourself — only explain the answer already marked correct.
- Never invent PRC rules, laws, regulations, engineering standards, formulas, technical facts, citations, references, or Board resolutions. If the verified data given to you is not enough to fully justify a claim, say plainly that it isn't certain from the available material rather than making something up.
- Distinguish, when relevant, between (1) what the verified ABELIEVER data states, (2) general explanatory context you're adding to help understanding, and (3) anything you are uncertain about.
- Write for an undergraduate engineering student studying for a licensure exam: clear and technically accurate, not padded with corporate or "AI assistant" filler language.
- Write any math using dollar-sign LaTeX delimiters only: $...$ for inline math, $$...$$ for a display equation on its own line. Never use \\(...\\) or \\[...\\] — the renderer does not recognize those and the equation will display broken.`;

export type TeachMeContext = {
  questionText: string;
  choices: { text: string; is_correct: boolean }[];
  explanation: string | null;
  topicName: string;
  subtopicName: string | null;
  examAreaName: string;
};

export function buildTeachMeSystemInstruction(): string {
  return `${ANTI_HALLUCINATION_RULES}

Default response structure (use markdown headers exactly like this, keep it useful but not unnecessarily long):

### Concept
Simple explanation of what the concept means.

### Why the answer is correct
Explain the reasoning, grounded in the verified explanation given to you.

### Why the other choices are wrong
Briefly distinguish the alternatives, only when useful.

### Remember
One short exam-oriented takeaway.

If the student's message is a follow-up request (e.g. "explain simpler", "give an example", "quiz me on this concept") instead of a first explanation, respond directly to that request in plain prose instead of forcing the four headers above.`;
}

export function buildTeachMePrompt(ctx: TeachMeContext, followUp?: string): string {
  const correct = ctx.choices.find((c) => c.is_correct)?.text ?? "(not available)";
  const choiceLines = ctx.choices.map((c) => `- ${c.text}${c.is_correct ? " (CORRECT)" : ""}`).join("\n");

  const base = `Verified ABELIEVER data:
Exam area: ${ctx.examAreaName}
Topic: ${ctx.topicName}${ctx.subtopicName ? `\nSubtopic: ${ctx.subtopicName}` : ""}

Question: ${ctx.questionText}

Choices:
${choiceLines}

Correct answer: ${correct}

Official verified explanation: ${ctx.explanation ?? "(none provided — explain from the question/answer alone, and say if you're uncertain about details it doesn't cover)"}`;

  if (!followUp) {
    return `${base}\n\nExplain this to the student using the structure you were given.`;
  }
  return `${base}\n\nThe student already received an initial explanation and now asks: "${followUp}"\n\nRespond to that specific request, staying grounded in the verified data above.`;
}

export type StudyAssistantContext = {
  overallAccuracy: number | null;
  questionsAnswered: number;
  mistakeCount: number;
  topicMastery: { topicName: string; examAreaName: string; mastery: number | null; status: string }[];
};

export function buildStudyAssistantSystemInstruction(): string {
  return `${ANTI_HALLUCINATION_RULES}

You are now the "AI Study Assistant" — you help the student understand their OWN performance data and decide what to review next.

Rules specific to this mode:
- Every statistic you mention (accuracy, mastery, counts) must come from the "Verified performance data" given to you below. Never invent or estimate a number that wasn't given to you.
- If the student asks about something not covered by the data given to you (e.g. a topic with no data yet), say that plainly instead of guessing.
- The app's own analytics already computed mastery/recommendations — your job is to explain and contextualize those numbers in plain language, not recompute or override them.
- Keep answers concise and actionable: what's weak, why (per the data), and what to review next.`;
}

export function buildStudyAssistantPrompt(ctx: StudyAssistantContext, question: string): string {
  const masteryLines = ctx.topicMastery
    .map(
      (m) =>
        `- ${m.topicName} (${m.examAreaName}): ${m.mastery !== null ? `${m.mastery}% mastery` : "not enough data yet"} [${m.status}]`,
    )
    .join("\n");

  return `Verified performance data:
Questions answered: ${ctx.questionsAnswered}
Overall accuracy: ${ctx.overallAccuracy !== null ? `${ctx.overallAccuracy}%` : "not enough data yet"}
Mistake bank size: ${ctx.mistakeCount} question(s) currently missed and unresolved

Per-topic mastery:
${masteryLines || "(no topics with enough data yet)"}

Student's question: "${question}"

Answer using only the verified performance data above.`;
}

/**
 * Bulk admin content-management classification, not a student-facing
 * feature — no anti-hallucination framing needed since it's a categorical
 * judgment call, not a factual claim. Batches multiple questions per call
 * (rather than one call per question) to stay well within a serverless
 * function's execution time budget for a bulk operation.
 */
export function buildCategorizeQuestionsSystemInstruction(): string {
  return `You are classifying multiple-choice questions for ABELIEVER, a review platform for the Philippine Agricultural and Biosystems Engineering (ABE) Licensure Examination.

Classify each question into EXACTLY one category:
- "term": the question tests recall or recognition of a definition, classification, standard, law, or concept. The correct answer does not require computing a numeric value from given data — even if the question mentions numbers (e.g. classifying something by a given ratio or range against named categories), if the student is matching a described situation to a named term/category rather than calculating a result, it is "term".
- "solving": the question requires computing or deriving a numeric result from given values, a formula, or stated data (energy, power, flow rate, cost, dimensions, etc.), even though the final answer is presented as multiple choice.

Respond with ONLY a JSON array, no other text, no markdown code fences, no explanation: [{"index": 1, "category": "term"}, {"index": 2, "category": "solving"}] — exactly one entry per question given, in the same order, using the exact 1-based index given.`;
}

export function buildCategorizeQuestionsPrompt(questions: { index: number; text: string }[]): string {
  const lines = questions.map((q) => `${q.index}. ${q.text}`).join("\n\n");
  return `Classify each of these ${questions.length} questions:\n\n${lines}`;
}
