import Quickshell
import QtQuick

import qs.config
import qs.services
import qs.components

Chip {
    icon: ""
    text: usage + "%"
    textColor: usage > 50 ? (usage > 80 ? Theme.danger : Theme.warning) : Theme.success

    property int usage: parseInt(poller.value)

    Poller {
        id: poller
        command: "free -m | awk 'NR==2{printf \"%d\", $3*100/$2 }'"
        interval: 3000
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            Quickshell.execDetached(["kitty", "--class", "popup-xl", "--title=btop", "-e", "btop", "-p", "1"]);
        }
    }
}
