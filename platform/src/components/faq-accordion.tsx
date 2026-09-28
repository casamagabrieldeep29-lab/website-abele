"use client";

import { useState } from "react";
import Link from "next/link";
import { ChevronDown } from "lucide-react";
import { Collapsible, CollapsibleContent, CollapsibleTrigger } from "@/components/ui/collapsible";

type FaqItem = { question: string; answer: React.ReactNode };

// Every answer here matches how the product actually behaves — the price,
// trial length, payment methods, and verification flow are the same ones
// /signup and /upgrade already use, not separately-maintained marketing copy.
const FAQ_ITEMS: FaqItem[] = [
  {
    question: "How much does ABELIEVER cost?",
    answer: "₱159, one time. Not a subscription — pay once and keep full access for good.",
  },
  {
    question: "Is there a free trial?",
    answer:
      "Yes. You can skip payment during signup and start a short free trial instead, then decide whether to pay afterward from your dashboard.",
  },
  {
    question: "What payment methods do you accept?",
    answer: "GCash, Maya, or Landbank — pay directly in your own app, then tell us the reference number.",
  },
  {
    question: "How long does payment verification take?",
    answer:
      "If you attach a receipt screenshot, it's usually checked and approved within minutes. Without one, it's reviewed by hand, usually within a day.",
  },
  {
    question: "Is this official PRC review material?",
    answer:
      "No. ABELIEVER is an independent review platform organized around the official PRC Table of Specifications, not published or endorsed by the PRC/PRC-BRD. Always verify exam coverage details against official sources.",
  },
  {
    question: "Is my data safe?",
    answer: (
      <>
        Yes — see our{" "}
        <Link href="/privacy" className="text-primary hover:underline">
          Privacy Policy
        </Link>{" "}
        for exactly what we collect and why.
      </>
    ),
  },
  {
    question: "Do I need a password?",
    answer:
      "No — you can sign in with a one-time code sent to your email instead. Setting a password is optional, for whichever you find more convenient.",
  },
  {
    question: "I already have an account. Where do I sign in?",
    answer: (
      <>
        Head to{" "}
        <Link href="/login" className="text-primary hover:underline">
          the sign-in page
        </Link>
        .
      </>
    ),
  },
];

function FaqRow({ item }: { item: FaqItem }) {
  const [open, setOpen] = useState(false);

  return (
    <div className="border-b border-border/70 last:border-b-0">
      <Collapsible open={open} onOpenChange={setOpen}>
        <CollapsibleTrigger className="flex w-full items-center justify-between gap-4 py-4 text-left">
          <span className="text-sm font-medium">{item.question}</span>
          <ChevronDown className={`size-4 shrink-0 text-muted-foreground transition-transform duration-200 ${open ? "rotate-180" : ""}`} />
        </CollapsibleTrigger>
        <CollapsibleContent open={open}>
          <p className="pb-4 pr-8 text-sm leading-relaxed text-muted-foreground">{item.answer}</p>
        </CollapsibleContent>
      </Collapsible>
    </div>
  );
}

export function FaqAccordion() {
  return (
    <div className="mt-8 divide-y-0">
      {FAQ_ITEMS.map((item) => (
        <FaqRow key={item.question} item={item} />
      ))}
    </div>
  );
}
