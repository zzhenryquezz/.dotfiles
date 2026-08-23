pragma ComponentBehavior: Bound

import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

import "../config"

RowLayout {
    id: workspaces
    anchors.fill: parent
    anchors.leftMargin: 20
    anchors.rightMargin: 20
    spacing: 0
    property int quantity: 9

    Repeater {
        model: workspaces.quantity

        Rectangle {
            id: ws
            required property int index
            property bool active: Hyprland.workspaces.values.some(w => w.id === ws.index + 1)
            property bool focused: Hyprland.focusedWorkspace?.id === (ws.index + 1)
            property bool first: ws.index === 0
            property bool last: ws.index === (workspaces.quantity - 1)

            width: 28
            height: 38
            // Apply independent corner radii directly
            topLeftRadius: ws.first ? Theme.radius : 0
            bottomLeftRadius: ws.first ? Theme.radius : 0
            topRightRadius: ws.last ? Theme.radius : 0
            bottomRightRadius: ws.last ? Theme.radius : 0

            // Base background fill
            color: ws.focused ? Theme.primary : Theme.background

            // 1. TOP BORDER (Always present)
            Rectangle {
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                height: 2
                color: Theme.border
            }

            // 2. BOTTOM BORDER (Always present)
            Rectangle {
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                height: 2
                color: ws.focused || ws.active ? Theme.primary : Theme.border
            }

            // 3. FAR-LEFT BORDER (Only for the first item)
            Rectangle {
                visible: ws.first
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                width: 2
                color: Theme.border
            }

            // 4. FAR-RIGHT BORDER (Only for the last item)
            Rectangle {
                visible: ws.last
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                width: 2
                color: Theme.border
            }


            Text {
                anchors.centerIn: parent

                text: ws.index + 1
                color: ws.focused ? Theme.primaryForeground : Theme.foreground

                font {
                    pixelSize: 16
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: Hyprland.dispatch("workspace " + (ws.index + 1))
                }
            }
        }
    }

    Item {
        Layout.fillWidth: true
    }
}
