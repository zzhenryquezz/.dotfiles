filename="$(realpath "$0")"
dir="$(dirname "$filename")"
root_dir="$(dirname "$dir")"

dirs=()

IFS=: read -ra dirs <<< "$TMUX_PROJECT_DIR"

if [ ${#dirs[@]} -eq 0 ]; then
    log_error "dirs is empty"
    exit 1
fi

selected=$(
    for project in "${dirs[@]}"; do
        root="${project%%=*}"
        depth="${project##*=}"
        name="$(basename "$root")"

        find -L "$root" \
            -mindepth "$depth" \
            -maxdepth "$depth" \
            -type d \
            ! -name .git |
        while read -r path; do
            relative="${path#"$root"/}"
            printf '%s\t%s\n' "$name/$relative" "$path"
        done
    done |
        fzf --with-nth=1 --prompt="select a project: " |
        cut -f2
)

[ -z "$selected" ] && exit 0

exec "$root_dir/tmux/tmux" create $PROJECTS_DIR/$selected
