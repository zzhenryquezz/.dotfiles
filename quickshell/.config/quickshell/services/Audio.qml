import Quickshell
import QtQuick

Scope {
    property int volume: parseInt(vpoller.value)

    Poller {
        id: vpoller
        command: "wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{printf \"%d\", $2*100}'"
        interval: 1000
    }
}
