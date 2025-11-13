#!/usr/bin/env bash
set -euo pipefail

# Stage everything
git add .

# Collect staged files (to include in commit body)
files="$(git diff --cached --name-only)"

if [[ -z "${files}" ]]; then
  echo "No staged changes."
  exit 0
fi

# Base title from args or a default
base_title="${*:-update}"

# ISO timestamp + random token to vary the commit subject
ts="$(date -Iseconds)"
token="$(printf '%04d' $RANDOM)"
subject="${base_title}: ${ts} [${token}]"

# Commit with a body listing files (one per line)
git commit -m "${subject}" -m "Committed files:" -m "${files}"

# Push current branch
git push
