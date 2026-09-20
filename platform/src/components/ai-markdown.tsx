"use client";

import ReactMarkdown, { type Components } from "react-markdown";
import remarkGfm from "remark-gfm";
import remarkMath from "remark-math";
import rehypeKatex from "rehype-katex";

// Gemini's explanations mix markdown (###, **bold**, lists) with LaTeX math
// ($x$ inline, $$x$$ display) in every possible combination — a bold
// heading with math inside it, a numbered list item that IS a bold heading,
// math inside a bullet, etc. Hand-rolled line-by-line regex parsing (the
// previous approach) meant every new combination Gemini happened to use was
// a new bug to patch one at a time. A real markdown+math AST pipeline
// handles arbitrary nesting correctly by construction instead.
const components: Components = {
  h1: ({ children }) => <Heading>{children}</Heading>,
  h2: ({ children }) => <Heading>{children}</Heading>,
  h3: ({ children }) => <Heading>{children}</Heading>,
  h4: ({ children }) => <Heading>{children}</Heading>,
  p: ({ children }) => <p className="mt-1.5 text-sm leading-relaxed text-foreground first:mt-0">{children}</p>,
  ul: ({ children }) => <ul className="mt-1.5 ml-4 list-disc space-y-1 text-sm text-foreground">{children}</ul>,
  ol: ({ children, start }) => (
    <ol start={start} className="mt-1.5 ml-4 list-decimal space-y-1 text-sm text-foreground">
      {children}
    </ol>
  ),
  li: ({ children }) => <li className="leading-relaxed">{children}</li>,
  strong: ({ children }) => <strong className="font-semibold text-foreground">{children}</strong>,
  em: ({ children }) => <em>{children}</em>,
  code: ({ children }) => <code className="rounded bg-muted px-1 py-0.5 font-mono text-xs">{children}</code>,
  a: ({ children, href }) => (
    <a href={href} target="_blank" rel="noreferrer" className="text-primary underline underline-offset-2">
      {children}
    </a>
  ),
};

function Heading({ children }: { children?: React.ReactNode }) {
  return <p className="mt-3 text-xs font-semibold uppercase tracking-wide text-primary first:mt-0">{children}</p>;
}

/** Renders AI-generated markdown + LaTeX text (Teach Me This, Study Assistant) with a real parser instead of ad hoc regex, so any markdown/math combination Gemini produces renders correctly rather than needing to be individually special-cased. trust: false and strict: "ignore" keep unsafe/malformed LaTeX from breaking the render, appropriate since this is AI-generated, not directly user-typed, text. */
export function AIMarkdown({ text }: { text: string }) {
  return (
    <div className="overflow-x-auto">
      <ReactMarkdown
        remarkPlugins={[remarkGfm, remarkMath]}
        rehypePlugins={[[rehypeKatex, { trust: false, strict: "ignore" }]]}
        components={components}
      >
        {text}
      </ReactMarkdown>
    </div>
  );
}
