#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET="${1:-linux}"
DRY_RUN="${2:-}"

if [[ "$TARGET" != "linux" && "$TARGET" != "wsl" ]]; then
  echo "Uso: ./install.sh [linux|wsl] [--dry-run]"
  exit 1
fi

if [[ -n "$DRY_RUN" && "$DRY_RUN" != "--dry-run" ]]; then
  echo "Flag invalida: $DRY_RUN"
  echo "Uso: ./install.sh [linux|wsl] [--dry-run]"
  exit 1
fi

echo "Target: $TARGET"
if [[ -n "$DRY_RUN" ]]; then
  echo "Modo: dry-run"
fi

if [[ -f "$ROOT_DIR/packages/apt.txt" ]]; then
  echo "Instalando paquetes apt..."
  if [[ -n "$DRY_RUN" ]]; then
    sed '/^\s*#/d;/^\s*$/d' "$ROOT_DIR/packages/apt.txt" | awk '{print "  - " $0}'
  else
    sudo apt update -y
    xargs -r sudo apt install -y < <(sed '/^\s*#/d;/^\s*$/d' "$ROOT_DIR/packages/apt.txt")
  fi
fi

"$ROOT_DIR/scripts/link.sh" "$ROOT_DIR/common/home" "$HOME" "${DRY_RUN:-}"

if [[ "$TARGET" == "wsl" ]]; then
  "$ROOT_DIR/scripts/link.sh" "$ROOT_DIR/wsl/home" "$HOME" "${DRY_RUN:-}"
fi

echo "Install listo."
