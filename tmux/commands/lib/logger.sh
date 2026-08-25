LOG_CONTEXT="${LOG_CONTEXT:-{}}"

log_add_context() {
    for arg in "$@"; do
        local key="${arg%%=*}"
        local value="${arg#*=}"

        LOG_CONTEXT=$(jq \
            --arg key "$key" \
            --arg value "$value" \
            '. + {($key): $value}' \
            <<<"$LOG_CONTEXT")
    done
}

log_remove_context() {
    for key in "$@"; do
        LOG_CONTEXT=$(jq \
            --arg key "$key" \
            'del(.[$key])' \
            <<<"$LOG_CONTEXT")
    done
}

log() {
    local timestamp
    timestamp=$(date -Iseconds)

    local level="$1"
    local message="$2"
    shift 2

    local extra="$LOG_CONTEXT"

    while (($#)); do
        local key="${1%%=*}"
        local value="${1#*=}"

        extra=$(jq \
            --arg key "$key" \
            --arg value "$value" \
            '. + {($key): $value}' \
            <<<"$extra")

        shift
    done

    line=$(jq -cn \
        --arg time "$timestamp" \
        --arg level "$level" \
        --arg message "$message" \
        --argjson extra "$extra" \
        '{
            time: $time,
            level: $level,
            message: $message
        } + $extra'
    )

    echo "$line"

    if [[ -n "$LOG_FILE" ]]; then
        echo "$line" >>"$LOG_FILE"
    fi
}

log_info() {
    log "info" "$@"
}

log_error() {
    log "error" "$@"
}

log_warn() {
    log "warn" "$@"
}
