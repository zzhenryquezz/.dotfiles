generate_vicinae_scripts() {
    local bashly=""
    local cli=""
    local output=""
    local icon=""
    local title_prefix=""
    local file_prefix=""

    for arg in "$@"; do
        case "$arg" in
            bashly=*) bashly="${arg#*=}" ;;
            cli=*)    cli="${arg#*=}" ;;
            output=*) output="${arg#*=}" ;;
            icon=*)   icon="${arg#*=}" ;;
            title_prefix=*)   title_prefix="${arg#*=}" ;;
            file_prefix=*)   file_prefix="${arg#*=}" ;;
            *) echo "unknown argument: $arg" >&2; return 1 ;;
        esac
    done

    [[ -f "$bashly" ]] || {
        echo "bashly file not found: $bashly" >&2
        return 1
    }

    mkdir -p "$output" || return 1

    while IFS=$'\t' read -r name path args; do
        local file="$output/$file_prefix${path// /-}"
        local title="$title_prefix$name"

        {
            echo '#!/usr/bin/env bash'
            echo '# @vicinae.schemaVersion 1'
            echo "# @vicinae.title $title"
            echo '# @vicinae.mode fullOutput'

            [[ -n "$icon" ]] &&
                echo "# @vicinae.icon $icon"

            if [[ -n "$args" ]]; then
                local i=1

                while IFS= read -r arg; do
                    [[ -z "$arg" ]] && continue

                    echo "# @vicinae.argument$i { \"type\": \"text\", \"placeholder\": \"$arg\" }"

                    ((i++))
                done <<< "$args"
            fi

            echo
            printf 'exec %q' "$cli"

            read -ra command_parts <<< "$path"

            for part in "${command_parts[@]}"; do
                printf ' %q' "$part"
            done

            echo ' "${@}"'
        } > "$file"

        chmod +x "$file"

        echo "generated: $file"

    done < <(
        yq -r '
            def walk($path):
                .[] |
                if .commands then
                    .commands | walk($path + [.name])
                else
                    [
                        .name,
                        ($path + [.name] | join(" ")),
                        ([.args[]?.name] | join("\n"))
                    ] | @tsv
                end;

            .commands | walk([])
        ' "$bashly"
    )
}
