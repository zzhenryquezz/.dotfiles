import Quickshell
import QtQuick.Layouts
import QtQuick

import qs.config
import qs.modules.WorkspaceBarNumber
import qs.modules.Clock
import qs.modules.Memory
import qs.modules.Cpu
import qs.modules.Audio
import qs.modules.Network
import qs.modules.Keyboard
import qs.modules.Pomodoro
import qs.modules.Submap
import qs.modules.Player
import qs.modules.Updater
import qs.modules.Docker

PanelWindow {
    id: bar
    screen: Quickshell.screens[0]
    color: "transparent"
    implicitHeight: 40

    anchors {
        top: true
        left: true
        right: true
    }

    margins {
        top: 10
        left: 20
        right: 20
        bottom: 0
    }

    RowLayout {
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        spacing: 4

        WorkspaceBar {
            rangeStart: 0
            rangeEnd: 4
        }

        Pomodoro {}

        Player {}

        Submap {}
    }

    Clock {
        anchors.centerIn: parent
    }

    RowLayout {
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        spacing: 4

        Updater {}

        Docker {}

        Audio {}

        KeyboardLayout {}

        Network {}

        Cpu {}

        Memory {}
    }
}
