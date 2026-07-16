# Contributing to Active Admin Claude Theme

Thank you for contributing! This gem targets **Active Admin 4** (Tailwind v4 beta).

## Development setup

```bash
bundle install
cd test/dummy
npm install
npm run build:css
ruby bin/rails db:setup db:seed
ruby bin/rails server
```

Visit `http://localhost:3000/admin` — login `admin@example.com` / `password`.

## Making changes

- **CSS tokens:** edit `app/assets/stylesheets/activeadmin_claude_theme.css`
- **View overrides:** `app/views/active_admin/` — preserve Flowbite `data-*` hooks and `.dark-mode-toggle`
- **Install flow:** `lib/generators/activeadmin_claude_theme/install/install_generator.rb`
- **AA4 map:** update `docs/aa4-override-map.md` when overriding new partials

After CSS changes, rebuild in dummy:

```bash
cd test/dummy
cp ../../app/assets/stylesheets/activeadmin_claude_theme.css app/assets/tailwind/
npm run build:css
```

## Tests

```bash
cd test/dummy && ruby bin/rails db:test:prepare
cd ../..
ruby -Itest test/activeadmin_claude_theme_test.rb test/integration/theme_integration_test.rb
```

## Commit messages

Use [Conventional Commits](https://www.conventionalcommits.org/):

- `feat:` new feature
- `fix:` bug fix
- `docs:` documentation
- `test:` tests
- `chore:` maintenance

## Pull requests

1. Fork and branch from `main`
2. Add/update tests when behavior changes
3. Rebuild dummy CSS if styles changed
4. Open PR with screenshots for visual changes
