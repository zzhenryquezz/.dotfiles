pragma ComponentBehavior: Bound

import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

import qs.config

Rectangle {
    id: root
    property int quantity: 9
    property int size: 12
    radius: height / 2
    implicitWidth: content.implicitWidth + 32
    implicitHeight: 36
    color: Theme.background

    RowLayout {
        id: content
        spacing: 8
        anchors.centerIn: parent

        Repeater {
            model: root.quantity

            Rectangle {
                id: ws
                required property int index
                property bool active: Hyprland.workspaces.values.some(w => w.id === ws.index + 1)
                property bool focused: Hyprland.focusedWorkspace?.id === (ws.index + 1)
                property bool first: ws.index === 0
                property bool last: ws.index === (root.quantity - 1)

                width: root.size
                height: root.size
                color: ws.focused ? Theme.primary : Theme.background
                radius: width / 2
                border.color: ws.active ? Theme.primary : Theme.border
                border.width: 2

                MouseArea {
                    anchors.fill: parent
                    onClicked: Hyprland.dispatch(`hl.dsp.focus({ workspace = ${ws.index + 1} })`)
                }
            }
        }
    }
}
