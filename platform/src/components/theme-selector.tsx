"use client";

import { useLayoutEffect, useState, type FormEvent } from "react";
import { Check, Lock } from "lucide-react";
import { useTheme, type ColorTheme } from "@/components/theme-provider";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";

type ThemeDef = {
  id: ColorTheme;
  name: string;
  description: string;
  palette: string[];
  locked?: boolean;
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

// A sentimental easter egg, not real security — the PIN lives in this
// client bundle like everything else here. It just means Ocean and Forest
// ask for the PIN every time they're selected, so they feel like a little
// secret reserved for one person rather than an ordinary theme option.
const LOCKED_THEME_PIN = "04042003";
const SECRET_UNLOCK_STORAGE_KEY = "abeliever-secret-unlocked";

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
    locked: true,
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
    locked: true,
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
  const [pendingUnlock, setPendingUnlock] = useState<ColorTheme | null>(null);
  const [pin, setPin] = useState("");
  const [pinError, setPinError] = useState(false);
  const [secretRevealed, setSecretRevealed] = useState(false);

  // Locked themes stay out of this list entirely (not just PIN-gated) until
  // the sidebar logo's click sequence reveals them — checked on mount (and
  // re-checked on cross-tab storage changes) since it's per-device local
  // state, not something the server can know.
  useLayoutEffect(() => {
    const sync = () => {
      try {
        setSecretRevealed(localStorage.getItem(SECRET_UNLOCK_STORAGE_KEY) === "true");
      } catch {
        // Ignore — stays hidden this session.
      }
    };
    sync();
    window.addEventListener("storage", sync);
    return () => window.removeEventListener("storage", sync);
  }, []);

  const visibleDefs = THEME_DEFS.filter((def) => !def.locked || secretRevealed || colorTheme === def.id);

  function closePinPrompt() {
    setPendingUnlock(null);
    setPin("");
    setPinError(false);
  }

  function handleCardClick(def: ThemeDef) {
    if (def.locked) {
      setPendingUnlock(def.id);
      setPin("");
      setPinError(false);
      return;
    }
    closePinPrompt();
    setColorTheme(def.id);
  }

  function handlePinSubmit(e: FormEvent) {
    e.preventDefault();
    if (!pendingUnlock) return;
    if (pin === LOCKED_THEME_PIN) {
      setColorTheme(pendingUnlock);
      closePinPrompt();
    } else {
      setPinError(true);
      setPin("");
    }
  }

  return (
    <div className="grid grid-cols-1 gap-3 sm:grid-cols-2 lg:grid-cols-3">
      {visibleDefs.map((def) => {
        const isSelected = colorTheme === def.id;
        const isPending = pendingUnlock === def.id;
        return (
          <div
            key={def.id}
            className={`relative flex flex-col gap-2.5 rounded-lg border p-3 transition-colors ${
              isSelected ? "border-primary ring-1 ring-primary" : "border-border hover:border-primary/50"
            }`}
          >
            {isSelected && (
              <span className="absolute right-2 top-2 flex size-5 items-center justify-center rounded-full bg-primary text-primary-foreground">
                <Check className="size-3.5" />
              </span>
            )}

            <button type="button" onClick={() => handleCardClick(def)} aria-pressed={isSelected} className="flex flex-col gap-2.5 text-left">
              <ThemeMiniPreview preview={def.preview} />

              <div>
                <p className="flex items-center gap-1.5 text-sm font-semibold">
                  {def.name}
                  {def.locked && <Lock className="size-3 text-muted-foreground" />}
                </p>
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

            {isPending && (
              <form onSubmit={handlePinSubmit} className="space-y-1.5 rounded-md border border-border bg-muted/40 p-2">
                <label htmlFor={`theme-pin-${def.id}`} className="flex items-center gap-1 text-xs font-medium">
                  <Lock className="size-3" /> Enter PIN to unlock {def.name}
                </label>
                <Input
                  id={`theme-pin-${def.id}`}
                  type="password"
                  inputMode="numeric"
                  autoFocus
                  value={pin}
                  onChange={(e) => {
                    setPin(e.target.value);
                    setPinError(false);
                  }}
                  className="h-8 text-sm"
                />
                {pinError && <p className="text-xs text-destructive">Incorrect PIN.</p>}
                <div className="flex gap-2">
                  <Button type="submit" size="sm" className="h-7 px-2.5 text-xs">
                    Unlock
                  </Button>
                  <Button type="button" size="sm" variant="outline" className="h-7 px-2.5 text-xs" onClick={closePinPrompt}>
                    Cancel
                  </Button>
                </div>
              </form>
            )}
          </div>
        );
      })}
    </div>
  );
}
