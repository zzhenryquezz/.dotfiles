import Quickshell
import QtQuick

import qs.config
import qs.services
import qs.components

Chip {

    icon: ""
    text: usage.toString().padStart(2, "0") + "%"
    textColor: usage > 50 ? (usage > 80 ? Theme.danger : Theme.warning) : Theme.success

    property int usage: parseInt(poller.value)

    Poller {
        id: poller
        command: "top -bn1 | grep 'Cpu(s)' | awk '{printf \"%d\", $2+$4}'"
        interval: 3000
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            Quickshell.execDetached(["kitty", "--class", "popup-xl", "--title=btop", "-e", "btop"]);
        }
    }
}
