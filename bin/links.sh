#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"

echo "dotfiles dir: $ROOT_DIR"

FORCE=false

usage() {
    echo "Usage: $0 [-f|--force]"
    exit 1
}

while [[ $# -gt 0 ]]; do
    case "$1" in
        -f|--force)
            FORCE=true
            shift
            ;;
        *)
            usage
            ;;
    esac
done

# source|target
ENTRIES=(
    "$ROOT_DIR/.gitconfig|$HOME/.gitconfig"
    "$ROOT_DIR/.bash_profile|$HOME/.bash_profile"
    "$ROOT_DIR/.bashrc|$HOME/.bashrc"
    "$ROOT_DIR/.profile|$HOME/.profile"
    "$ROOT_DIR/.terraformrc|$HOME/.terraformrc"
    "$ROOT_DIR/.tmux.conf|$HOME/.tmux.conf"
    "$ROOT_DIR/.zshrc|$HOME/.zshrc"

    "$ROOT_DIR/.config/lazygit|$HOME/.config/lazygit"
    "$ROOT_DIR/.config/lsd|$HOME/.config/lsd"
    "$ROOT_DIR/.config/nvim|$HOME/.config/nvim"
    "$ROOT_DIR/.config/starship|$HOME/.config/starship"
)

for entry in "${ENTRIES[@]}"; do
    IFS='|' read -r SRC DST <<< "$entry"

    if [[ ! -e "$SRC" ]]; then
        echo "Source does not exist: $SRC"
        exit 1
    fi

    if [[ -e "$DST" || -L "$DST" ]]; then
        if ! $FORCE; then
            echo "Target already exists: $DST"
            echo "Aborting. Use --force to overwrite."
            exit 1
        fi

        rm -rf "$DST"
    fi

    mkdir -p "$(dirname "$DST")"
    ln -s "$SRC" "$DST"
    echo "Linked: $DST -> $SRC"
done

echo "Done."
