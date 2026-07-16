# Active Admin Claude Theme

[![Gem Version](https://badge.fury.io/rb/activeadmin-claude-theme.svg)](https://badge.fury.io/rb/activeadmin-claude-theme)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![CI](https://github.com/paladini/activeadmin-claude-theme/actions/workflows/ci.yml/badge.svg)](https://github.com/paladini/activeadmin-claude-theme/actions/workflows/ci.yml)

A warm, editorial **Active Admin 4** theme inspired by Claude/Anthropic aesthetics — cream canvas, coral accents, serif headlines, native dark mode, and mobile-ready chrome.

> **Community theme.** Not affiliated with or endorsed by Anthropic.

Requires **Active Admin `4.0.0.beta22+`** (Tailwind CSS v4).

---

## AI & Agent-Readable Summary

- **What is it?** A Rails Engine gem that themes Active Admin 4 via Tailwind v4 `@theme` token remaps, CSS variables, and minimal view overrides.
- **Stack:** Active Admin 4 beta, Tailwind v4 CLI, cssbundling-rails, importmap-rails, Rails 7.2+ / 8.x.
- **Design source:** [DESIGN.md](./DESIGN.md) (adapted from [getdesign.md / Claude DESIGN.md](https://raw.githubusercontent.com/VoltAgent/awesome-design-md/main/design-md/claude/DESIGN.md)).
- **Install:** Gemfile → `rails g activeadmin_claude_theme:install` → rebuild CSS.
- **Keywords:** `active admin theme`, `activeadmin 4`, `tailwind admin`, `claude theme`, `rails admin dark mode`.

---

## Features

- Warm Claude-inspired palette (`#faf9f5` canvas, `#cc785c` coral accent)
- Tailwind v4 `@theme` remaps for AA4's gray/blue/indigo chrome
- Semantic `--claude-*` CSS variables (light + `.dark`)
- Branded header + navigation active indicator
- Preserves AA4 dark-mode toggle, mobile drawer, and Flowbite hooks
- Install generator for host apps

---

## Screenshots

| Login | Dashboard |
| --- | --- |
| ![Login](docs/images/login.png) | ![Dashboard](docs/images/dashboard.png) |

| Admin Users | Dark Mode |
| --- | --- |
| ![Admin Users](docs/images/admin_users.png) | ![Dark Mode](docs/images/dashboard_dark.png) |

---

## Installation

### 1. Prerequisites

Your Rails app must already use **Active Admin 4** with Tailwind v4 assets:

```bash
# Gemfile
gem "activeadmin", "4.0.0.beta22"
gem "cssbundling-rails"
gem "importmap-rails"

bundle install
rails generate active_admin:install
rails generate active_admin:assets
npm install @activeadmin/activeadmin@4.0.0-beta22
```

See [Active Admin UPGRADING.md](https://github.com/activeadmin/activeadmin/blob/master/UPGRADING.md) for full AA4 setup.

### 2. Add the theme gem

```ruby
# Gemfile
gem "activeadmin-claude-theme"
```

```bash
bundle install
rails generate activeadmin_claude_theme:install
```

### 3. Load fonts + rebuild CSS

Add Google Fonts to your host `app/assets/stylesheets/active_admin.css` **before** `@import "tailwindcss";`:

```css
@import url("https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=JetBrains+Mono:wght@400;500&family=Source+Serif+4:opsz,wght@8..60,400;8..60,600&display=swap");
@import "tailwindcss";
@import "../tailwind/activeadmin_claude_theme.css";
```

Then rebuild:

```bash
npm run build:css
# or: bin/rails css:build
```

---

## Customization

Override semantic tokens in your host CSS after the theme import:

```css
:root {
  --claude-primary: #d4845f;
  --claude-canvas: #fff8f0;
}

.dark {
  --claude-canvas: #121110;
}
```

| Token | Default (light) | Role |
| --- | --- | --- |
| `--claude-primary` | `#cc785c` | Accent / CTA |
| `--claude-canvas` | `#faf9f5` | Page background |
| `--claude-ink` | `#141413` | Headings |
| `--claude-body` | `#3d3d3a` | Body text |
| `--claude-hairline` | `#e6dfd8` | Borders |
| `--claude-surface-card` | `#efe9de` | Panels |

Full token list: [DESIGN.md](./DESIGN.md)

---

## Development

```bash
git clone https://github.com/paladini/activeadmin-claude-theme.git
cd activeadmin-claude-theme
bundle install

cd test/dummy
npm install
npm run build:css
ruby bin/rails db:setup db:seed
ruby bin/rails server
```

Login: `admin@example.com` / `password`

Run tests from gem root:

```bash
cd test/dummy && ruby bin/rails db:test:prepare
cd ../..
ruby -Itest test/activeadmin_claude_theme_test.rb test/integration/theme_integration_test.rb
```

See [CONTRIBUTING.md](./CONTRIBUTING.md).

---

## License

MIT — see [LICENSE](./LICENSE).
