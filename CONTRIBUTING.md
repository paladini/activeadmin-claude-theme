# Contributing to Active Admin Claude Theme

Thank you for contributing! This gem targets **Active Admin 3.2+** (Sass) and **Active Admin 4** (Tailwind v4).

## Development setup

### Active Admin 4

```bash
bundle install
cd test/dummy
npm install
npm run build:css
ruby bin/rails db:setup db:seed
ruby bin/rails server
```

Visit `http://localhost:3000/admin` — login `admin@example.com` / `password`.

### Active Admin 3

```bash
BUNDLE_GEMFILE=gemfiles/activeadmin_3.gemfile bundle install
cd test/dummy_aa3
bundle exec rails db:setup db:seed
bundle exec rails server
```

## Making changes

- **AA4 CSS tokens:** `app/assets/stylesheets/activeadmin_claude_theme.css`
- **AA3 Sass theme:** `app/assets/stylesheets/activeadmin_claude_theme/aa3/`
- **AA4 view overrides:** `app/views/active_admin/` — preserve Flowbite `data-*` hooks and `.dark-mode-toggle`
- **Install flow:** `lib/generators/activeadmin_claude_theme/install/install_generator.rb`
- **Version gating:** `lib/activeadmin_claude_theme/version_support.rb`
- **Override maps:** `docs/aa4-override-map.md`, `docs/aa3-override-map.md`

After AA4 CSS changes, rebuild in dummy:

```bash
cd test/dummy
cp ../../app/assets/stylesheets/activeadmin_claude_theme.css app/assets/tailwind/
npm run build:css
```

## Tests

```bash
# AA4
cd test/dummy && ruby bin/rails db:test:prepare
cd ../..
ruby -Itest test/activeadmin_claude_theme_test.rb test/integration/theme_integration_test.rb

# AA3
BUNDLE_GEMFILE=gemfiles/activeadmin_3.gemfile bundle install
cd test/dummy_aa3 && bundle exec rails db:test:prepare
cd ../..
DUMMY_PATH=dummy_aa3 BUNDLE_GEMFILE=gemfiles/activeadmin_3.gemfile \
  ruby -Itest test/activeadmin_claude_theme_test.rb test/integration/aa3_theme_integration_test.rb
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
3. Rebuild dummy CSS if AA4 styles changed
4. Run both AA3 and AA4 test suites when touching shared code
5. Open PR with screenshots for visual changes

## Releasing

Maintainers only. Current published version: see [CHANGELOG.md](./CHANGELOG.md).

1. Bump `lib/activeadmin_claude_theme/version.rb` (semver)
2. Update `CHANGELOG.md`
3. Commit, tag (`vX.Y.Z`), push tag
4. `gem build activeadmin-claude-theme.gemspec`
5. `gem push activeadmin-claude-theme-X.Y.Z.gem` (RubyGems MFA required)
6. Publish GitHub Release from the tag with notes from the changelog
