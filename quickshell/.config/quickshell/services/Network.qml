import Quickshell
import QtQuick

Scope {
    property bool connected: pconnected.value === "connected"

    Poller {
        id: pconnected
        command: "iwctl station wlan0 show | grep 'Connected network' | awk '{if ($3) print \"connected\"; else print \"not connected\"}'"
        interval: 1000
    }
}
