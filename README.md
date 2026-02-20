# dotfiles

GNU Stow-managed dotfiles repository for home config.

## Managed packages

- `bash`: `.bashrc`, `.bash_logout`
- `shell`: `.profile`
- `tmux`: `.tmux.conf`
- `git`: `.gitconfig`
- `nvim`: `.config/nvim/init.lua`

## Prerequisites

- `stow` installed and available on `PATH`

## Usage

From this repo:

```bash
./scripts/stow.sh
```

Remove managed links:

```bash
./scripts/unstow.sh
```

Verify links:

```bash
./scripts/check.sh
```

Adopt existing files from `$HOME` into this repo, then stow:

```bash
./scripts/adopt-existing.sh
```
