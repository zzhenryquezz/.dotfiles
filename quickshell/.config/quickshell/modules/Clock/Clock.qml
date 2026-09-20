import QtQuick
import Quickshell
import qs.components

Chip {
    id: root
    property string format: "dd ddd hh:mm:ss"
    property string value: Qt.formatDateTime(new Date(), format)

    text: root.value
    icon: "󰦖"

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            root.value = Qt.formatDateTime(new Date(), "dd ddd hh:mm:ss");
        }
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            Quickshell.execDetached(["gtk-launch", "--class", "popup-xl", "calendar.notion.com"]);
        }
    }
}
