"use client"

import { Collapsible as CollapsiblePrimitive } from "@base-ui/react/collapsible"
import { cn } from "cn"

function Collapsible({ ...props }: CollapsiblePrimitive.Root.Props) {
  return <CollapsiblePrimitive.Root data-slot="collapsible" {...props} />
}

function CollapsibleTrigger({ className, ...props }: CollapsiblePrimitive.Trigger.Props) {
  return (
    <CollapsiblePrimitive.Trigger
      data-slot="collapsible-trigger"
      className={cn("group", className)}
      {...props}
    />
  )
}

// Base UI measures content height for us and exposes it as the
// --collapsible-panel-height custom property, but doesn't animate `height`
// itself — a consumer that never references that variable sees no visual
// collapse at all even though the underlying open state is correct. A
// grid-template-rows transition (0fr/1fr) was tried first, but this
// environment's browser engine doesn't interpolate grid-template-rows
// between fr values at all (verified directly: the property change simply
// never takes visual effect while a transition is active on it, even well
// past the transition duration) — so `height` is used instead, which is
// reliably animatable everywhere, using Base UI's own measured value as the
// open-state target.
function CollapsibleContent({
  className,
  children,
  open,
  style,
  ...props
}: CollapsiblePrimitive.Panel.Props & { open: boolean }) {
  return (
    <CollapsiblePrimitive.Panel
      data-slot="collapsible-content"
      className={cn("overflow-hidden transition-[height] duration-200 ease-out", className)}
      style={{ height: open ? "var(--collapsible-panel-height, auto)" : "0px", ...style }}
      {...props}
    >
      {children}
    </CollapsiblePrimitive.Panel>
  )
}

export { Collapsible, CollapsibleTrigger, CollapsibleContent }
