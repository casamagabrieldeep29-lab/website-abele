// Shared, framework-free helpers for the admin-only Midterm Reviewer and its exam.
// Rows carry their place in the reviewer in `notes`:
// MIDTERM|<topic order>|<item order>|<section>|<topic title>

export type MidtermRow = {
  id: string;
  kind: "formula" | "table" | "constant";
  title: string;
  formula: string | null;
  variables: string | null;
  table_content: string | null;
  description: string | null;
  notes: string | null;
};

export type Parsed = {
  row: MidtermRow;
  item: number;
  section: string;
  topic: string;
  topicOrder: number;
};
export type TopicGroup = {
  key: string;
  topic: string;
  order: number;
  rows: Parsed[];
};
export type SectionGroup = { section: string; topics: TopicGroup[] };

function parse(row: MidtermRow): Parsed | null {
  const parts = row.notes?.split("|");
  if (!parts || parts[0] !== "MIDTERM" || parts.length < 5) return null;
  return {
    row,
    topicOrder: Number(parts[1]),
    item: Number(parts[2]),
    section: parts[3],
    topic: parts.slice(4).join("|"),
  };
}

export function group(rows: MidtermRow[]): SectionGroup[] {
  const topics = new Map<number, TopicGroup & { section: string }>();
  for (const r of rows) {
    const p = parse(r);
    if (!p) continue;
    let g = topics.get(p.topicOrder);
    if (!g) {
      g = {
        key: String(p.topicOrder),
        topic: p.topic,
        order: p.topicOrder,
        rows: [],
        section: p.section,
      };
      topics.set(p.topicOrder, g);
    }
    g.rows.push(p);
  }
  const sections: SectionGroup[] = [];
  for (const g of [...topics.values()].sort((a, b) => a.order - b.order)) {
    g.rows.sort((a, b) => a.item - b.item);
    const last = sections[sections.length - 1];
    if (last && last.section === g.section) last.topics.push(g);
    else sections.push({ section: g.section, topics: [g] });
  }
  return sections;
}

export function lines(text: string | null): string[] {
  return (text ?? "")
    .split("\n")
    .map((l) => l.trim())
    .filter(Boolean);
}
