import type { ReactElement } from "react";

/** Strips the minimal markdown Gemini responses tend to use (**bold**, *italic*) so it doesn't leak as literal asterisks. */
export function renderInline(line: string) {
  const pattern = /\*\*(.+?)\*\*|\*(.+?)\*/g;
  const nodes: (string | ReactElement)[] = [];
  let lastIndex = 0;
  let match: RegExpExecArray | null;
  let key = 0;

  while ((match = pattern.exec(line)) !== null) {
    if (match.index > lastIndex) nodes.push(line.slice(lastIndex, match.index));
    if (match[1] !== undefined) nodes.push(<strong key={key++}>{match[1]}</strong>);
    else nodes.push(<em key={key++}>{match[2]}</em>);
    lastIndex = match.index + match[0].length;
  }
  if (lastIndex < line.length) nodes.push(line.slice(lastIndex));

  return nodes;
}
