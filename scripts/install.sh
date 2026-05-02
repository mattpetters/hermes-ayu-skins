#!/usr/bin/env bash
# Install the ayu-light, ayu-mirage, and ayu-dark skins/themes into your
# Hermes profile and matching Warp custom themes into ~/.warp/themes.
# Idempotent: re-running just refreshes the YAML files.
#
# What gets installed:
#   - CLI skins   -> $HERMES_HOME/skins/             (terminal banner, prompt, status bar)
#   - Web themes  -> $HERMES_HOME/dashboard-themes/  (web UI palette + fonts)
#   - Warp themes -> $WARP_HOME/themes/              (Warp custom themes)
#
# Usage:
#   ./scripts/install.sh
#   HERMES_HOME=/path ./scripts/install.sh
#   WARP_HOME=/path ./scripts/install.sh

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
HOME_DIR="${HERMES_HOME:-$HOME/.hermes}"
WARP_HOME_DIR="${WARP_HOME:-$HOME/.warp}"
SKINS_DEST="$HOME_DIR/skins"
THEMES_DEST="$HOME_DIR/dashboard-themes"
WARP_THEMES_DEST="$WARP_HOME_DIR/themes"

mkdir -p "$SKINS_DEST" "$THEMES_DEST" "$WARP_THEMES_DEST"

copy_theme_file() {
  local src="$1"
  local dst="$2"
  local name="$3"

  if [[ -e "$dst" && "$src" -ef "$dst" ]]; then
    echo "  $name (already in place)"
    return
  fi

  cat "$src" > "$dst"
  echo "  $name"
}

VARIANTS=(ayu-light ayu-mirage ayu-dark)

echo "Installing CLI skins -> $SKINS_DEST"
for skin in "${VARIANTS[@]}"; do
  src="$ROOT/skins/$skin.yaml"
  dst="$SKINS_DEST/$skin.yaml"
  copy_theme_file "$src" "$dst" "$skin"
done

echo "Installing dashboard themes -> $THEMES_DEST"
for theme in "${VARIANTS[@]}"; do
  src="$ROOT/dashboard-themes/$theme.yaml"
  dst="$THEMES_DEST/$theme.yaml"
  copy_theme_file "$src" "$dst" "$theme"
done

echo "Installing Warp themes -> $WARP_THEMES_DEST"
for theme in "${VARIANTS[@]}"; do
  src="$ROOT/warp-themes/$theme.yaml"
  dst="$WARP_THEMES_DEST/$theme.yaml"
  copy_theme_file "$src" "$dst" "$theme"
done

cat <<'EOF'

Installed.

CLI:
  /skin ayu-light            # bright · paper canvas
  /skin ayu-mirage           # dim   · twilight slate
  /skin ayu-dark             # dark  · midnight

  Or set as default in ~/.hermes/config.yaml:
    display:
      skin: ayu-dark

Web dashboard:
  Open the theme picker in the dashboard UI and pick "Ayu Light",
  "Ayu Mirage", or "Ayu Dark".

  Or set as default in ~/.hermes/config.yaml:
    dashboard:
      theme: ayu-dark

Warp:
  Open Settings > Appearance > Themes and pick "Ayu Light",
  "Ayu Mirage", or "Ayu Dark".

  If Sync with OS is enabled:
    light mode -> Ayu Light
    dark mode  -> Ayu Dark (or Ayu Mirage for a dimmer variant)
EOF
