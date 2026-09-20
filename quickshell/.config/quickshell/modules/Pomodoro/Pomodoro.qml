import Quickshell
import QtQuick.Layouts
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import Quickshell.Services.Mpris

import qs.services
import qs.config
import qs.components

BarItem {
    id: root
    implicitWidth: content.width + 32
    implicitHeight: content.height + 16

    property string blickColor: Theme.foreground
    property string pomoColor: pomodoro.isRunning ? (pomodoro.isDue ? Theme.danger : Theme.success) : Theme.foreground
    property string textColor: pomodoro.isDue ? blickColor : pomoColor

    PomodoroService {
        id: pomodoro
    }

    PomodoroPanel {
        id: panel
        pomodoro: pomodoro
        x: root.x + 20
        visible: false
        function updateVisibility() {
            if (hoverHandler.hovered || hovered) {
                visible = true;
                hideTimer.stop();
            } else {
                hideTimer.restart();
            }
        }
        onHoveredChanged: updateVisibility()
    }

    Timer {
        interval: 1000
        running: pomodoro.isDue
        repeat: true
        onTriggered: {
            root.blickColor = root.blickColor == Theme.danger ? Theme.foreground : Theme.danger;
        }
    }

    HoverHandler {
        id: hoverHandler
        target: content
        cursorShape: Qt.PointingHandCursor
        onHoveredChanged: panel.updateVisibility()
    }

    Timer {
        id: hideTimer
        interval: 200
        repeat: false

        onTriggered: {
            if (!root.hovered && !panel.hovered)
                panel.visible = false;
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

        // MouseArea {
        //     anchors.fill: parent
        //     cursorShape: Qt.PointingHandCursor
        //     onHoveredChanged: {
        //         if (this.hovered) {
        //             panel.visible = true;
        //         } else {
        //             panel.visible = false;
        //         }
        //     }
        // }
    }
}
