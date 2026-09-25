import { NextRequest, NextResponse } from "next/server";
import { createClient } from "@/lib/supabase/server";
import { fetchAllAnsweredRows } from "@/lib/study-stats";
import { getAIProvider, AIProviderError, AI_DAILY_LIMIT } from "@/lib/ai";
import { buildStudyAssistantPrompt, buildStudyAssistantSystemInstruction, type StudyAssistantContext } from "@/lib/ai/prompts";

const FRIENDLY_ERROR = "AI explanation is temporarily unavailable. Please try again.";
const MAX_QUESTION_LENGTH = 500;

type TopicMasteryRow = {
  topic_name: string;
  exam_area_name: string;
  mastery: number | null;
  status: string;
};

export async function POST(req: NextRequest) {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) {
    return NextResponse.json({ error: "Not signed in." }, { status: 401 });
  }

  const provider = getAIProvider();
  if (!provider) {
    return NextResponse.json({ error: FRIENDLY_ERROR }, { status: 503 });
  }

  let body: { question?: string };
  try {
    body = await req.json();
  } catch {
    return NextResponse.json({ error: "Invalid request." }, { status: 400 });
  }

  const question = body.question?.trim().slice(0, MAX_QUESTION_LENGTH);
  if (!question) {
    return NextResponse.json({ error: "Ask a question first." }, { status: 400 });
  }

  const { data: usage, error: usageError } = await supabase.rpc("check_and_log_ai_usage", {
    p_daily_limit: AI_DAILY_LIMIT,
  });
  if (usageError) {
    return NextResponse.json({ error: FRIENDLY_ERROR }, { status: 500 });
  }
  const usageRow = Array.isArray(usage) ? usage[0] : usage;
  if (!usageRow?.allowed) {
    return NextResponse.json(
      { error: `You've reached today's AI request limit (${AI_DAILY_LIMIT}/day). Try again tomorrow.` },
      { status: 429 },
    );
  }

  const [{ data: masteryRows }, answeredRows, { data: mistakeRows }] = await Promise.all([
    supabase.rpc("get_topic_mastery"),
    // Paginated — a plain `.select()` here silently caps at 1000 rows once a
    // student passes 1000 answered questions, understating questionsAnswered/
    // overallAccuracy in the AI's context. See study-stats.ts.
    fetchAllAnsweredRows(supabase, user.id),
    supabase.rpc("get_mistake_bank"),
  ]);

  const mastery = (masteryRows ?? []) as TopicMasteryRow[];
  const answered = answeredRows;
  const context: StudyAssistantContext = {
    questionsAnswered: answered.length,
    overallAccuracy: answered.length
      ? Math.round((100 * answered.filter((a) => a.is_correct).length) / answered.length)
      : null,
    mistakeCount: mistakeRows?.length ?? 0,
    topicMastery: mastery.map((m) => ({
      topicName: m.topic_name,
      examAreaName: m.exam_area_name,
      mastery: m.mastery,
      status: m.status,
    })),
  };

  try {
    const text = await provider.generate({
      systemInstruction: buildStudyAssistantSystemInstruction(),
      prompt: buildStudyAssistantPrompt(context, question),
    });
    return NextResponse.json({ text, remaining: usageRow.remaining });
  } catch (err) {
    console.error("[study-assistant] Gemini request failed:", err instanceof Error ? err.message : err);
    if (err instanceof AIProviderError) {
      return NextResponse.json({ error: FRIENDLY_ERROR }, { status: 502 });
    }
    return NextResponse.json({ error: FRIENDLY_ERROR }, { status: 500 });
  }
}
