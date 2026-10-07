// Pure question generator for the admin-only Midterm Exam. Everything is built
// from the Midterm Reviewer rows already loaded on the page; no database writes.
import {
  group,
  lines,
  type MidtermRow,
  type SectionGroup,
} from "../midterm-data";

export type QuestionKind = "term" | "definition" | "formula" | "solving";

export const KIND_LABELS: Record<QuestionKind, string> = {
  term: "Term → meaning",
  definition: "Meaning → term",
  formula: "Name → formula",
  solving: "Solving (sample problems)",
};

export type ExamQuestion = {
  id: string;
  kind: QuestionKind;
  section: string;
  topic: string;
  prompt: string;
  choices: string[];
  correct: number;
  /** Lines shown after answering (definition context or worked solution). */
  explain: string[];
};

export type ExamConfig = {
  topicKeys: Set<string>;
  kinds: QuestionKind[];
  count: number;
};

type Rng = () => number;

export function shuffle<T>(items: T[], rng: Rng = Math.random): T[] {
  const a = items.slice();
  for (let i = a.length - 1; i > 0; i--) {
    const j = Math.floor(rng() * (i + 1));
    [a[i], a[j]] = [a[j], a[i]];
  }
  return a;
}

// ---------- numeric answers (solving questions)

type NumericAnswer = {
  value: number;
  decimals: number;
  commas: boolean;
  unit: string;
  sep: string;
};

export function parseNumericAnswer(answer: string): NumericAnswer | null {
  const m = answer.trim().match(/^(-?\d[\d,]*(?:\.\d+)?)(\s*)(.*)$/);
  if (!m) return null;
  const unit = m[3].trim();
  const sep = m[2] ? " " : "";
  // A unit that itself holds another number ("20,000 m (20 km)", "660 W; 6 A")
  // cannot be varied safely, so such answers are left out of the exam.
  if (/\d/.test(unit.replace(/[²³⁰¹⁴⁵⁶⁷⁸⁹₀₁₂₃₄₅₆₇₈₉]/g, ""))) return null;
  const raw = m[1];
  const value = Number(raw.replace(/,/g, ""));
  if (!Number.isFinite(value) || value === 0) return null;
  const decimals = raw.includes(".") ? raw.split(".")[1].length : 0;
  return { value, decimals, commas: raw.includes(","), unit, sep };
}

function formatNumber(n: NumericAnswer, value: number): string {
  const body = value.toLocaleString("en-US", {
    minimumFractionDigits: n.decimals,
    maximumFractionDigits: n.decimals,
    useGrouping: n.commas,
  });
  return n.unit ? `${body}${n.sep}${n.unit}` : body;
}

/** Three plausible wrong answers: typical slips such as doubling, halving or dropping a percentage. */
export function numericDistractors(
  answer: string,
  rng: Rng = Math.random,
): string[] | null {
  const n = parseNumericAnswer(answer);
  if (!n) return null;
  const correct = formatNumber(n, n.value);
  const factors = [2, 0.5, 1.25, 0.8, 1.5, 0.75, 10, 0.1, 1.1, 0.9];
  const out: string[] = [];
  for (const f of shuffle(factors, rng)) {
    const text = formatNumber(n, n.value * f);
    if (text === correct || out.includes(text)) continue;
    // keep tiny/odd results out of the choice list when the answer is a whole number
    if (n.decimals === 0 && !Number.isInteger(n.value * f)) continue;
    out.push(text);
    if (out.length === 3) break;
  }
  if (out.length < 3) {
    // very small decimals: widen with additive offsets
    const step = Math.pow(10, -n.decimals);
    for (const d of [1, -1, 2, -2, 3, 5]) {
      const text = formatNumber(n, n.value + d * step * 10);
      if (text === correct || out.includes(text)) continue;
      out.push(text);
      if (out.length === 3) break;
    }
  }
  return out.length === 3 ? out : null;
}

// ---------- pools

type TermItem = {
  term: string;
  def: string;
  section: string;
  topic: string;
  topicKey: string;
};
type FormulaItem = {
  name: string;
  formula: string;
  section: string;
  topic: string;
  topicKey: string;
  sample: string[];
};

const PREFIX = /^Admin Reviewer:\s*/;

function collect(sections: SectionGroup[], topicKeys: Set<string>) {
  const terms: TermItem[] = [];
  const formulas: FormulaItem[] = [];
  for (const s of sections) {
    for (const t of s.topics) {
      if (!topicKeys.has(t.key)) continue;
      for (const p of t.rows) {
        if (
          p.row.kind === "table" &&
          p.row.title.endsWith("Terms and Definitions")
        ) {
          for (const l of lines(p.row.table_content)) {
            const i = l.indexOf(" | ");
            if (i > 0)
              terms.push({
                term: l.slice(0, i),
                def: l.slice(i + 3),
                section: s.section,
                topic: t.topic,
                topicKey: t.key,
              });
          }
        } else if (p.row.kind === "formula" && p.row.formula) {
          formulas.push({
            name: p.row.title.replace(PREFIX, ""),
            formula: lines(p.row.formula)
              .flatMap((l) => l.split(/\s{2,}/))
              .join("   ;   "),
            section: s.section,
            topic: t.topic,
            topicKey: t.key,
            sample: lines(p.row.table_content),
          });
        }
      }
    }
  }
  return { terms, formulas };
}

function pickDistractors<T>(
  pool: T[],
  key: (t: T) => string,
  correct: string,
  sameFirst: (t: T) => boolean,
  rng: Rng,
  n = 3,
): string[] | null {
  const seen = new Set<string>([correct]);
  const out: string[] = [];
  for (const group of [
    shuffle(pool.filter(sameFirst), rng),
    shuffle(
      pool.filter((p) => !sameFirst(p)),
      rng,
    ),
  ]) {
    for (const item of group) {
      const k = key(item);
      if (!k || seen.has(k)) continue;
      seen.add(k);
      out.push(k);
      if (out.length === n) return out;
    }
  }
  return null;
}

function place(
  correct: string,
  distractors: string[],
  rng: Rng,
): { choices: string[]; correct: number } {
  const choices = shuffle([correct, ...distractors], rng);
  return { choices, correct: choices.indexOf(correct) };
}

export function availableCounts(
  rows: MidtermRow[],
  topicKeys: Set<string>,
): Record<QuestionKind, number> {
  const { terms, formulas } = collect(group(rows), topicKeys);
  const solving = formulas.filter(
    (f) =>
      f.sample.length >= 2 &&
      f.sample[0].startsWith("Sample problem:") &&
      numericDistractors(
        f.sample[f.sample.length - 1].replace(/^Answer:\s*/, ""),
      ) !== null,
  ).length;
  return {
    term: terms.length >= 4 ? terms.length : 0,
    definition:
      terms.filter((t) => t.def.length <= 300).length >= 4 ? terms.length : 0,
    formula: formulas.length >= 4 ? formulas.length : 0,
    solving,
  };
}

export function buildExam(
  rows: MidtermRow[],
  config: ExamConfig,
  rng: Rng = Math.random,
): ExamQuestion[] {
  const { terms, formulas } = collect(group(rows), config.topicKeys);
  // distractors may come from anywhere in the selection (preferring the same section)
  const byKind: Record<QuestionKind, ExamQuestion[]> = {
    term: [],
    definition: [],
    formula: [],
    solving: [],
  };
  let n = 0;

  if (config.kinds.includes("term") && terms.length >= 4) {
    for (const t of terms) {
      const d = pickDistractors(
        terms,
        (x) => x.def,
        t.def,
        (x) => x.section === t.section,
        rng,
      );
      if (!d) continue;
      byKind.term.push({
        id: `t${n++}`,
        kind: "term",
        section: t.section,
        topic: t.topic,
        prompt: `Which of the following best describes “${t.term}”?`,
        ...place(t.def, d, rng),
        explain: [`${t.term}: ${t.def}`],
      });
    }
  }
  if (config.kinds.includes("definition") && terms.length >= 4) {
    for (const t of terms) {
      if (t.def.length > 300) continue;
      const d = pickDistractors(
        terms,
        (x) => x.term,
        t.term,
        (x) => x.section === t.section,
        rng,
      );
      if (!d) continue;
      byKind.definition.push({
        id: `d${n++}`,
        kind: "definition",
        section: t.section,
        topic: t.topic,
        prompt: `Which term is described by: ${t.def}`,
        ...place(t.term, d, rng),
        explain: [`${t.term}: ${t.def}`],
      });
    }
  }
  if (config.kinds.includes("formula") && formulas.length >= 4) {
    for (const f of formulas) {
      const d = pickDistractors(
        formulas,
        (x) => x.formula,
        f.formula,
        (x) => x.section === f.section,
        rng,
      );
      if (!d) continue;
      byKind.formula.push({
        id: `f${n++}`,
        kind: "formula",
        section: f.section,
        topic: f.topic,
        prompt: `Which formula gives “${f.name}”?`,
        ...place(f.formula, d, rng),
        explain: [`${f.name}: ${f.formula}`],
      });
    }
  }
  if (config.kinds.includes("solving")) {
    for (const f of formulas) {
      if (f.sample.length < 2 || !f.sample[0].startsWith("Sample problem:"))
        continue;
      const answer = f.sample[f.sample.length - 1].replace(/^Answer:\s*/, "");
      const d = numericDistractors(answer, rng);
      if (!d) continue;
      byKind.solving.push({
        id: `s${n++}`,
        kind: "solving",
        section: f.section,
        topic: f.topic,
        prompt: f.sample[0].replace(/^Sample problem:\s*/, ""),
        ...place(answer, d, rng),
        explain: [
          `Formula: ${f.formula}`,
          ...f.sample.slice(1, -1),
          `Answer: ${answer}`,
        ],
      });
    }
  }

  const kinds = config.kinds.filter((k) => byKind[k].length > 0);
  if (kinds.length === 0) return [];
  const share = Math.ceil(config.count / kinds.length);
  let picked: ExamQuestion[] = kinds.flatMap((k) =>
    shuffle(byKind[k], rng).slice(0, share),
  );
  if (picked.length < config.count) {
    // top up from whatever is left among the chosen kinds
    const have = new Set(picked.map((q) => q.id));
    picked = picked.concat(
      shuffle(
        kinds.flatMap((k) => byKind[k]).filter((q) => !have.has(q.id)),
        rng,
      ).slice(0, config.count - picked.length),
    );
  }
  return shuffle(picked, rng).slice(0, config.count);
}
