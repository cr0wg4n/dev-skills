#!/usr/bin/env bash
# Copies each guideline from docs/guidelines/ into every skill that bundles it,
# so installed skills can read their guidelines offline and without a network fetch.
#
# Usage:
#   scripts/sync-guidelines.sh           # write the bundled copies
#   scripts/sync-guidelines.sh --check   # exit 1 if any bundled copy is stale
#
# Edit files in docs/guidelines/ only. The copies under skills/*/references/
# are generated and must not be edited by hand.

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
GUIDELINES_DIR="$ROOT/docs/guidelines"

# guideline file -> skills that bundle it (space-separated)
declare -A TARGETS=(
  ["vue-code-guidelines.md"]="vue-builder vue-code-review"
  ["typescript-code-guidelines.md"]="ts-builder ts-code-review"
  ["web-performance-guidelines.md"]="web-performance-review"
)

CHECK=0
if [[ "${1:-}" == "--check" ]]; then
  CHECK=1
elif [[ $# -gt 0 ]]; then
  echo "Unknown argument: $1" >&2
  echo "Usage: $0 [--check]" >&2
  exit 2
fi

STALE=0
TMP="$(mktemp)"
trap 'rm -f "$TMP"' EXIT

for file in "${!TARGETS[@]}"; do
  source_path="$GUIDELINES_DIR/$file"
  if [[ ! -f "$source_path" ]]; then
    echo "Missing source guideline: docs/guidelines/$file" >&2
    exit 1
  fi

  for skill in ${TARGETS[$file]}; do
    dest_dir="$ROOT/skills/$skill/references"
    dest="$dest_dir/$file"

    {
      echo "<!-- Generated from docs/guidelines/$file by scripts/sync-guidelines.sh. Do not edit. -->"
      echo
      cat "$source_path"
    } > "$TMP"

    if (( CHECK )); then
      if [[ ! -f "$dest" ]] || ! cmp -s "$TMP" "$dest"; then
        echo "STALE: skills/$skill/references/$file (run scripts/sync-guidelines.sh)" >&2
        STALE=1
      fi
    else
      mkdir -p "$dest_dir"
      cp "$TMP" "$dest"
      echo "Synced: skills/$skill/references/$file"
    fi
  done
done

if (( CHECK )); then
  if (( STALE )); then
    exit 1
  fi
  echo "All bundled guideline copies are up to date."
fi
