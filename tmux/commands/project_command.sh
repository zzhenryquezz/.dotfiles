#!/bin/bash

PROJECTS_DIR="$HOME/git"
SCRIPTS_DIR="$(dirname "$0")"

selected=$(
        find "$PROJECTS_DIR" -mindepth 3 -maxdepth 3 -type d \
        | sed "s|^$PROJECTS_DIR/||" \
        | fzf --prompt="Select repository: "
)

[ -z "$selected" ] && exit 0

"$0" tmux create $PROJECTS_DIR/$selected
