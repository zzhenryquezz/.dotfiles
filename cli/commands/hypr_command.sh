filename="$(realpath "$0")"
dir="$(dirname "$filename")"
root_dir="$(dirname "$dir")"

exec "$root_dir/hyprland/hypr" "${other_args[@]}"

