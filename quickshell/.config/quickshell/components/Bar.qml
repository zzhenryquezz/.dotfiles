import Quickshell
import QtQuick.Layouts
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import Quickshell.Services.Mpris

import "../config"
import qs.services

PanelWindow {
    id: bar
    screen: Quickshell.screens[0]
    required property var modelData
    color: "transparent"

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

    implicitHeight: 40

    Audio {
        id: audio
    }

    Network {
        id: network
    }

    Cpu {
        id: cpu
    }

    Memory {
        id: memory
    }

    RowLayout {
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        spacing: 4

        Workspace {
            height: bar.implicitHeight
        }

        Player {
            height: bar.implicitHeight
        }

        Submap {}

        Pomo {
            id: pomodoro
        }
    }

    Clock {
        anchors.centerIn: parent
    }

    RowLayout {
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        spacing: 4

        UpdateCheck {
            height: bar.implicitHeight
        }

        Docker {}

        Chip {
            icon: ""
            text: audio.volume + "%"
        }

        KeyboardLayout {}

        Chip {
            icon: ""
            textColor: network.connected ? Theme.success : Theme.danger
        }

        Chip {
            icon: ""
            text: cpu.usage.toString().padStart(2, "0") + "%"
            textColor: cpu.usage > 50 ? (cpu.usage > 80 ? Theme.danger : Theme.warning) : Theme.success
        }

        Chip {
            icon: ""
            text: memory.usage + "%"
            textColor: memory.usage > 50 ? (memory.usage > 80 ? Theme.danger : Theme.warning) : Theme.success
        }
    }
}
