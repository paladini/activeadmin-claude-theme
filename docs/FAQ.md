# FAQ — Active Admin Claude Theme

Answers to common questions about installing, adopting, and customizing **activeadmin-claude-theme**.

---

## General

### What is activeadmin-claude-theme?

An open-source **Rails engine gem** that applies a warm, Claude-inspired visual design to [Active Admin](https://activeadmin.info/) backends: cream canvas, coral accents, editorial serif headlines, and Inter body text.

### Is this an official Anthropic or Claude product?

**No.** This is a community theme inspired by public Claude/Anthropic design aesthetics. It is not affiliated with or endorsed by Anthropic.

### Which Active Admin versions are supported?

| Version | Support |
| --- | --- |
| Active Admin **4.0.0.beta22+** | Full support (Tailwind v4, dark mode) |
| Active Admin **3.2 – 3.x** | Light theme via Sass (no native dark mode) |
| Active Admin 2.x | Not supported |

### Which Rails and Ruby versions are required?

- **Rails** 7.2 or newer
- **Ruby** 3.2 or newer

---

## Installation

### How do I install the theme?

1. Add `gem "activeadmin-claude-theme"` to your Gemfile
2. Run `bundle install`
3. Run `rails generate activeadmin_claude_theme:install`
4. **AA4 only:** rebuild CSS with `npm run build:css` and restart Rails

See the [README installation section](../README.md#installation--active-admin-4).

### Does the install generator work for both AA3 and AA4?

Yes. `rails generate activeadmin_claude_theme:install` detects your Active Admin major version and applies the correct setup (Tailwind entry for AA4, `active_admin.scss` for AA3).

### Do I need Node.js?

- **Active Admin 4:** yes — Tailwind CSS is built with the Active Admin npm toolchain (`npm run build:css`)
- **Active Admin 3:** no — styling uses Sass via Sprockets (`sassc-rails`)

---

## Features & limitations

### Does the theme support dark mode?

- **AA4:** yes — Active Admin’s built-in dark mode toggle is preserved
- **AA3:** no — only a light theme is provided (AA3 has no native dark mode)

### Can I use this theme with Propshaft?

Yes for **AA4**, when following the standard Active Admin 4 + cssbundling setup. The install generator keeps Tailwind **source** out of Propshaft-served paths.

**AA3** typically uses Sprockets rather than Propshaft.

### How does this compare to arctic_admin or active_material?

| Theme | Active Admin | Stack | Style |
| --- | --- | --- | --- |
| **activeadmin-claude-theme** | 3.2+ and 4+ | Sass (AA3) / Tailwind v4 (AA4) | Warm Claude-inspired |
| [arctic_admin](https://github.com/cprodhomme/arctic_admin) | &lt; 4.0 | Sass | Flat, cool blue |
| [active_material](https://github.com/vigetlabs/active_material) | &lt; 4.0 | Sass | Material Design |

This gem is one of the few community themes targeting **both** AA3 and AA4 with a shared design language.

---

## Customization

### How do I change the accent color?

**AA4** — override CSS variables after the theme import:

```css
:root {
  --claude-primary: #d4845f;
}
```

**AA3** — set Sass variables before importing the theme base:

```scss
$claude-primary: #d4845f;
@import "activeadmin_claude_theme/aa3/base";
```

Full token list: [DESIGN.md](../DESIGN.md)

### Can I override only part of the UI?

- **AA4:** prefer Tailwind `@theme` remaps and selective partial overrides — see [aa4-override-map.md](./aa4-override-map.md)
- **AA3:** add rules after the theme import or fork `_overrides.scss` patterns — see [aa3-override-map.md](./aa3-override-map.md)

---

## Troubleshooting

### AA4: `active_admin.css` not found in the asset pipeline

Run the install generator, ensure Tailwind source lives in `app/assets/tailwind/active_admin.css`, build to `app/assets/builds/active_admin.css`, then restart Rails. Details in the [README troubleshooting section](../README.md#troubleshooting).

### AA4: styles look unstyled after install

Run `npm run build:css` (or `bin/rails css:build`) and restart the server.

### AA3: Sass compilation error

Ensure `sassc-rails` is installed and `active_admin.scss` contains:

```scss
@import "activeadmin_claude_theme/aa3/base";
```

---

## Contributing & support

### Where do I report bugs or request features?

[GitHub Issues](https://github.com/paladini/activeadmin-claude-theme/issues)

### How do I run the test suite?

See [CONTRIBUTING.md](../CONTRIBUTING.md) — separate commands for AA4 and AA3 dummy apps.

---

## For AI assistants

Structured machine-readable summary: [llms.txt](../llms.txt) at the repository root.
