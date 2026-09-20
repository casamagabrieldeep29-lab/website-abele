"use client";

import { useMemo, useState } from "react";
import { ChevronRight } from "lucide-react";
import { Collapsible, CollapsibleContent, CollapsibleTrigger } from "@/components/ui/collapsible";
import { Button } from "@/components/ui/button";

export type TopicPickerTopic = { id: string; name: string };

export type TopicPickerSubject = {
  id: string;
  name: string;
  topics: TopicPickerTopic[];
};

export type TopicPickerArea = {
  id: string;
  name: string;
  subjects: TopicPickerSubject[];
};

export function TopicPicker({ areas }: { areas: TopicPickerArea[] }) {
  const [openIds, setOpenIds] = useState<Set<string>>(new Set());

  const allIds = useMemo(() => {
    const ids: string[] = [];
    for (const area of areas) {
      ids.push(`a:${area.id}`);
      for (const subject of area.subjects) ids.push(`s:${subject.id}`);
    }
    return ids;
  }, [areas]);

  function isOpen(id: string) {
    return openIds.has(id);
  }

  function toggle(id: string) {
    setOpenIds((prev) => {
      const next = new Set(prev);
      if (next.has(id)) next.delete(id);
      else next.add(id);
      return next;
    });
  }

  return (
    <div className="space-y-2">
      <div className="flex justify-end gap-2">
        <Button type="button" size="sm" variant="outline" onClick={() => setOpenIds(new Set(allIds))}>
          Expand All
        </Button>
        <Button type="button" size="sm" variant="outline" onClick={() => setOpenIds(new Set())}>
          Collapse All
        </Button>
      </div>

      <div className="space-y-2">
        {areas.map((area) => {
          const areaOpen = isOpen(`a:${area.id}`);
          return (
            <div key={area.id} className="rounded-lg border border-border/60 bg-card">
              <Collapsible open={areaOpen} onOpenChange={() => toggle(`a:${area.id}`)}>
                <CollapsibleTrigger className="flex w-full items-center gap-2 px-3 py-2.5 text-left">
                  <ChevronRight className="size-4 shrink-0 text-muted-foreground transition-transform duration-200 group-data-open:rotate-90" />
                  <span className="text-sm font-semibold break-words">{area.name}</span>
                </CollapsibleTrigger>

                <CollapsibleContent open={areaOpen}>
                  <div className="space-y-1.5 px-3 pb-3">
                    {area.subjects.length === 0 && (
                      <p className="pl-6 text-xs text-muted-foreground">No subjects yet.</p>
                    )}
                    {area.subjects.map((subject) => {
                      const subjectOpen = isOpen(`s:${subject.id}`);
                      return (
                        <div key={subject.id} className="rounded-md border border-border/60 bg-background/40">
                          <Collapsible open={subjectOpen} onOpenChange={() => toggle(`s:${subject.id}`)}>
                            <CollapsibleTrigger className="flex w-full items-center gap-2 px-3 py-2 text-left">
                              <ChevronRight className="size-3.5 shrink-0 text-muted-foreground transition-transform duration-200 group-data-open:rotate-90" />
                              <span className="min-w-0 flex-1 text-sm font-medium break-words">{subject.name}</span>
                            </CollapsibleTrigger>

                            <CollapsibleContent open={subjectOpen}>
                              <div className="space-y-1.5 px-3 pb-2.5 pl-8">
                                {subject.topics.length === 0 && (
                                  <p className="text-xs text-muted-foreground">No topics yet.</p>
                                )}
                                {subject.topics.map((topic) => (
                                  <label key={topic.id} className="flex items-center gap-2 text-sm">
                                    <input
                                      type="checkbox"
                                      name="topicIds"
                                      value={topic.id}
                                      className="h-4 w-4 rounded border-border"
                                    />
                                    {topic.name}
                                  </label>
                                ))}
                              </div>
                            </CollapsibleContent>
                          </Collapsible>
                        </div>
                      );
                    })}
                  </div>
                </CollapsibleContent>
              </Collapsible>
            </div>
          );
        })}
      </div>
    </div>
  );
}
