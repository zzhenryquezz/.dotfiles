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
        command: "iwctl station list | grep wlan | awk '{print $3}'"
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
