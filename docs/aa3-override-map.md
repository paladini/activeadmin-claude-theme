# Active Admin 3.x — Override Map (Claude Theme)

Discovered against Active Admin `3.5.x`. AA3 chrome is Arbre-generated markup with stable IDs and Sass-driven styling via `active_admin/base`.

## Already provided by AA3 (do NOT rebuild)

- **Header tabs:** `#header ul.tabs`
- **Utility nav:** `#utility_nav`
- **Sidebar filters:** `#sidebar .sidebar_section`
- **Batch actions / table tools:** `.table_tools`, `.dropdown_menu_button`

## Claude theme strategy (AA3)

1. **Sass variables** in `activeadmin_claude_theme/aa3/_variables.scss` — map Claude palette to AA3 `$primary-color`, `$body-background-color`, etc. **before** `@import "active_admin/base"`.
2. **Selector overrides** in `activeadmin_claude_theme/aa3/_overrides.scss` — warm chrome for `#header`, `#title_bar`, `#sidebar`, tables, forms, login.
3. **Single entry** — host apps import `@import "activeadmin_claude_theme/aa3/base";` in `active_admin.scss`.
4. **No view overrides** — AA3 uses different Arbre chrome; this gem does not prepend AA4 ERB partials on AA3.

## Not in scope for AA3

- **Dark mode** — AA3 has no native toggle; only light theme is provided (aligned with AA4 light palette).
- **Flowbite drawer** — AA3 mobile nav differs; no drawer hooks.
- **Tailwind `@theme`** — AA3 uses Sass/Sprockets, not Tailwind CLI.

## Override points (AA3 DOM / selectors)

| Area | Selectors |
|------|-----------|
| Layout | `body.active_admin`, `#wrapper`, `#active_admin_content` |
| Header | `#header`, `#header h1`, `#header ul.tabs > li` |
| Title bar | `#title_bar`, `#titlebar_left h2`, `.action_items` |
| Sidebar | `#sidebar`, `.sidebar_section`, `.sidebar_section > h3` |
| Index | `table.index_table`, `.pagination`, `.table_tools` |
| Show | `.panel`, `.attributes_table` |
| Forms | `form fieldset.inputs`, `form input`, `form textarea`, `form select` |
| Login | `body.active_admin.logged_out`, `#login`, `#login h2` |
| Flash | `.flash`, `.flash_notice`, `.flash_alert` |
| Tags | `.status_tag` |

## Host app install

```bash
# Prerequisites: Active Admin 3.2+ with Sprockets + sassc-rails (or compatible Sass pipeline)
rails generate active_admin:install
rails generate active_admin:assets
rails generate activeadmin_claude_theme:install
```

The install generator replaces `@import "active_admin/base"` with the Claude AA3 entry when possible.

## Asset pipeline

```
app/assets/stylesheets/active_admin.scss   # imports activeadmin_claude_theme/aa3/base
app/assets/builds/                         # not used (AA4 only)
```

Ensure Sprockets serves compiled `active_admin.css` (via `sassc-rails` or equivalent).

## Parity notes vs AA4

Visual parity is **approximate**: same Claude palette and typography intent, but AA3 markup and components differ from AA4 Tailwind/Flowbite chrome. Expect different spacing, no dark mode, and classic AA3 table/filter layout.
