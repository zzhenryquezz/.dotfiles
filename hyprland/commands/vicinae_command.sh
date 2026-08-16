all=(~/.config/hypr/modifiers/*)
dir="$HOME/.local/share/vicinae/scripts"
cli="$DOTFILES_DIR/hyprland/hypr"

for modifier in "${all[@]}"; do
    base=$(basename "$modifier")
    name="${base%.lua}"

    activate_out="$dir/hypr_$name.sh"

    touch "$activate_out"
    chmod +x "$activate_out"

    echo '#!/usr/bin/env bash' > "$activate_out"
    echo "# @vicinae.schemaVersion 1" >> "$activate_out"
    echo "# @vicinae.title [hypr] activate $name" >> "$activate_out"
    echo "# @vicinae.mode silent" >> "$activate_out"
    echo "# @vicinae.icon $HOME/.local/share/icons/hicolor/scalable/apps/hyprland.svg" >> "$activate_out"
    echo >> "$activate_out"
    echo "exec $cli toggle $name" >> "$activate_out"

    echo "$activate_out created"

    deactivate_out="$dir/hypr_deactivate_$name.sh"

    touch "$deactivate_out"
    chmod +x "$deactivate_out"

    echo '#!/usr/bin/env bash' > "$deactivate_out"
    echo "# @vicinae.schemaVersion 1" >> "$deactivate_out"
    echo "# @vicinae.title [hypr] deactivate $name" >> "$deactivate_out"
    echo "# @vicinae.mode silent" >> "$deactivate_out"
    echo "# @vicinae.icon $HOME/.local/share/icons/hicolor/scalable/apps/hyprland.svg" >> "$deactivate_out"
    echo >> "$deactivate_out"
    echo "exec $cli deactivate $name" >> "$deactivate_out"

    echo "$deactivate_out created"

    toggle_out="$dir/hypr_toggle_$name.sh"

    touch "$toggle_out"
    chmod +x "$toggle_out"

    echo '#!/usr/bin/env bash' > "$toggle_out"
    echo "# @vicinae.schemaVersion 1" >> "$toggle_out"
    echo "# @vicinae.title [hypr] toggle $name" >> "$toggle_out"
    echo "# @vicinae.mode silent" >> "$toggle_out"
    echo "# @vicinae.icon $HOME/.local/share/icons/hicolor/scalable/apps/hyprland.svg" >> "$toggle_out"
    echo >> "$toggle_out"
    echo "exec $cli toggle $name" >> "$toggle_out"

    echo "$toggle_out created"

done
