import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { Label } from "@/components/ui/label";
import { startCustomQuiz } from "../practice/actions";

type TopicOption = { id: string; name: string; examAreaName: string };

const DIFFICULTIES = [
  { value: "easy", label: "Easy" },
  { value: "medium", label: "Medium" },
  { value: "hard", label: "Hard" },
];

const SOURCES = [
  { value: "all", label: "All questions" },
  { value: "incorrect", label: "Only questions I've gotten wrong" },
  { value: "unanswered", label: "Only questions I haven't tried yet" },
];

export function QuizBuilderForm({
  topics,
  showNoMatchError,
}: {
  topics: TopicOption[];
  showNoMatchError: boolean;
}) {
  return (
    <Card className="mt-6">
      <CardContent className="pt-6">
        <form action={startCustomQuiz} className="space-y-6">
          <fieldset className="space-y-2">
            <legend className="text-sm font-medium">
              Topics <span className="text-muted-foreground">(leave all unchecked for every topic)</span>
            </legend>
            <div className="space-y-1.5">
              {topics.map((t) => (
                <label key={t.id} className="flex items-center gap-2 text-sm">
                  <input type="checkbox" name="topicIds" value={t.id} className="h-4 w-4 rounded border-border" />
                  {t.name} <span className="text-muted-foreground">({t.examAreaName})</span>
                </label>
              ))}
            </div>
          </fieldset>

          <fieldset className="space-y-2">
            <legend className="text-sm font-medium">
              Difficulty <span className="text-muted-foreground">(leave all unchecked for any)</span>
            </legend>
            <div className="flex gap-4">
              {DIFFICULTIES.map((d) => (
                <label key={d.value} className="flex items-center gap-2 text-sm">
                  <input type="checkbox" name="difficulties" value={d.value} className="h-4 w-4 rounded border-border" />
                  {d.label}
                </label>
              ))}
            </div>
          </fieldset>

          <fieldset className="space-y-2">
            <legend className="text-sm font-medium">Question source</legend>
            <div className="space-y-1.5">
              {SOURCES.map((s, i) => (
                <label key={s.value} className="flex items-center gap-2 text-sm">
                  <input type="radio" name="source" value={s.value} defaultChecked={i === 0} className="h-4 w-4" />
                  {s.label}
                </label>
              ))}
            </div>
          </fieldset>

          <div className="space-y-2">
            <Label htmlFor="count">Number of questions</Label>
            <input
              id="count"
              name="count"
              type="number"
              min={1}
              max={100}
              defaultValue={20}
              className="w-full rounded-md border border-border bg-background px-3 py-2 text-sm"
            />
          </div>

          {showNoMatchError && (
            <p className="text-sm text-destructive">
              No published questions matched those filters — try widening them.
            </p>
          )}

          <Button type="submit" className="w-full">
            Generate quiz
          </Button>
        </form>
      </CardContent>
    </Card>
  );
}
