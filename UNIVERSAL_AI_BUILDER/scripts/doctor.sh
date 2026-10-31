#!/usr/bin/env bash
set -u
fail=0
check() {
  local label="$1"; shift
  if "$@" >/dev/null 2>&1; then printf 'PASS  %s\n' "$label"
  else printf 'FAIL  %s\n' "$label"; fail=1; fi
}
check "Goose CLI available" command -v goose
if command -v goose >/dev/null 2>&1; then
  printf 'INFO  Goose version: '; goose --version 2>&1 | head -n 1
fi
check "Git available" command -v git
check "Python 3 available" command -v python3
check "Curl available" command -v curl
CFG="${XDG_CONFIG_HOME:-$HOME/.config}/goose/config.yaml"
if [[ -f "$CFG" ]]; then echo "PASS  Goose config file exists"
else echo "INFO  Goose config file not found yet; run goose configure"; fi
if [[ -n "${OPENAI_API_KEY:-}" ]]; then
  echo "INFO  OPENAI_API_KEY is set (value hidden)"
else
  echo "INFO  OPENAI_API_KEY environment variable is not set; Goose secret storage may still be configured"
fi
if [[ "$fail" -eq 0 ]]; then
  echo "RESULT: basic host checks passed; provider and MCP connectivity are not tested."
else
  echo "RESULT: one or more required host tools are missing."
fi
exit "$fail"
