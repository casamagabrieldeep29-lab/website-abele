import { AIMarkdown } from "@/components/ai-markdown";

// A calculation step looks like "Ph = (15,750 kPa)(0.70 L/s)/1000 = 11.03 kW"
// — some "=" sign, eventually followed by a digit. Used both to find where
// an intro sentence ends and a first step begins, and to confirm every
// split-off segment is really a calculation before reformatting.
const CALC_STEP_PATTERN = /=.*\d/;

// Existing explanations chain their steps two different ways: "Pv = ...;
// Q = ...; Ph = ..." (semicolons) or "Total hours = ... = 480 h. FC = ... =
// 0.42 ha/h. Width = ..." (each step is its own sentence). Split on either:
// a semicolon, or a period followed by whitespace and an uppercase letter
// (a genuine sentence boundary) — deliberately NOT a bare period, so a
// decimal like "0.42" (never followed by a space) is never split apart.
const STEP_SEPARATOR = /;\s*|\.\s+(?=[A-Z])/;

function looksLikeMarkdown(text: string): boolean {
  return /^#{1,4}\s/m.test(text) || text.includes("```");
}

/**
 * Most existing "solving"-question explanations were authored as one
 * sentence/paragraph with the whole derivation chained together (see
 * STEP_SEPARATOR above) — never rewritten with markdown, and there's no DB
 * access this session to rewrite them. This recovers the step structure
 * already implicit in that punctuation, without touching the stored text
 * at all: an intro clause (if any) stays a plain sentence, each remaining
 * segment becomes its own boxed step, and the value after the LAST "=" in
 * the final segment becomes the Result line. Returns null when the text
 * doesn't actually look like a calculation chain, so a normal conceptual
 * explanation renders unchanged.
 */
function splitIntoSteps(text: string): { intro: string | null; steps: string[] } | null {
  const segments = text
    .split(STEP_SEPARATOR)
    .map((s) => s.trim().replace(/\.$/, ""))
    .filter(Boolean);
  if (segments.length < 2) return null;

  const first = segments[0];
  const eqIndex = first.indexOf("=");
  let intro: string | null = null;
  let firstStep = first;

  if (eqIndex === -1) {
    intro = first;
    firstStep = "";
  } else {
    const colonIndex = first.slice(0, eqIndex).lastIndexOf(":");
    if (colonIndex > -1) {
      intro = first.slice(0, colonIndex + 1).trim();
      firstStep = first.slice(colonIndex + 1).trim();
    }
  }

  const steps = [firstStep, ...segments.slice(1)].map((s) => s.trim()).filter(Boolean);
  if (steps.length < 2 || !steps.every((s) => CALC_STEP_PATTERN.test(s))) return null;

  return { intro, steps };
}

export function ExplanationDisplay({ text }: { text: string }) {
  if (looksLikeMarkdown(text)) {
    return <AIMarkdown text={text} />;
  }

  const parsed = splitIntoSteps(text);
  if (!parsed) {
    return <AIMarkdown text={text} />;
  }

  const lastStep = parsed.steps[parsed.steps.length - 1];
  const lastEqIndex = lastStep.lastIndexOf("=");
  const result = lastEqIndex > -1 ? lastStep.slice(lastEqIndex + 1).trim() : null;

  return (
    <div>
      {parsed.intro && (
        <p className="text-sm leading-relaxed text-foreground first:mt-0">{parsed.intro}</p>
      )}
      {parsed.steps.map((step, i) => (
        <div key={i} className="mt-2 first:mt-1.5">
          <p className="text-xs font-semibold uppercase tracking-wide text-primary">Step {i + 1}</p>
          <pre className="mt-1 whitespace-pre-wrap break-words rounded-md border border-border bg-muted/40 p-2.5 font-mono text-xs leading-relaxed text-foreground">
            {step}
          </pre>
        </div>
      ))}
      {result && <p className="mt-2 text-sm font-semibold text-success">Result: {result}</p>}
    </div>
  );
}
