pragma ComponentBehavior: Bound

import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

import qs.config
import qs.components

Rectangle {
    id: root
    property int rangeStart: 0
    property int rangeEnd: 9
    implicitWidth: content.implicitWidth
    implicitHeight: 36
    color: "transparent"

    RowLayout {
        id: content
        spacing: 2
        anchors.centerIn: parent

        Repeater {
            model: root.rangeEnd - root.rangeStart + 1

            Chip {
                id: ws
                required property int index
                property int id: rangeStart + index
                property bool active: Hyprland.workspaces.values.some(w => w.id === ws.id + 1)
                property bool focused: Hyprland.focusedWorkspace?.id === (ws.id + 1)
                property bool first: ws.id === 0
                property bool last: ws.id === (root.quantity - 1)

                text: ws.id + 1
                backgroundColor: ws.focused ? Theme.primary : Theme.background
                textColor: {
                    if (ws.focused) {
                        return Theme.background;
                    }

                    if (ws.active) {
                        return Theme.primary;
                    }

                    return Theme.foreground;
                }
                // backgroundColor: ws.focused ? Theme.primary : Theme.background

                MouseArea {
                    anchors.fill: parent
                    onClicked: Hyprland.dispatch(`hl.dsp.focus({ workspace = ${ws.id + 1} })`)
                }
            }
        }
    }
}
