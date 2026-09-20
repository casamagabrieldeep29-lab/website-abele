"use client";

import { useState } from "react";

const PRESETS = [10, 20, 30, 50];
const MAX_CUSTOM = 200;

export function QuestionCountPicker({ defaultValue = 20 }: { defaultValue?: number }) {
  const startsOnPreset = PRESETS.includes(defaultValue);
  const [mode, setMode] = useState<"preset" | "custom">(startsOnPreset ? "preset" : "custom");
  const [preset, setPreset] = useState(startsOnPreset ? defaultValue : PRESETS[1]);
  const [custom, setCustom] = useState(defaultValue);

  return (
    <div className="space-y-2">
      <div className="flex flex-wrap gap-2">
        {PRESETS.map((n) => (
          <button
            key={n}
            type="button"
            onClick={() => {
              setMode("preset");
              setPreset(n);
            }}
            className={`rounded-md border px-3 py-1.5 text-sm font-medium transition-colors ${
              mode === "preset" && preset === n
                ? "border-primary bg-primary/10 text-primary"
                : "border-border text-muted-foreground hover:border-primary/40"
            }`}
          >
            {n}
          </button>
        ))}
        <button
          type="button"
          onClick={() => setMode("custom")}
          className={`rounded-md border px-3 py-1.5 text-sm font-medium transition-colors ${
            mode === "custom"
              ? "border-primary bg-primary/10 text-primary"
              : "border-border text-muted-foreground hover:border-primary/40"
          }`}
        >
          Custom
        </button>
      </div>

      {mode === "custom" && (
        <input
          name="count"
          type="number"
          min={1}
          max={MAX_CUSTOM}
          value={custom}
          onChange={(e) => setCustom(Number(e.target.value))}
          className="w-full rounded-md border border-border bg-background px-3 py-2 text-sm"
        />
      )}
      {mode === "preset" && <input type="hidden" name="count" value={preset} />}
    </div>
  );
}
