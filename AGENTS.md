# Repository Guidelines

## Project Structure & Module Organization
- `app/` houses Rails MVC code; keep domain logic in models, slim controllers, and shared helpers in `app/helpers/`.
- `config/` stores environment settings; place new tweaks in `config/environments/*.rb` or `config/initializers/`.
- `db/migrate/` tracks schema changes; generate migrations with `bin/rails generate migration`, sample data goes to `db/seeds.rb`.
- `test/` hosts Minitest suites (`test/models`, `test/controllers`, `test/system`) with fixtures under `test/fixtures/`.
- `bin/` provides version-locked wrappers for Rails, lint, and security tasks—use them instead of global gems.

## Build, Test, and Development Commands
- `bin/setup` installs gems, prepares databases, and ensures local tooling is ready.
- `bin/dev` starts the Rails server with hot reloading and any foreman-managed processes needed for interactive work.
- `bin/rails test` runs the unit and integration suites; use `bin/rails test test/models/entry_test.rb` when targeting a folder or file.
- `bin/rails test:system` drives browser-level scenarios; artifacts appear under `tmp/screenshots` when failures occur.
- `bin/rails db:prepare` applies migrations and prepares the test schema before running suites or manual QA.

## Coding Style & Naming Conventions
- `.rubocop.yml` enforces Ruby style (two-space indent, trailing comma rules, compact class defs); run `bin/rubocop` before opening a PR.
- Prefer single quotes for simple strings, `snake_case` for methods/files, `CamelCase` for classes, and `SCREAMING_SNAKE_CASE` for constants.

## Testing Guidelines
- Write Minitest cases with descriptive names such as `test_creates_entry_with_tags`; cover new behavior in unit and system suites as needed.
- Seed data through fixtures or helper factories; avoid depending on production seeds.
- Run `bin/rails test` locally and watch CI’s `system-test` job when UI flows change.

## Commit & Pull Request Guidelines
- Keep commit subjects short, present-tense, and ≤72 characters (e.g., `Add daily entry form`); add details in the body when context matters.
- Squash noise commits and confirm CI is green before requesting review.
- Pull requests should outline motivation, link issues, and attach screenshots or console snippets for UX or background job updates.

## Security & Maintenance Checks
- Run `bin/brakeman` and `bin/bundler-audit` after dependency updates to catch Ruby risks early.
- Audit JavaScript dependencies with `bin/importmap audit` when touching `config/importmap.rb`.
- Mirror the checks in `.github/workflows/ci.yml` locally so the main branch stays deployable.
