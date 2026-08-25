import Quickshell.Hyprland
import QtQuick
import Quickshell.Io
import QtQuick.Layouts

import qs.config
import qs.services

Chip {
    text: keyboard.layoutDescriptionShort
    icon: ""

    Keyboard {
        id: keyboard
    }

    Process {
        id: layoutSwitch
        command: ["hyprctl", "switchxkblayout", "all", "next"]
    }

    MouseArea {
        anchors.fill: parent

        onClicked: layoutSwitch.startDetached()
    }
}
