// Restrained, token-driven variety for telling exam areas/topics apart —
// deliberately teal + neutral only. Gold is reserved for genuine milestones
// (achievements/streaks), so it never appears here just for decoration, and
// one of the three variants is fully neutral so not every card ends up
// colorful. Same key always maps to the same accent (deterministic hash), so
// an exam area's color stays consistent across pages/sessions.
const HARMONIZED_ACCENTS = [
  { border: "border-l-primary", bg: "bg-primary/5", badge: "bg-primary text-primary-foreground" },
  { border: "border-l-border", bg: "bg-secondary/40", badge: "bg-secondary text-secondary-foreground" },
  { border: "border-l-muted-foreground/40", bg: "bg-muted/30", badge: "bg-muted text-muted-foreground" },
] as const;

export function getHarmonizedAccent(key: string) {
  let hash = 0;
  for (let i = 0; i < key.length; i++) hash = (hash * 31 + key.charCodeAt(i)) >>> 0;
  return HARMONIZED_ACCENTS[hash % HARMONIZED_ACCENTS.length];
}
