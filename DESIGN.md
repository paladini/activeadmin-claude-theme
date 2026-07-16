---
version: alpha
name: activeadmin-claude-theme
description: >
  Community Active Admin 3 and 4 theme inspired by Claude/Anthropic aesthetics.
  Warm cream canvas, coral accents, editorial serif headlines. AA4 includes dark mode.
  Not affiliated with Anthropic.

colors:
  primary: "#cc785c"
  primary-active: "#a9583e"
  primary-disabled: "#e6dfd8"
  ink: "#141413"
  body: "#3d3d3a"
  body-strong: "#252523"
  muted: "#6c6a64"
  muted-soft: "#8e8b82"
  hairline: "#e6dfd8"
  hairline-soft: "#ebe6df"
  canvas: "#faf9f5"
  surface-soft: "#f5f0e8"
  surface-card: "#efe9de"
  surface-cream-strong: "#e8e0d2"
  surface-dark: "#181715"
  surface-dark-elevated: "#252320"
  surface-dark-soft: "#1f1e1b"
  on-primary: "#ffffff"
  on-dark: "#faf9f5"
  on-dark-soft: "#a09d96"
  accent-teal: "#5db8a6"
  accent-amber: "#e8a55a"
  success: "#5db872"
  warning: "#d4a017"
  error: "#c64545"

typography:
  display:
    fontFamily: "Source Serif 4, Georgia, Times New Roman, serif"
    note: "Substitute for proprietary Copernicus / Tiempos Headline"
  body:
    fontFamily: "Inter, system-ui, sans-serif"
    note: "Substitute for proprietary StyreneB / Anthropic Sans"
  mono:
    fontFamily: "JetBrains Mono, ui-monospace, monospace"

rounded:
  sm: 6px
  md: 8px
  lg: 12px
  xl: 16px

css_variables:
  prefix: "--claude-"
  implementation: app/assets/stylesheets/activeadmin_claude_theme.css

implementation_notes:
  - Remaps Tailwind gray/blue/indigo scales via @theme for AA4 chrome
  - Uses :root and .dark for semantic --claude-* tokens
  - Preserves AA4 dark-mode toggle and Flowbite drawer hooks
  - Fonts loaded from Google Fonts in host active_admin.css entry

source:
  - https://raw.githubusercontent.com/VoltAgent/awesome-design-md/main/design-md/claude/DESIGN.md
  - https://getdesign.md/
