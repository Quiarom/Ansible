#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
COMMON_HOME="$ROOT_DIR/common/home"

mkdir -p "$COMMON_HOME"

# Safe list: config útil, sin secretos.
declare -a FILES=(
  ".bashrc"
  ".bash_profile"
  ".profile"
  ".gitconfig"
  ".tmux.conf"
  ".npmrc"
  ".config/starship.toml"
  ".config/nvim/init.lua"
  ".config/nvim/lua"
  ".config/ghostty/config"
  ".config/alacritty/alacritty.toml"
)

for rel in "${FILES[@]}"; do
  src="$HOME/$rel"
  dst="$COMMON_HOME/$rel"
  if [[ -e "$src" ]]; then
    mkdir -p "$(dirname "$dst")"
    rm -rf "$dst"
    cp -a "$src" "$dst"
    echo "import: $rel"
  fi
done

echo "Import listo. Revisa git diff antes de commit."
