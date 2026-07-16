# ActiveAdmin 4.0.0.beta22 — Override Map (Claude Theme)

Discovered against Active Admin `4.0.0.beta22`. AA4 chrome is ERB partials styled with Tailwind utilities on `gray`/`blue`/`indigo` scales plus `dark:` variants.

## Already provided by AA4 (do NOT rebuild)

- **Dark/light toggle:** `_html_head.html.erb` FOUC script + `.dark-mode-toggle` in `_site_header.html.erb`
- **Mobile nav drawer:** Flowbite `data-drawer-target="main-menu"`
- **User menu dropdown:** `data-dropdown-toggle="user-menu"`

## Claude theme strategy

1. **Recolor via `@theme`** in `activeadmin_claude_theme.css` — remap `--color-gray-*`, `--color-blue-*`, `--color-indigo-*` to warm Claude palette.
2. **Semantic tokens** via `:root` / `.dark` as `--claude-*`.
3. **Minimal partial overrides** in this gem:
   - `active_admin/_site_header.html.erb` — brand mark, keeps AA hooks
   - `active_admin/_main_navigation.html.erb` — coral active indicator
4. **Do not fork** `@activeadmin/activeadmin/plugin.js`.

## Override points (AA gem `app/views/`)

| Area | Path |
|------|------|
| Layout | `layouts/active_admin.html.erb` |
| Chrome | `active_admin/_site_header`, `_main_navigation`, `_page_header`, `_sidebar`, `_site_footer`, `_flash_messages`, `_html_head` |
| Resource | `active_admin/resource/_index_as_table_default.html.arb`, `_form_default.html.arb`, `_show_default.html.arb` |
| Pagination | `active_admin/kaminari/_paginator.html.erb` |

## View override mechanism

Engine prepends `app/views` so same-path files win over ActiveAdmin's templates.

## CSS hooks (AA4 plugin / markup)

`.data-table`, `.filters-form`, `.paginated-collection-footer`, `.panel`, `.status-tag`, `.formtastic`, `.dark-mode-toggle`, `.scopes-count`
