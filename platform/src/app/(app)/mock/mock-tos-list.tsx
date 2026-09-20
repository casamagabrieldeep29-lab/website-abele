export type MockSubject = {
  id: string;
  name: string;
};

/**
 * Flat list of the official Subjects covered by one Mock Exam area — not
 * grouped under their TOS category, since an Area can span several TOS
 * categories (e.g. Area 1 = Power/Machinery + Project Mgmt/RDE + Laws/
 * Ethics) and nesting by TOS just added a layer with nothing to actually
 * expand into. Subjects have no further drill-down here (Mock Exam pulls
 * from the whole area, not a chosen subject), so this is a plain list.
 */
export function MockTosList({ subjects }: { subjects: MockSubject[] }) {
  if (subjects.length === 0) {
    return <p className="text-sm text-muted-foreground">No topics assigned to this area yet.</p>;
  }

  return (
    <ul className="space-y-1 text-sm text-muted-foreground">
      {subjects.map((s) => (
        <li key={s.id} className="flex items-center gap-2">
          <span className="size-1 shrink-0 rounded-full bg-muted-foreground/50" />
          {s.name}
        </li>
      ))}
    </ul>
  );
}
