"use client";

import { createContext, useContext, useLayoutEffect, useState } from "react";

type Theme = "light" | "dark" | "system";
export type ColorTheme = "default" | "ocean" | "forest";

const STORAGE_KEY = "abeliever-theme";
const COLOR_THEME_STORAGE_KEY = "abeliever-color-theme";
const COLOR_THEME_CLASSES: Record<ColorTheme, string | null> = {
  default: null,
  ocean: "theme-ocean",
  forest: "theme-forest",
};

type ThemeContextValue = {
  theme: Theme;
  setTheme: (theme: Theme) => void;
  colorTheme: ColorTheme;
  setColorTheme: (colorTheme: ColorTheme) => void;
};

const ThemeContext = createContext<ThemeContextValue | null>(null);

function readStoredTheme(): Theme {
  if (typeof window === "undefined") return "system";
  try {
    const stored = localStorage.getItem(STORAGE_KEY);
    return stored === "light" || stored === "dark" ? stored : "system";
  } catch {
    return "system";
  }
}

function readStoredColorTheme(): ColorTheme {
  if (typeof window === "undefined") return "default";
  try {
    const stored = localStorage.getItem(COLOR_THEME_STORAGE_KEY);
    return stored === "ocean" || stored === "forest" ? stored : "default";
  } catch {
    return "default";
  }
}

function applyResolvedTheme(theme: Theme) {
  const resolved = theme === "system" ? (window.matchMedia("(prefers-color-scheme: dark)").matches ? "dark" : "light") : theme;
  document.documentElement.classList.toggle("dark", resolved === "dark");
}

function applyColorTheme(colorTheme: ColorTheme) {
  for (const cls of Object.values(COLOR_THEME_CLASSES)) {
    if (cls) document.documentElement.classList.remove(cls);
  }
  const cls = COLOR_THEME_CLASSES[colorTheme];
  if (cls) document.documentElement.classList.add(cls);
}

export function ThemeProvider({ children }: { children: React.ReactNode }) {
  const [theme, setThemeState] = useState<Theme>("system");
  const [colorTheme, setColorThemeState] = useState<ColorTheme>("default");

  // Must start at fixed values matching the server ("system" / "default") —
  // reading localStorage in a lazy initializer would run during the
  // client's hydration render and mismatch the server-rendered markup.
  // Corrected here, before paint — and kept in sync if changed from another
  // tab.
  useLayoutEffect(() => {
    const sync = () => {
      setThemeState(readStoredTheme());
      setColorThemeState(readStoredColorTheme());
    };
    sync();
    window.addEventListener("storage", sync);
    return () => window.removeEventListener("storage", sync);
  }, []);

  // useLayoutEffect (not useEffect) so classes are applied before the
  // browser paints — without an SSR blocking script, this is what keeps
  // the flash-of-wrong-theme minimal. Also re-applies whenever the OS-level
  // color scheme changes while set to "system".
  useLayoutEffect(() => {
    applyResolvedTheme(theme);
    if (theme !== "system") return;

    const media = window.matchMedia("(prefers-color-scheme: dark)");
    const onChange = () => applyResolvedTheme("system");
    media.addEventListener("change", onChange);
    return () => media.removeEventListener("change", onChange);
  }, [theme]);

  useLayoutEffect(() => {
    applyColorTheme(colorTheme);
  }, [colorTheme]);

  function setTheme(next: Theme) {
    setThemeState(next);
    try {
      localStorage.setItem(STORAGE_KEY, next);
    } catch {
      // Ignore — theme just won't persist this session.
    }
  }

  function setColorTheme(next: ColorTheme) {
    // Briefly enables a color transition for this one switch, rather than
    // applying it globally, which would fight scroll/hover-driven
    // transitions already used elsewhere in the app.
    const root = document.documentElement;
    root.classList.add("theme-transition");
    window.setTimeout(() => root.classList.remove("theme-transition"), 250);

    setColorThemeState(next);
    try {
      localStorage.setItem(COLOR_THEME_STORAGE_KEY, next);
    } catch {
      // Ignore — theme just won't persist this session.
    }
  }

  return (
    <ThemeContext.Provider value={{ theme, setTheme, colorTheme, setColorTheme }}>{children}</ThemeContext.Provider>
  );
}

export function useTheme() {
  const ctx = useContext(ThemeContext);
  if (!ctx) throw new Error("useTheme must be used within ThemeProvider");
  return ctx;
}
