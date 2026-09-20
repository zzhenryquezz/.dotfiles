import Quickshell
import QtQuick

import qs.config
import qs.services
import qs.components

Chip {
    icon: ""
    text: volume + "%"
    property int volume: parseInt(poller.value)

    Poller {
        id: poller
        command: "wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{printf \"%d\", $2*100}'"
        interval: 1000
    }
}
