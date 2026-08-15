all=(~/.config/hypr/modifiers/*)
active=(~/.config/hypr/active/*)

for modifier in "${all[@]}"; do
    name=$(basename "$modifier")

    if [[ -e ~/.config/hypr/active/$name ]]; then
        echo "[x] $name"
    else
        echo "[ ] $name"
    fi
done
