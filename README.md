# Chechelab

Chechelab is a small Rails 7.2 playground meant for practicing algorithms and
Ruby on Rails exercises. The first kata implemented here is the classic
"spin words" kata: every word with five or more letters is reversed while the
rest of the sentence stays untouched. The project exposes a JSON endpoint that
receives a sentence and returns its transformed version, plus a minimal
homepage to confirm the app is running.

## Requirements

|Dependency|Version / Notes|
|----------|---------------|
|Ruby|3.3.9 (see `.ruby-version`)|
|Bundler|2.5+ (ships with recent Rubies)|
|PostgreSQL|13+ (configurable via `DB_USER` / `DB_PASS`)|
|Node/Yarn|Not required (Importmap setup)|

## Getting started

```bash
git clone <repo-url>
cd chechelab
bundle install

# Configure your DB credentials if needed
export DB_USER=postgres
export DB_PASS=secret

# Prepare the database
bin/rails db:setup

# Run the server
bin/rails server
```

Visit [http://localhost:3000](http://localhost:3000) to see the welcome page.

## API usage

`POST /spin_words` expects a JSON or form payload with a `sentence` attribute
and responds with a JSON object containing the transformed text.

```bash
curl --request POST http://localhost:3000/spin_words \
     --header 'Content-Type: application/json' \
     --data '{"sentence":"Hey fellow warriors"}'

# => {"result":"Hey wollef sroirraw"}
```

## Running tests

Use the standard Rails test runner. For the entire suite:

```bash
bin/rails test
```

To focus on the controller specs (preferred command style in this repo):

```bash
bin/rails test test/controllers/main_controller_test.rb
```

Tests live under `test/` and rely on Minitest + Shoulda context helpers.

## Project structure highlights

|Path|Purpose|
|----|-------|
|`app/controllers/main_controller.rb`|Contains the `spin_words` endpoint wrapper.|
|`config/routes.rb`|Defines `POST /spin_words` and the root welcome page.|
|`packs/spin_words/app/services/spin_words/solver.rb`|Packified business logic for the kata.|
|`test/controllers/main_controller_test.rb`|Acceptance tests for the endpoint using the custom `should_for` helper.|
|`test/support/shoulda_for.rb`|Lightweight table-driven DSL (`should_for`, `context_for`).|

## Packs architecture

The repo includes the [`packs-rails`](https://github.com/rubyatscale/packs-rails)
gem to encourage splitting exercises by "packs" (feature modules). Autoloading
for everything under `packs/*` is configured in `packs.yml`. To add a new pack:

1. Create a directory such as `packs/new_kata` with its own `package.yml`.
2. Place implementation files under `packs/new_kata/app/...` (public APIs can
   live in `app/public`).
3. Add corresponding tests alongside the pack, e.g.
   `packs/new_kata/spec` or keep using `test/` if you prefer Minitest.

After adding files, run `bundle exec packwerk validate` (once packwerk is
installed) to keep dependencies tidy. This setup keeps each exercise isolated
while remaining inside a single Rails app.

## Environment variables

|Variable|Default|Description|
|--------|-------|-----------|
|`DB_USER`|`postgres`|Database user for all environments.|
|`DB_PASS`|empty|Database password.|
|`RAILS_MAX_THREADS`|`5`|Standard Rails thread pool size.|

## Deployment notes

- This is a standard Rails app, so any platform that supports Ruby 3.3 and
  PostgreSQL will work (Heroku, Fly.io, Render, etc.).
- Remember to set `DB_USER`/`DB_PASS` in the target environment and run
  `rails db:migrate` during deploys.
- The `/up` route (Rails default health check) is available for probes.

## Contributing

1. Fork the repository and create a feature branch.
2. Make your changes with tests.
3. Run `bin/rails test` before opening a PR.
4. Describe the motivation and include reproduction steps if you fixed a bug.

Enjoy hacking on Chechelab! If you have ideas for new kata-style endpoints,
feel free to open an issue or PR.
