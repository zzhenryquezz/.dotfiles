import Quickshell
import QtQuick.Layouts
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import Quickshell.Services.Mpris

import qs.services
import qs.config

BarItem {
    id: root
    implicitWidth: content.width + 32
    implicitHeight: content.height + 16

    property string blickColor: Theme.foreground
    property string pomoColor: pomodoro.isRunning ? (pomodoro.isDue ? Theme.danger : Theme.success) : Theme.foreground
    property string textColor: pomodoro.isDue ? blickColor : pomoColor

    Pomodoro {
        id: pomodoro
    }

    PomoPanel {
        id: panel
        visible: false
        pomodoro: pomodoro
        x: root.x + 20
    }

    Timer {
        interval: 1000
        running: pomodoro.isDue
        repeat: true
        onTriggered: {
            root.blickColor = root.blickColor == Theme.danger ? Theme.foreground : Theme.danger;
        }
    }

    RowLayout {
        id: content
        anchors.centerIn: parent
        anchors.verticalCenter: parent.verticalCenter
        spacing: 12

        BText {
            text: ""
            color: root.textColor
        }

        BText {
            text: pomodoro.text
            color: root.textColor
        }

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: panel.visible = !panel.visible
        }
    }
}
