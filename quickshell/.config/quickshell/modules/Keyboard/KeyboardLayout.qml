import QtQuick
import Quickshell.Io

import qs.config
import qs.services
import qs.components

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
