modifiers=''
eval "modifiers=(${args[modifier]:-})"

if [ -z "$modifiers" ]; then
    echo "No modifiers provided. Please specify at least one modifier to activate."
    exit 1
fi

for mod in "${modifiers[@]}"; do

    if is_mod_active "$mod"; then
        echo "Modifier '$mod' is already active."
        continue
    fi

    if activate_mod "$mod"; then
        echo "Modifier '$mod' activated successfully."
    else
        echo "Failed to activate modifier '$mod': $error"
    fi

done
