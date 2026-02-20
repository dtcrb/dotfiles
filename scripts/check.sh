#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

check_link() {
  local target="$1"
  local source="$2"

  if [ ! -L "$target" ]; then
    echo "FAIL: $target is not a symlink"
    return 1
  fi

  local resolved_target
  local resolved_source
  resolved_target="$(readlink -f "$target")"
  resolved_source="$(readlink -f "$source")"

  if [ "$resolved_target" != "$resolved_source" ]; then
    echo "FAIL: $target -> $resolved_target (expected $resolved_source)"
    return 1
  fi

  echo "OK: $target"
  return 0
}

failures=0
check_link "$HOME/.bashrc" "$repo_root/bash/.bashrc" || failures=$((failures + 1))
check_link "$HOME/.bash_logout" "$repo_root/bash/.bash_logout" || failures=$((failures + 1))
check_link "$HOME/.profile" "$repo_root/shell/.profile" || failures=$((failures + 1))
check_link "$HOME/.tmux.conf" "$repo_root/tmux/.tmux.conf" || failures=$((failures + 1))
check_link "$HOME/.gitconfig" "$repo_root/git/.gitconfig" || failures=$((failures + 1))
check_link "$HOME/.config/nvim/init.lua" "$repo_root/nvim/.config/nvim/init.lua" || failures=$((failures + 1))

if [ "$failures" -ne 0 ]; then
  echo "check failed: $failures issue(s) found"
  exit 1
fi

echo "all checks passed"
