is_mod_active(){
    local mod=$1
    [[ "$mod" != *.lua ]] && mod="$mod.lua"

    local target="$HOME/.config/hypr/active/$mod"

    [[ -L "$target" ]]
}

mod_exists(){
    local mod=$1
    [[ "$mod" != *.lua ]] && mod="$mod.lua"

    local original="$HOME/.config/hypr/modifiers/$mod"

    [[ -f "$original" ]]
}

# return [error, success]
activate_mod(){
    error=""
    local mod=$1

    [[ "$mod" != *.lua ]] && mod="$mod.lua"

    if ! mod_exists "$mod"; then
        error="$mod does not exist..."
        return 1
    fi

    local original="$HOME/.config/hypr/modifiers/$mod"
    local target="$HOME/.config/hypr/active/$mod"

    if [ -L "$target" ]; then
        error="$mod already active..."
        return 1
    fi

    if [ ! -f "$original" ]; then
        error="$mod does not exist..."
        return 1
    fi

    ln -s $original $target
}

deactivate_mod(){
    error=""
    local mod=$1

    [[ "$mod" != *.lua ]] && mod="$mod.lua"

    if ! mod_exists "$mod"; then
        error="$mod does not exist..."
        return 1
    fi

    local target="$HOME/.config/hypr/active/$mod"

    if [ ! -L "$target" ]; then
        error="$mod not active..."
        return 1
    fi

    rm $target
}
