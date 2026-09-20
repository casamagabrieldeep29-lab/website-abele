import type { ReactElement, ReactNode } from "react";
import katex from "katex";

/** Gemini writes formulas as LaTeX ($x$ inline, $$x$$ display) even though nothing here asked it to — rendering that raw as literal text (dollar signs, \frac{}{}, \times) is what "not clean" looked like. KaTeX renders it properly instead. trust: false keeps unsafe LaTeX commands (e.g. \href) disabled even though this is AI-generated, not directly user-typed, text. */
function renderMath(tex: string, displayMode: boolean, key: string) {
  try {
    const html = katex.renderToString(tex, { throwOnError: false, trust: false, displayMode });
    return <span key={key} dangerouslySetInnerHTML={{ __html: html }} />;
  } catch {
    return <code key={key}>{tex}</code>;
  }
}

/** Standalone display-mode equation for a line that is entirely "$$...$$". */
export function renderBlockMath(tex: string) {
  return <div className="my-2 overflow-x-auto text-center">{renderMath(tex, true, "block")}</div>;
}

/** Renders inline $...$ math within a plain run of text, with no bold/italic parsing — used both at the top level and recursively inside bold/italic content, since Gemini often writes headings like "**Design Pressure ($P_v$):**" with the math nested inside the bold markers. */
function renderMathRuns(text: string, keyPrefix: string): ReactNode[] {
  const pattern = /\$(.+?)\$/g;
  const nodes: (string | ReactElement)[] = [];
  let lastIndex = 0;
  let match: RegExpExecArray | null;
  let i = 0;

  while ((match = pattern.exec(text)) !== null) {
    if (match.index > lastIndex) nodes.push(text.slice(lastIndex, match.index));
    nodes.push(renderMath(match[1], false, `${keyPrefix}-m${i++}`));
    lastIndex = match.index + match[0].length;
  }
  if (lastIndex < text.length) nodes.push(text.slice(lastIndex));

  return nodes;
}

/** Strips the minimal markdown Gemini responses tend to use (**bold**, *italic*) and renders inline $...$ LaTeX math anywhere it appears — including nested inside bold/italic, not just at the top level. */
export function renderInline(line: string): ReactNode[] {
  const pattern = /\*\*(.+?)\*\*|\*(.+?)\*|\$(.+?)\$/g;
  const nodes: (string | ReactElement)[] = [];
  let lastIndex = 0;
  let match: RegExpExecArray | null;
  let i = 0;

  while ((match = pattern.exec(line)) !== null) {
    if (match.index > lastIndex) nodes.push(line.slice(lastIndex, match.index));
    if (match[1] !== undefined) {
      nodes.push(<strong key={`b${i}`}>{renderMathRuns(match[1], `b${i}`)}</strong>);
    } else if (match[2] !== undefined) {
      nodes.push(<em key={`i${i}`}>{renderMathRuns(match[2], `i${i}`)}</em>);
    } else {
      nodes.push(renderMath(match[3], false, `m${i}`));
    }
    i++;
    lastIndex = match.index + match[0].length;
  }
  if (lastIndex < line.length) nodes.push(line.slice(lastIndex));

  return nodes;
}
