#!/bin/bash

PROJECTS_DIR="$HOME/git"
SCRIPTS_DIR="$(dirname "$0")"

selected=$(ls -d "$PROJECTS_DIR"/*/  2>/dev/null | xargs -I{} basename {} | fzf --prompt="Select project: ")

[ -z "$selected" ] && exit 0

cd "$PROJECTS_DIR/$selected" && "$SCRIPTS_DIR/tmux-new-session.sh"
