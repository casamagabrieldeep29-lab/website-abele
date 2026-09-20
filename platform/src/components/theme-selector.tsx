"use client";

import { Check } from "lucide-react";
import { useTheme, type ColorTheme } from "@/components/theme-provider";

type ThemeDef = {
  id: ColorTheme;
  name: string;
  description: string;
  palette: string[];
  preview: {
    background: string;
    sidebar: string;
    card: string;
    primary: string;
    primaryForeground: string;
    text: string;
    textMuted: string;
    track: string;
  };
};

const THEME_DEFS: ThemeDef[] = [
  {
    id: "default",
    name: "Default",
    description: "The current ABELIEVER look — teal and neutral tones.",
    palette: ["#0a4141", "#0f5b5a", "#e4f1f0", "#d9a441", "#f8f9f7"],
    preview: {
      background: "#f8f9f7",
      sidebar: "#0a4141",
      card: "#ffffff",
      primary: "#0f5b5a",
      primaryForeground: "#ffffff",
      text: "#172121",
      textMuted: "#657272",
      track: "#e4f1f0",
    },
  },
  {
    id: "ocean",
    name: "Ocean",
    description: "Deep ocean blues and cool aqua tones.",
    palette: ["#001d29", "#0283a1", "#63b1c6", "#c0eeee", "#e3e9f3"],
    preview: {
      background: "#001d29",
      sidebar: "#001d29",
      card: "#052736",
      primary: "#0283a1",
      primaryForeground: "#ffffff",
      text: "#e3e9f3",
      textMuted: "#8fb4bf",
      track: "#0f3d4c",
    },
  },
  {
    id: "forest",
    name: "Forest",
    description: "Deep forest greens with moss and natural highlights.",
    palette: ["#0c1f14", "#4f7a3e", "#8fbf4d", "#4fae64", "#c9a227"],
    preview: {
      background: "#0c1f14",
      sidebar: "#0c1f14",
      card: "#142b1c",
      primary: "#4f7a3e",
      primaryForeground: "#ffffff",
      text: "#e7efd8",
      textMuted: "#93ac82",
      track: "#24402c",
    },
  },
];

function ThemeMiniPreview({ preview }: { preview: ThemeDef["preview"] }) {
  return (
    <div
      className="flex h-24 w-full overflow-hidden rounded-md border border-black/10"
      style={{ background: preview.background }}
    >
      <div className="w-6 shrink-0" style={{ background: preview.sidebar, borderRight: `1px solid ${preview.card}` }} />
      <div className="flex flex-1 flex-col gap-1.5 p-2">
        <div className="h-1.5 w-10 rounded-full" style={{ background: preview.textMuted, opacity: 0.6 }} />
        <div className="mt-1 flex-1 rounded-sm p-1.5" style={{ background: preview.card }}>
          <div className="h-1 w-14 rounded-full" style={{ background: preview.text, opacity: 0.7 }} />
          <div className="mt-1.5 h-1 w-full rounded-full" style={{ background: preview.track }}>
            <div className="h-1 w-2/3 rounded-full" style={{ background: preview.primary }} />
          </div>
          <div
            className="mt-1.5 h-2.5 w-8 rounded-sm"
            style={{ background: preview.primary, opacity: 0.95 }}
          />
        </div>
      </div>
    </div>
  );
}

export function ThemeSelector() {
  const { colorTheme, setColorTheme } = useTheme();

  return (
    <div className="grid grid-cols-1 gap-3 sm:grid-cols-2 lg:grid-cols-3">
      {THEME_DEFS.map((def) => {
        const isSelected = colorTheme === def.id;
        return (
          <button
            key={def.id}
            type="button"
            onClick={() => setColorTheme(def.id)}
            aria-pressed={isSelected}
            className={`group relative flex flex-col gap-2.5 rounded-lg border p-3 text-left transition-colors ${
              isSelected
                ? "border-primary ring-1 ring-primary"
                : "border-border hover:border-primary/50"
            }`}
          >
            {isSelected && (
              <span className="absolute right-2 top-2 flex size-5 items-center justify-center rounded-full bg-primary text-primary-foreground">
                <Check className="size-3.5" />
              </span>
            )}

            <ThemeMiniPreview preview={def.preview} />

            <div>
              <p className="text-sm font-semibold">{def.name}</p>
              <p className="mt-0.5 text-xs text-muted-foreground">{def.description}</p>
            </div>

            <div className="flex gap-1">
              {def.palette.map((color) => (
                <span
                  key={color}
                  className="size-3.5 rounded-full border border-black/10"
                  style={{ background: color }}
                />
              ))}
            </div>

            {isSelected && <span className="text-xs font-medium text-primary">Selected</span>}
          </button>
        );
      })}
    </div>
  );
}
