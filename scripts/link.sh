#!/usr/bin/env bash
set -euo pipefail

SRC_DIR="${1:?src requerido}"
DST_DIR="${2:?dst requerido}"
DRY_RUN="${3:-}"

if [[ ! -d "$SRC_DIR" ]]; then
  echo "Source no existe: $SRC_DIR"
  exit 1
fi

while IFS= read -r -d '' src; do
  rel="${src#"$SRC_DIR"/}"
  dst="$DST_DIR/$rel"
  dst_parent="$(dirname "$dst")"
  mkdir -p "$dst_parent"

  if [[ -n "$DRY_RUN" ]]; then
    echo "LINK $src -> $dst"
    continue
  fi

  if [[ -e "$dst" && ! -L "$dst" ]]; then
    mv "$dst" "$dst.bak.$(date +%Y%m%d%H%M%S)"
  fi

  ln -sfn "$src" "$dst"
  echo "ok: $dst"
done < <(find "$SRC_DIR" -type f -print0)
