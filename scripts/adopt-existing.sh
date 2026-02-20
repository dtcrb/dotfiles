#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
timestamp="$(date +%Y%m%d-%H%M%S)"

adopt_one() {
  local home_target="$1"
  local repo_file="$2"

  mkdir -p "$(dirname "$repo_file")"

  if [ -L "$home_target" ]; then
    local raw_link
    local current
    current="$(readlink -f "$home_target")"
    local desired
    desired="$(readlink -f "$repo_file" 2>/dev/null || true)"
    raw_link="$(readlink "$home_target" || true)"
    if [ -n "$desired" ] && [ "$current" = "$desired" ]; then
      # Normalize pre-existing absolute links so stow can own them.
      if [[ "$raw_link" = /* ]]; then
        rm -f "$home_target"
        echo "normalize: removed absolute symlink $home_target"
      else
        echo "skip: already linked $home_target"
      fi
      return 0
    fi
    mv "$home_target" "${home_target}.bak.${timestamp}"
    echo "backup symlink: $home_target -> ${home_target}.bak.${timestamp}"
  elif [ -e "$home_target" ]; then
    if [ -e "$repo_file" ]; then
      mv "$home_target" "${home_target}.bak.${timestamp}"
      echo "backup existing home file: $home_target -> ${home_target}.bak.${timestamp}"
    else
      mv "$home_target" "$repo_file"
      echo "adopted: $home_target -> $repo_file"
    fi
  else
    echo "missing in home, keeping repo version: $home_target"
  fi
}

adopt_one "$HOME/.bashrc" "$repo_root/bash/.bashrc"
adopt_one "$HOME/.bash_logout" "$repo_root/bash/.bash_logout"
adopt_one "$HOME/.profile" "$repo_root/shell/.profile"
adopt_one "$HOME/.tmux.conf" "$repo_root/tmux/.tmux.conf"
adopt_one "$HOME/.gitconfig" "$repo_root/git/.gitconfig"
adopt_one "$HOME/.config/nvim/init.lua" "$repo_root/nvim/.config/nvim/init.lua"

cd "$repo_root"
./scripts/stow.sh
