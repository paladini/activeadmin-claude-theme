# Changelog

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.2.0] - 2026-07-16

### Added

- **Active Admin 3.x support** — Sass theme via `activeadmin_claude_theme/aa3/base` (Sprockets + `sassc-rails`)
- Version-aware install generator (`rails generate activeadmin_claude_theme:install`)
- AA3 dummy app, CI job (`test-aa3`), and integration tests
- [docs/aa3-override-map.md](./docs/aa3-override-map.md)
- [docs/FAQ.md](./docs/FAQ.md) and [llms.txt](./llms.txt) for discoverability (SEO / GEO)
- RubyGems metadata: `documentation_uri`, `bug_reports_uri`, `changelog_uri`

### Changed

- Gemspec now supports `activeadmin >= 3.2.0, < 5`
- README restructured with version matrix, FAQ links, and descriptive screenshot alt text
- GitHub repository description and topics updated

### Notes

- **AA4:** unchanged workflow — Tailwind v4, dark mode preserved
- **AA3:** light theme only (no native dark mode in Active Admin 3)

## [0.1.0] - 2026-07-16

### Added

- Initial release: Claude-inspired theme for **Active Admin 4** (Tailwind v4)
- Tailwind `@theme` token remaps and `--claude-*` CSS variables
- Branded header and navigation partial overrides
- Install generator for AA4 host apps

[0.2.0]: https://github.com/paladini/activeadmin-claude-theme/releases/tag/v0.2.0
[0.1.0]: https://github.com/paladini/activeadmin-claude-theme/releases/tag/v0.1.0
