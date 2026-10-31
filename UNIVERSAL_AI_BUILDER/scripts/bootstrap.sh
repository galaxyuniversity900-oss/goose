#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
GOOSE_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/goose"
DEST="$GOOSE_CONFIG_DIR/universal-ai-builder"
BIN_DIR="$HOME/.local/bin"
FORCE=0
[[ "${1:-}" == "--force" ]] && FORCE=1
if ! command -v goose >/dev/null 2>&1; then
  echo "Goose CLI not found. Install from https://goose-docs.ai/docs/getting-started/installation"
  exit 2
fi
mkdir -p "$DEST/recipes" "$DEST/docs" "$BIN_DIR"
copy_file() {
  local src="$1" dst="$2"
  if [[ -e "$dst" && "$FORCE" -ne 1 ]]; then
    echo "KEEP existing: $dst (use --force to replace; backup will be created)"
    return
  fi
  if [[ -e "$dst" ]]; then cp -p "$dst" "$dst.bak.$(date +%Y%m%d%H%M%S)"; fi
  install -m 0644 "$src" "$dst"
  echo "INSTALLED: $dst"
}
for f in "$ROOT"/recipes/*.yaml; do
  [[ -f "$f" ]] && copy_file "$f" "$DEST/recipes/$(basename "$f")"
done
for f in "$ROOT"/docs/*.md; do
  [[ -f "$f" ]] && copy_file "$f" "$DEST/docs/$(basename "$f")"
done
copy_file "$ROOT/scripts/uaib" "$BIN_DIR/uaib"
chmod 0755 "$BIN_DIR/uaib"
ENV_FILE="$DEST/env.sh"
cat > "$ENV_FILE" <<EOF
export GOOSE_RECIPE_PATH="$DEST/recipes"
export GOOSE_MODE="approve"
export GOOSE_TELEMETRY_ENABLED="false"
export SECURITY_PROMPT_ENABLED="true"
EOF
chmod 600 "$ENV_FILE"
echo "Distribution files installed."
echo "Run goose configure, configure a provider, then source: . $ENV_FILE"
echo "Then run: uaib session (ensure $BIN_DIR is on PATH)"
