# AGENTS.md

## Project overview

Homebrew tap (`zackwag/tap`) hosting formulae and casks for Zack Wagner's own CLI tools and apps. Ruby (Homebrew formula/cask DSL), no application code of its own.

## Setup

```sh
brew tap zackwag/tap --force-auto-update ./.
```

## Build / Run

N/A — this repo defines Homebrew install recipes, not an application.

## Test

```sh
brew audit --strict Formula/<name>.rb
brew style Formula/<name>.rb
brew install --build-from-source Formula/<name>.rb
```

No CI-run test suite currently exists; these checks are run manually before a PR.

## Repository structure

- `Formula/` — CLI tool formulae: `brew-export.rb`, `mac-temp.rb`, `media2mqtt.rb`, `sudo-touchid.rb`
- `Casks/` — GUI app casks: `dotbuddy.rb`

Each entry mirrors a release of the corresponding zackwag repo (version, URL, sha256) — most changes are version bumps after an upstream release, not new logic.

## Commit and PR conventions

- Commit messages and PR titles must follow [Conventional Commits](https://www.conventionalcommits.org/) (`feat:`, `fix:`, `docs:`, `chore:`, `refactor:`, `test:`, `ci:`, `build:`, `perf:`, `style:`, `revert:`), optionally with a scope, e.g. `fix(api): handle null response`.
- This repo squash-merges pull requests only; the PR title becomes the final commit message on `main`.
- A "Conventional Commits" CI check enforces this on both PR titles and direct-push commit messages.
- Branch protection on `main`: no force-pushes, no branch deletion, required status checks must pass.
