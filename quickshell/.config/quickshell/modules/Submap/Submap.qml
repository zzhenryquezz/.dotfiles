import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

import qs.config
import qs.components

RowLayout {
    id: root
    visible: root.current !== ""
    property string current: ""

    Connections {
        target: Hyprland

        function onRawEvent(event) {
            // Check if the IPC event is a submap event
            if (event.name === "submap") {
                root.current = event.data;
            }
        }
    }

    Chip {
        icon: ""
        text: root.current
        textColor: Theme.danger
    }
}
