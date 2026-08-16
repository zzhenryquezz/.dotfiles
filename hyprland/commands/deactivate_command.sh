modifiers=''
eval "modifiers=(${args[modifier]:-})"

if [ -z "$modifiers" ]; then
    echo "No modifiers provided. Please specify at least one modifier to activate."
    exit 1
fi

for mod in "${modifiers[@]}"; do

    if deactivate_mod "$mod"; then
        echo "Modifier '$mod' deactivated successfully."
    else
        echo "Failed to deactivate modifier '$mod': $error"
    fi
done
