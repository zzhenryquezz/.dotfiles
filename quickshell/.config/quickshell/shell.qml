import Quickshell
import QtQuick.Layouts
import qs.components

Scope {
    Bar {}
    PanelWindow {
        id: bar
        screen: Quickshell.screens[1]
        required property var modelData
        color: "transparent"
        implicitHeight: 38
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

            Workspace {
                height: bar.implicitHeight
            }

            Submap {}
        }

        Clock {
            anchors.centerIn: parent
        }
    }
}
