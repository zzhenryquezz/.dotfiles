import Quickshell
import QtQuick

import qs.config
import qs.services
import qs.components

Chip {
    icon: ""
    textColor: connected ? Theme.success : Theme.danger

    property bool connected: poller.value === "connected"

    Poller {
        id: poller
        command: "iwctl station wlan0 show | grep 'Connected network' | awk '{if ($3) print \"connected\"; else print \"not connected\"}'"
        interval: 1000
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            Quickshell.execDetached(["kitty", "--class", "popup-xl", "-e", "impala"]);
        }
    }
}
