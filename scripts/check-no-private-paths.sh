#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

failures=0
api_key="API_KEY"
access_key="ACCESS_KEY"
token="TOKEN"
dot="."
env_word="env"
policy_host="policy-forge.com"
private_word="private"

scan_fixed() {
  local label="$1"
  local pattern="$2"
  if rg --hidden --glob '!.git/**' --fixed-strings "$pattern" . >/tmp/policy-forge-public-scan.txt; then
    echo "Found blocked pattern: $label"
    cat /tmp/policy-forge-public-scan.txt
    failures=1
  fi
}

scan_fixed "private host" "dev.${policy_host}"
scan_fixed "env file reference" "${dot}${env_word}"
scan_fixed "OpenAI credential name" "OPENAI_${api_key}"
scan_fixed "Anthropic credential name" "ANTHROPIC_${api_key}"
scan_fixed "AWS secret credential name" "AWS_SECRET_${access_key}"
scan_fixed "GitHub token name" "GITHUB_${token}"
scan_fixed "Codex session token name" "CODEX_SESSION_${token}"
scan_fixed "Claude Code token name" "CLAUDE_CODE_${token}"
scan_fixed "private repo name" "policy-forge-${private_word}"

if rg --hidden --glob '!.git/**' --glob '!scripts/check-no-private-paths.sh' -n '\b[0-9]{12}\b' . | rg -v '000000000000' >/tmp/policy-forge-public-aws-ids.txt; then
  echo "Found possible real 12-digit cloud account identifier:"
  cat /tmp/policy-forge-public-aws-ids.txt
  failures=1
fi

rm -f /tmp/policy-forge-public-scan.txt /tmp/policy-forge-public-aws-ids.txt

if [[ "$failures" -ne 0 ]]; then
  echo "Private path and sensitive value check failed."
  exit 1
fi

echo "Private path and sensitive value check passed."
