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

    property string pomoColor: pomodoro.isRunning ? (pomodoro.isDue ? Theme.danger : Theme.success) : Theme.foreground
    property string iconColor: pomoColor

    Pomodoro {
        id: pomodoro
    }

    Timer {
        interval: 1000
        running: pomodoro.isDue
        repeat: true
        onTriggered: {
            root.iconColor = iconColor === root.pomoColor ? Theme.danger : root.pomoColor
        }
    }

    RowLayout {
        id: content
        anchors.centerIn: parent
        anchors.verticalCenter: parent.verticalCenter
        spacing: 12

        BText {
            text: ""
            color: root.iconColor
        }

        BText {
            text: pomodoro.text
            color: root.pomoColor
        }

        BText {
            visible: !pomodoro.isRunning
            color: root.pomoColor
            text: ""

            MouseArea {
                anchors.fill: parent
                onClicked: pomodoro.toggleMode()
            }
        }

        BText {
            visible: !pomodoro.isRunning
            color: root.pomoColor
            text: ""

            MouseArea {
                anchors.fill: parent
                onClicked: pomodoro.start()
            }
        }

        BText {
            visible: pomodoro.isRunning
            color: root.pomoColor
            text: ""

            MouseArea {
                anchors.fill: parent
                onClicked: pomodoro.close()
            }
        }
    }
}
