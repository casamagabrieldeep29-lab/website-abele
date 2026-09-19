import { Card, CardContent } from "@/components/ui/card";
import type { LucideIcon } from "lucide-react";

// Gold is intentionally reserved for milestone-flavored stats (streaks,
// mastered counts) — everything else stays teal/neutral so the dashboard
// doesn't turn into a wall of different colors per stat.
export const STAT_ACCENTS = {
  primary: { icon: "bg-primary/15 text-primary", border: "border-l-primary", bar: "bg-primary" },
  secondary: { icon: "bg-secondary text-secondary-foreground", border: "border-l-border", bar: "bg-secondary-foreground/40" },
  gold: { icon: "bg-gold/15 text-gold", border: "border-l-gold", bar: "bg-gold" },
} as const;

/** Shared by /dashboard and /profile so the same stat always looks the same way. */
export function StatCard({
  icon: Icon,
  label,
  value,
  barPercent,
  accent,
}: {
  icon: LucideIcon;
  label: string;
  value: string;
  barPercent?: number | null;
  accent: keyof typeof STAT_ACCENTS;
}) {
  const a = STAT_ACCENTS[accent];
  return (
    <Card className={`border-l-4 ${a.border}`}>
      <CardContent className="py-4">
        <div className="flex items-center justify-between">
          <p className="text-2xl font-semibold tracking-tight">{value}</p>
          <div className={`flex size-7 items-center justify-center rounded-md ${a.icon}`}>
            <Icon className="size-4" />
          </div>
        </div>
        <p className="mt-1 text-xs text-muted-foreground">{label}</p>
        {barPercent !== undefined && barPercent !== null && (
          <div className="mt-2 h-1 overflow-hidden rounded-full bg-muted">
            <div className={`h-full rounded-full ${a.bar}`} style={{ width: `${Math.min(100, barPercent)}%` }} />
          </div>
        )}
      </CardContent>
    </Card>
  );
}
