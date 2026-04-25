#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

ran=0

if command -v gitleaks >/dev/null 2>&1; then
  echo "Running gitleaks..."
  gitleaks detect --source . --no-git --redact
  ran=1
fi

if command -v trufflehog >/dev/null 2>&1; then
  echo "Running trufflehog..."
  trufflehog filesystem . --no-update --only-verified
  ran=1
fi

if [[ "$ran" -eq 0 ]]; then
  echo "No local secret scanner found."
  echo "Install one of the following before publishing:"
  echo "  brew install gitleaks"
  echo "  brew install trufflehog"
  echo "Repository private-value checks still run through check-no-private-paths.sh."
fi

echo "Secret scanning step completed."
