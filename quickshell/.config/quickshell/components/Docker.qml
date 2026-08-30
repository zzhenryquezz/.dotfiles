import QtQuick
import Quickshell.Io

Chip {
    icon: "󰡨"

    Process {
        id: proc
        command: ["gtk-launch", "dockhand"]
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            proc.startDetached()
        }
    }
}
