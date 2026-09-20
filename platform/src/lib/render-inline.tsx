import type { ReactElement } from "react";
import katex from "katex";

/** Gemini writes formulas as LaTeX ($x$ inline, $$x$$ display) even though nothing here asked it to — rendering that raw as literal text (dollar signs, \frac{}{}, \times) is what "not clean" looked like. KaTeX renders it properly instead. trust: false keeps unsafe LaTeX commands (e.g. \href) disabled even though this is AI-generated, not directly user-typed, text. */
function renderMath(tex: string, displayMode: boolean, key: number) {
  try {
    const html = katex.renderToString(tex, { throwOnError: false, trust: false, displayMode });
    return <span key={key} dangerouslySetInnerHTML={{ __html: html }} />;
  } catch {
    return <code key={key}>{tex}</code>;
  }
}

/** Standalone display-mode equation for a line that is entirely "$$...$$". */
export function renderBlockMath(tex: string) {
  return <div className="my-2 overflow-x-auto text-center">{renderMath(tex, true, 0)}</div>;
}

/** Strips the minimal markdown Gemini responses tend to use (**bold**, *italic*) and renders inline $...$ LaTeX math, so neither leaks as literal characters. */
export function renderInline(line: string) {
  const pattern = /\*\*(.+?)\*\*|\*(.+?)\*|\$(.+?)\$/g;
  const nodes: (string | ReactElement)[] = [];
  let lastIndex = 0;
  let match: RegExpExecArray | null;
  let key = 0;

  while ((match = pattern.exec(line)) !== null) {
    if (match.index > lastIndex) nodes.push(line.slice(lastIndex, match.index));
    if (match[1] !== undefined) nodes.push(<strong key={key++}>{match[1]}</strong>);
    else if (match[2] !== undefined) nodes.push(<em key={key++}>{match[2]}</em>);
    else nodes.push(renderMath(match[3], false, key++));
    lastIndex = match.index + match[0].length;
  }
  if (lastIndex < line.length) nodes.push(line.slice(lastIndex));

  return nodes;
}
