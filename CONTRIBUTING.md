# Contributing to homebrew-tap

Homebrew formulae and casks by Zack Wagner (`brew tap zackwag/tap`).

## Getting started

```sh
git clone https://github.com/zackwag/homebrew-tap.git
cd homebrew-tap
brew tap zackwag/tap --force-auto-update ./.
```

## Development

- `Formula/*.rb` — CLI tool formulae (Ruby, Homebrew formula DSL)
- `Casks/*.rb` — GUI app casks

Validate a formula/cask before submitting:

```sh
brew audit --strict Formula/<name>.rb
brew style Formula/<name>.rb
brew install --build-from-source Formula/<name>.rb   # sanity-check it installs
```

`brew style` also runs automatically in CI (the "Lint" workflow) on every pull request.

Each formula/cask here tracks a specific zackwag project (e.g. `brew-export.rb`, `mac-temp.rb`, `media2mqtt.rb`, `sudo-touchid.rb`, `dotbuddy.rb`) — most changes should be version bumps when the upstream project releases.

## Commit messages and pull requests

This repo uses [Conventional Commits](https://www.conventionalcommits.org/) (`feat:`, `fix:`, `docs:`, `chore:`, etc.). Pull requests are squash-merged, and the **PR title** becomes the commit on `main` — so PR titles must follow this format. This is enforced automatically by the "Conventional Commits" check.

Direct pushes to `main` are allowed but must also use a Conventional Commits-formatted commit message (validated by the same check).

## Opening a pull request

1. Fork the repo and create a branch off `main`.
2. Make your changes.
3. Open a pull request with a Conventional Commits-formatted title.
4. Wait for CI to pass — required checks must be green before merge.

## Reporting issues

Use [GitHub Issues](../../issues) for bugs and feature requests.
