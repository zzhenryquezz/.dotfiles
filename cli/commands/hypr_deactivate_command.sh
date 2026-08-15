modifiers=''
eval "modifiers=(${args[modifier]:-})"

if [ -z "$modifiers" ]; then
    echo "No modifiers provided. Please specify at least one modifier to activate."
    exit 1
fi

for mod in "${modifiers[@]}"; do
    # add lua extension if not present
    [[ "$mod" != *.lua ]] && mod="$mod.lua"
    target="$HOME/.config/hypr/active/${mod%.*}.lua"


    if [ ! -f "$target" ]; then
        echo "$mod not active..."
        continue
    fi

    rm "$target"

    echo "deactivated: $original -> $target"
done
