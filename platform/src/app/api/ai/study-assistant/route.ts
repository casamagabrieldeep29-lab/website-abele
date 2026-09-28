import { NextRequest, NextResponse } from "next/server";
import { createClient } from "@/lib/supabase/server";
import { fetchAllAnsweredRows } from "@/lib/study-stats";
import { getAIProvider, AIProviderError, AI_DAILY_LIMIT, AI_TRIAL_DAILY_LIMIT, buildAiLimitMessage } from "@/lib/ai";
import { buildStudyAssistantPrompt, buildStudyAssistantSystemInstruction, type StudyAssistantContext } from "@/lib/ai/prompts";
import { checkRateLimit } from "@/lib/rate-limit";
import { logError } from "@/lib/log-error";

const FRIENDLY_ERROR = "AI explanation is temporarily unavailable. Please try again.";
const MAX_QUESTION_LENGTH = 500;

// Same burst cap as /api/ai/teach-me — see that file's comment.
const AI_BURST_LIMIT = 8;
const AI_BURST_WINDOW_SECONDS = 60;

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

  const burstAllowed = await checkRateLimit(`ai-burst:${user.id}`, AI_BURST_LIMIT, AI_BURST_WINDOW_SECONDS);
  if (!burstAllowed) {
    return NextResponse.json({ error: "You're sending requests too quickly. Please wait a moment." }, { status: 429 });
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
    p_trial_daily_limit: AI_TRIAL_DAILY_LIMIT,
  });
  if (usageError) {
    return NextResponse.json({ error: FRIENDLY_ERROR }, { status: 500 });
  }
  const usageRow = Array.isArray(usage) ? usage[0] : usage;
  if (!usageRow?.allowed) {
    return NextResponse.json({ error: buildAiLimitMessage(usageRow?.limit_reason) }, { status: 429 });
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
    await logError("study-assistant", err);
    if (err instanceof AIProviderError) {
      return NextResponse.json({ error: FRIENDLY_ERROR }, { status: 502 });
    }
    return NextResponse.json({ error: FRIENDLY_ERROR }, { status: 500 });
  }
}
