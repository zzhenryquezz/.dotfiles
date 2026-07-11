#!/bin/bash

SESSION_NAME=$(basename "$PWD")

# replace dots with underline 
SESSION_NAME=${SESSION_NAME//./_}

# create session detached
tmux new-session -d -s "$SESSION_NAME" -c "$PWD"

# rename the first window to "code"
tmux rename-window -t "$SESSION_NAME:0" "code"

# open nvim in the first window
tmux send-keys -t "$SESSION_NAME:0" "nvim" C-m

# create a new window for ai tools
# tmux new-window -t "$SESSION_NAME" -n "ai" -c "$PWD"

# open copilot chat in the ai window
# tmux send-keys -t "$SESSION_NAME:1" "copilot" C-m 

# create a new window for running the code
tmux new-window -t "$SESSION_NAME" -n "run" -c "$PWD"

# select the first window
tmux select-window -t "$SESSION_NAME:0"

# tmux attach -t "$SESSION_NAME"

if [ "$SWITCH_CLIENT" = "1" ]; then
    tmux switch-client -t "$SESSION_NAME"
else
    tmux attach-session -t "$SESSION_NAME"
fi
