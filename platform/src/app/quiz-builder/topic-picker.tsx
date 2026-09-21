"use client";

import { useEffect, useMemo, useRef, useState } from "react";
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

function GroupCheckbox({
  checked,
  indeterminate,
  onChange,
  label,
}: {
  checked: boolean;
  indeterminate: boolean;
  onChange: (checked: boolean) => void;
  label: string;
}) {
  const ref = useRef<HTMLInputElement>(null);

  useEffect(() => {
    if (ref.current) ref.current.indeterminate = indeterminate;
  }, [indeterminate]);

  return (
    <input
      ref={ref}
      type="checkbox"
      aria-label={`Select all topics in ${label}`}
      className="h-4 w-4 shrink-0 rounded border-border"
      checked={checked}
      onClick={(e) => e.stopPropagation()}
      onChange={(e) => onChange(e.target.checked)}
    />
  );
}

export function TopicPicker({ areas }: { areas: TopicPickerArea[] }) {
  const [openIds, setOpenIds] = useState<Set<string>>(new Set());
  const [selected, setSelected] = useState<Set<string>>(new Set());

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

  function toggleOpen(id: string) {
    setOpenIds((prev) => {
      const next = new Set(prev);
      if (next.has(id)) next.delete(id);
      else next.add(id);
      return next;
    });
  }

  function setGroupSelected(topicIds: string[], checked: boolean) {
    setSelected((prev) => {
      const next = new Set(prev);
      for (const id of topicIds) {
        if (checked) next.add(id);
        else next.delete(id);
      }
      return next;
    });
  }

  function toggleTopic(id: string) {
    setSelected((prev) => {
      const next = new Set(prev);
      if (next.has(id)) next.delete(id);
      else next.add(id);
      return next;
    });
  }

  return (
    <div className="space-y-2">
      {/* Base UI's Collapsible.Panel doesn't mount its children until opened
          at least once (keepMounted defaults to false), so a topic checkbox
          inside a subject the student never expanded — e.g. checked only via
          that subject's "select all" box — would never make it into the
          form's data. These hidden inputs carry the real `topicIds` values
          straight from React state instead, independent of what's currently
          expanded; the visible per-topic checkboxes below are UI-state only. */}
      {[...selected].map((id) => (
        <input key={id} type="hidden" name="topicIds" value={id} />
      ))}

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
          const areaTopicIds = area.subjects.flatMap((s) => s.topics.map((t) => t.id));
          const areaSelectedCount = areaTopicIds.filter((id) => selected.has(id)).length;

          return (
            <div key={area.id} className="rounded-lg border border-border/60 bg-card">
              <div className="flex items-center gap-2 px-3 py-2.5">
                <GroupCheckbox
                  label={area.name}
                  checked={areaTopicIds.length > 0 && areaSelectedCount === areaTopicIds.length}
                  indeterminate={areaSelectedCount > 0 && areaSelectedCount < areaTopicIds.length}
                  onChange={(checked) => setGroupSelected(areaTopicIds, checked)}
                />
                <Collapsible open={areaOpen} onOpenChange={() => toggleOpen(`a:${area.id}`)} className="min-w-0 flex-1">
                  <CollapsibleTrigger className="flex w-full items-center gap-2 text-left">
                    <ChevronRight className="size-4 shrink-0 text-muted-foreground transition-transform duration-200 group-data-open:rotate-90" />
                    <span className="text-sm font-semibold break-words">{area.name}</span>
                    {areaSelectedCount > 0 && (
                      <span className="shrink-0 text-xs font-normal text-muted-foreground">
                        ({areaSelectedCount} selected)
                      </span>
                    )}
                  </CollapsibleTrigger>
                </Collapsible>
              </div>

              <Collapsible open={areaOpen}>
                <CollapsibleContent open={areaOpen}>
                  <div className="space-y-1.5 px-3 pb-3">
                    {area.subjects.length === 0 && (
                      <p className="pl-6 text-xs text-muted-foreground">No subjects yet.</p>
                    )}
                    {area.subjects.map((subject) => {
                      const subjectOpen = isOpen(`s:${subject.id}`);
                      const subjectTopicIds = subject.topics.map((t) => t.id);
                      const subjectSelectedCount = subjectTopicIds.filter((id) => selected.has(id)).length;

                      return (
                        <div key={subject.id} className="rounded-md border border-border/60 bg-background/40">
                          <div className="flex items-center gap-2 px-3 py-2">
                            <GroupCheckbox
                              label={subject.name}
                              checked={subjectTopicIds.length > 0 && subjectSelectedCount === subjectTopicIds.length}
                              indeterminate={subjectSelectedCount > 0 && subjectSelectedCount < subjectTopicIds.length}
                              onChange={(checked) => setGroupSelected(subjectTopicIds, checked)}
                            />
                            <Collapsible
                              open={subjectOpen}
                              onOpenChange={() => toggleOpen(`s:${subject.id}`)}
                              className="min-w-0 flex-1"
                            >
                              <CollapsibleTrigger className="flex w-full min-w-0 items-center gap-2 text-left">
                                <ChevronRight className="size-3.5 shrink-0 text-muted-foreground transition-transform duration-200 group-data-open:rotate-90" />
                                <span className="min-w-0 flex-1 text-sm font-medium break-words">{subject.name}</span>
                                {subjectSelectedCount > 0 && (
                                  <span className="shrink-0 text-xs font-normal text-muted-foreground">
                                    ({subjectSelectedCount} selected)
                                  </span>
                                )}
                              </CollapsibleTrigger>
                            </Collapsible>
                          </div>

                          <Collapsible open={subjectOpen}>
                            <CollapsibleContent open={subjectOpen}>
                              <div className="space-y-1.5 px-3 pb-2.5 pl-8">
                                {subject.topics.length === 0 && (
                                  <p className="text-xs text-muted-foreground">No topics yet.</p>
                                )}
                                {subject.topics.map((topic) => (
                                  <label key={topic.id} className="flex items-center gap-2 text-sm">
                                    <input
                                      type="checkbox"
                                      className="h-4 w-4 rounded border-border"
                                      checked={selected.has(topic.id)}
                                      onChange={() => toggleTopic(topic.id)}
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
