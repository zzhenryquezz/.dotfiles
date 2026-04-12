#!/bin/bash

SESSION_NAME=$(basename "$PWD")

# create session detached
tmux new-session -d -s "$SESSION_NAME" -c "$PWD"

# window 1 (already created, rename it)
tmux rename-window -t "$SESSION_NAME:0" "core"

# window 2
tmux new-window -t "$SESSION_NAME" -n "module" -c "$PWD"

# window 3
tmux new-window -t "$SESSION_NAME" -n "copilot" -c "$PWD"

# window 4
tmux new-window -t "$SESSION_NAME" -n "run" -c "$PWD"

# attach
tmux attach -t "$SESSION_NAME"
