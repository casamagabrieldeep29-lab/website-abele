import "server-only";
import type { SupabaseClient } from "@supabase/supabase-js";
import { sendEmail } from "./resend";

type SubjectRow = { exam_area_name: string; subject_name: string; total: number; correct: number };

const AREA_LABELS: Record<string, string> = { area_1: "Area 1", area_2: "Area 2", area_3: "Area 3" };

function escapeHtml(s: string): string {
  return s.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;");
}

function buildReportHtml({
  studentName,
  areaLabel,
  correctCount,
  totalQuestions,
  breakdown,
}: {
  studentName: string;
  areaLabel: string;
  correctCount: number;
  totalQuestions: number;
  breakdown: SubjectRow[];
}): string {
  const percent = totalQuestions > 0 ? Math.round((100 * correctCount) / totalQuestions) : 0;

  const byArea = new Map<string, SubjectRow[]>();
  for (const row of breakdown) {
    const list = byArea.get(row.exam_area_name) ?? [];
    list.push(row);
    byArea.set(row.exam_area_name, list);
  }

  const sections = [...byArea.entries()]
    .map(([areaName, rows]) => {
      const rowsHtml = rows
        .map((r) => {
          const rowPercent = r.total > 0 ? Math.round((100 * r.correct) / r.total) : 0;
          return `<tr><td style="padding:6px 10px;border-bottom:1px solid #e5e7eb;">${escapeHtml(r.subject_name)}</td><td style="padding:6px 10px;border-bottom:1px solid #e5e7eb;text-align:right;white-space:nowrap;">${r.correct}/${r.total} (${rowPercent}%)</td></tr>`;
        })
        .join("");
      return `<h3 style="margin:20px 0 8px;color:#0f5b5a;font-size:14px;">${escapeHtml(areaName)}</h3><table style="width:100%;border-collapse:collapse;font-size:13px;">${rowsHtml}</table>`;
    })
    .join("");

  return `
    <div style="font-family:Arial,Helvetica,sans-serif;color:#1f2937;max-width:600px;margin:0 auto;">
      <h2 style="color:#0f5b5a;">Your ${escapeHtml(areaLabel)} Mock Exam results</h2>
      <p>Hi ${escapeHtml(studentName)},</p>
      <p>You scored <strong>${correctCount} out of ${totalQuestions} (${percent}%)</strong> on this mock exam.</p>
      ${sections}
      <p style="margin-top:24px;font-size:12px;color:#6b7280;">This is an automated summary from ABELIEVER. Review the exact questions you missed anytime from your Mock Exam results page.</p>
    </div>
  `;
}

/**
 * Best-effort report email for a just-completed Mock Exam attempt — the
 * caller must wrap this in try/catch, since a failure here (missing
 * RESEND_API_KEY, a network error, the RPC erroring) must never block the
 * exam-completion flow itself. Fetches the per-subject breakdown itself so
 * the caller only needs to pass the ids/score it already has on hand.
 */
export async function sendMockExamReportEmail({
  supabase,
  attemptId,
  userEmail,
  studentName,
  area,
  correctCount,
  totalQuestions,
}: {
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  supabase: SupabaseClient<any>;
  attemptId: string;
  userEmail: string;
  studentName: string;
  area?: string;
  correctCount: number;
  totalQuestions: number;
}): Promise<void> {
  const { data: breakdown, error } = await supabase.rpc("get_mock_exam_subject_breakdown", {
    p_attempt_id: attemptId,
  });
  if (error) throw new Error(error.message);

  const areaLabel = area ? (AREA_LABELS[area] ?? area) : "Mock Exam";

  const html = buildReportHtml({
    studentName,
    areaLabel,
    correctCount,
    totalQuestions,
    breakdown: (breakdown ?? []) as SubjectRow[],
  });

  await sendEmail({
    to: userEmail,
    subject: `Your ${areaLabel} results: ${correctCount}/${totalQuestions}`,
    html,
  });
}
