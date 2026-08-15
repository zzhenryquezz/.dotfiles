modifiers=''
eval "modifiers=(${args[modifier]:-})"

if [ -z "$modifiers" ]; then
    echo "No modifiers provided. Please specify at least one modifier to activate."
    exit 1
fi

for mod in "${modifiers[@]}"; do
    # add lua extension if not present
    [[ "$mod" != *.lua ]] && mod="$mod.lua"

    original="$HOME/.config/hypr/modifiers/$mod"
    target="$HOME/.config/hypr/active/${mod%.*}"


    if [ -f "$target" ]; then
        rm "$target"
        echo "$mod deactivated..."
        continue
    fi

    if [ ! -f "$original" ]; then
        echo "$mod not found in modifiers..."
        continue
    fi

    ln -s $original $target

    echo "activated: $original -> $target"

done
