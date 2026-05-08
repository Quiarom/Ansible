#!/usr/bin/env bash
set -euo pipefail

echo "== checks =="
echo "user: $(whoami)"
echo "shell: $SHELL"
echo "home: $HOME"

check_cmd() {
  local cmd="$1"
  if command -v "$cmd" >/dev/null 2>&1; then
    echo "[ok] $cmd -> $(command -v "$cmd")"
  else
    echo "[missing] $cmd"
  fi
}

for c in git curl gh rg fd jq bat tmux zsh nvim; do
  check_cmd "$c"
done

for f in "$HOME/.bashrc" "$HOME/.gitconfig"; do
  if [[ -L "$f" ]]; then
    echo "[ok] symlink $f -> $(readlink -f "$f")"
  elif [[ -f "$f" ]]; then
    echo "[warn] file normal $f (no symlink)"
  else
    echo "[missing] $f"
  fi
done

if grep -qi microsoft /proc/version 2>/dev/null; then
  echo "[ok] WSL detectado"
else
  echo "[info] No WSL detectado"
fi
