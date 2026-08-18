filename="$(realpath "$0")"
dir="$(dirname "$filename")"
root_dir="$(dirname "$dir")"

PROJECTS_DIR="$HOME/git"
SCRIPTS_DIR="$(dirname "$0")"

selected=$(
        find "$PROJECTS_DIR" -mindepth 3 -maxdepth 3 -type d \
        | sed "s|^$PROJECTS_DIR/||" \
        | fzf --prompt="Select repository: "
)

[ -z "$selected" ] && exit 0

exec "$root_dir/tmux/tmux" create $PROJECTS_DIR/$selected
