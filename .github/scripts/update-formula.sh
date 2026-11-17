#!/usr/bin/env bash
# Bumps FILES to VERSION/SHA256 on a branch, opens a PR, and squash-merges it
# once this tap's checks pass. Run from a checkout of this repo by the
# update-formula reusable workflow.
#
# Env: FILES (space-separated Formula/*.rb or Casks/*.rb paths), VERSION,
# SHA256, GH_TOKEN (contents + pull-requests write on this repo).
set -euo pipefail

repo=zackwag/homebrew-tap
# Checks this repo's PRs must pass before an automated merge. Only
# "Conventional Commits" is required by branch protection, so without waiting
# for Lint by name a merge could land before brew style has even started.
expected_checks=("Conventional Commits" "Lint")

: "${FILES:?}" "${VERSION:?}" "${SHA256:?}"
read -ra files <<<"$FILES"
if [ "${#files[@]}" -eq 0 ]; then
  echo "::error::FILES is empty" >&2
  exit 1
fi
for file in "${files[@]}"; do
  case "$file" in
    Formula/*.rb | Casks/*.rb) ;;
    *)
      echo "::error::$file isn't a Formula/*.rb or Casks/*.rb path" >&2
      exit 1
      ;;
  esac
  if [ ! -f "$file" ]; then
    echo "::error::$file doesn't exist in $repo" >&2
    exit 1
  fi
done

for file in "${files[@]}"; do
  python3 "$(dirname "$0")/bump_formula.py" "$file" "$VERSION" "$SHA256"
done
git --no-pager diff

if git diff --quiet; then
  echo "${files[*]} already at $VERSION"
  exit 0
fi
if [ "${DRY_RUN:-0}" = 1 ]; then
  exit 0
fi

name=$(basename "${files[0]}" .rb)
branch="update-$name-$VERSION"
title="chore($name): update to $VERSION"

git config user.name "github-actions[bot]"
git config user.email "41898282+github-actions[bot]@users.noreply.github.com"
git switch --quiet -c "$branch"
git commit --quiet -am "$title"
# Forced, so a re-run replaces the branch a failed run left behind.
git push --quiet --force origin "$branch"

pr=$(gh pr list --repo "$repo" --head "$branch" --json number -q '.[0].number')
if [ -z "$pr" ]; then
  gh pr create --repo "$repo" --base main --head "$branch" --title "$title" \
    --body "Automated update from a ${GITHUB_REPOSITORY:-$name} release."
  pr=$(gh pr list --repo "$repo" --head "$branch" --json number -q '.[0].number')
fi

for _ in $(seq 1 40); do
  reported=$(gh pr view "$pr" --repo "$repo" --json statusCheckRollup \
    -q '[.statusCheckRollup[] | (.name // .context)]')
  missing=0
  for check in "${expected_checks[@]}"; do
    jq -e --arg c "$check" 'index($c) != null' <<<"$reported" >/dev/null || missing=1
  done
  if [ "$missing" = 0 ]; then
    break
  fi
  sleep 15
done
if [ "$missing" != 0 ]; then
  echo "::error::Expected checks (${expected_checks[*]}) never reported on #$pr; leaving it open." >&2
  exit 1
fi

if ! gh pr checks "$pr" --repo "$repo" --watch --interval 15; then
  echo "::error::Checks failed on #$pr; leaving it open for review." >&2
  exit 1
fi

gh pr merge "$pr" --repo "$repo" --squash --delete-branch
