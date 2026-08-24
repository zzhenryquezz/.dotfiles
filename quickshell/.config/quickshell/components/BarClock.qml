import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

import "../config"

Rectangle {
    id: root
    width: 200
    height: 38
    color: Theme.background
    border.color: Theme.border
    border.width: 2
    radius: Theme.radius

    property string time: Qt.formatDateTime(new Date(), "dd ddd hh:mm:ss")

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            root.time = Qt.formatDateTime(new Date(), "dd ddd hh:mm:ss")
        }
    }

    RowLayout {
        anchors.centerIn: parent
        spacing: 8
        Text {
            text: "󰦖"
            font.family: Theme.fontFamily
            font.pixelSize: 16
            color: Theme.primary
        }

        Text {
            text: root.time
            font.family: Theme.fontFamily
            font.pixelSize: 16
            color: Theme.primary
        }
    }
}
