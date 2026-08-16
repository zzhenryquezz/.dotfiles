modifiers=''
eval "modifiers=(${args[modifier]:-})"

if [ -z "$modifiers" ]; then
    echo "No modifiers provided. Please specify at least one modifier to activate."
    exit 1
fi

for mod in "${modifiers[@]}"; do
    if is_mod_active "$mod"; then
        hypr_deactivate_command "$mod"
    else
        hypr_activate_command "$mod"
    fi
done
