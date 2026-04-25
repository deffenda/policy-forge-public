#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

if command -v markdownlint-cli2 >/dev/null 2>&1; then
  markdownlint-cli2 "**/*.md"
elif command -v markdownlint >/dev/null 2>&1; then
  markdownlint "**/*.md"
else
  echo "Markdown linter not found; skipping markdown lint."
  echo "Install markdownlint-cli2 or markdownlint to enable this check."
fi

if command -v lychee >/dev/null 2>&1; then
  lychee --no-progress "**/*.md"
elif command -v markdown-link-check >/dev/null 2>&1; then
  find . -name "*.md" -print0 | xargs -0 -n1 markdown-link-check
else
  echo "Link checker not found; skipping link validation."
  echo "Install lychee or markdown-link-check to enable this check."
fi

./scripts/check-no-private-paths.sh
./scripts/check-no-secrets.sh

echo "Public repository validation completed."
