#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

if ! command -v stow >/dev/null 2>&1; then
  echo "error: stow is not installed" >&2
  exit 1
fi

stow -v -R -t "$HOME" bash shell tmux git nvim
