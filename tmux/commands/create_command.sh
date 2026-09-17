#!/bin/bash

dir=${args[dir]}
name="$dir"

# remove home directory from the name
# name=${name/#$HOME/~}
name="${name/#"$HOME"/\~}"

# replace dots with underline 
name=${name//./_}

# replace slashes with underline
# name=${name//\//_}

echo "dir $dir"
echo "session name $name"


# create session detached
tmux new-session -d -s "$name" -c "$dir"

# rename the first window to "code"
tmux rename-window -t "$name:0" "code"

# open nvim in the first window
tmux send-keys -t "$name:0" "nvim" C-m

# create a new window for ai tools
# tmux new-window -t "$name" -n "ai" -c "$DIR"

# open copilot chat in the ai window
# tmux send-keys -t "$name:1" "copilot" C-m 

# create a new window for running the code
tmux new-window -t "$name" -n "run" -c "$dir"

# select the first window
tmux select-window -t "$name:0"

# tmux attach -t "$name"

# switch clinnt is enable or tmuux is defined, then switch client, else attach session
if [ "$SWITCH_CLIENT" = "1" ] || [ -n "$TMUX" ]; then
    tmux switch-client -t "$name"
else
    tmux attach-session -t "$name"
fi
