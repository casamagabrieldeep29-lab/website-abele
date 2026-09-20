"use client";

import { useMemo, useState } from "react";
import { ChevronRight } from "lucide-react";
import { Collapsible, CollapsibleContent, CollapsibleTrigger } from "@/components/ui/collapsible";
import { Button } from "@/components/ui/button";

export type TOSGroup = {
  id: string;
  name: string;
  subjects: { id: string; name: string }[];
};

/** Compact TOS -> Subject accordion shown inside one Mock Exam area card. Collapsed by default; the Start Exam button lives outside this component so it stays visible regardless of TOS expand state. */
export function MockTosList({ groups }: { groups: TOSGroup[] }) {
  const [openIds, setOpenIds] = useState<Set<string>>(new Set());

  const allIds = useMemo(() => groups.map((g) => g.id), [groups]);

  function toggle(id: string) {
    setOpenIds((prev) => {
      const next = new Set(prev);
      if (next.has(id)) next.delete(id);
      else next.add(id);
      return next;
    });
  }

  if (groups.length === 0) {
    return <p className="text-sm text-muted-foreground">No topics assigned to this area yet.</p>;
  }

  return (
    <div className="space-y-1.5">
      <div className="flex justify-end gap-2">
        <Button type="button" size="sm" variant="ghost" onClick={() => setOpenIds(new Set(allIds))}>
          Expand All
        </Button>
        <Button type="button" size="sm" variant="ghost" onClick={() => setOpenIds(new Set())}>
          Collapse All
        </Button>
      </div>
      {groups.map((group) => {
        const isOpen = openIds.has(group.id);
        return (
          <div key={group.id} className="rounded-md border border-border/50">
            <Collapsible open={isOpen} onOpenChange={() => toggle(group.id)}>
              <CollapsibleTrigger className="flex w-full items-center gap-2 px-2.5 py-1.5 text-left">
                <ChevronRight className="size-3.5 shrink-0 text-muted-foreground transition-transform duration-200 group-data-open:rotate-90" />
                <span className="min-w-0 flex-1 text-sm font-medium break-words">{group.name}</span>
              </CollapsibleTrigger>
              <CollapsibleContent open={isOpen}>
                <ul className="space-y-1 px-2.5 pb-2 pl-6 text-sm text-muted-foreground">
                  {group.subjects.map((s) => (
                    <li key={s.id}>{s.name}</li>
                  ))}
                </ul>
              </CollapsibleContent>
            </Collapsible>
          </div>
        );
      })}
    </div>
  );
}
