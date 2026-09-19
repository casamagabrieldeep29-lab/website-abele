import * as React from "react"

const MOBILE_BREAKPOINT = 768

export function useIsMobile() {
  // Must start false (matching what the server rendered, since `window` isn't
  // available there) — reading window.innerWidth in a lazy initializer would
  // run during the client's hydration render and mismatch the server's markup.
  // useLayoutEffect corrects it before paint so real mobile clients don't
  // flash the desktop layout.
  const [isMobile, setIsMobile] = React.useState(false)

  React.useLayoutEffect(() => {
    const mql = window.matchMedia(`(max-width: ${MOBILE_BREAKPOINT - 1}px)`)
    const onChange = () => {
      setIsMobile(window.innerWidth < MOBILE_BREAKPOINT)
    }
    mql.addEventListener("change", onChange)
    onChange()
    return () => mql.removeEventListener("change", onChange)
  }, [])

  return isMobile
}
