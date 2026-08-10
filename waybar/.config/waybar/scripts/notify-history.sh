#!/bin/bash

while true; do
    makoctl history -j | jq -r '
        .[] |
        "\u001b[1;35m󰂚  \(.app_name // "Unknown")\u001b[0m\n" +
        "\(.summary // "")\n" +
        "\(.body // "")\n"
    ' | fold -s -w "$(tput cols)"
    read -rsn1 key

    case "$key" in
        q)
            exit 0
            ;;
    esac
done
