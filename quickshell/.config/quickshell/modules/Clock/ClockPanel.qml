import Quickshell
import QtQuick
import QtQuick.Layouts

import qs.config

PanelWindow {
    id: root
    anchors.top: true
    anchors.left: true
    implicitWidth: layout.implicitWidth + 32
    implicitHeight: layout.implicitHeight + 24
    screen: Quickshell.screens[0]
    color: "transparent"

    property string dateTime: ""
    property date currentDate: new Date()
    property real x: 0
    property real y: 0
    property bool hovered: false

    function updatePosition() {
        margins.left = root.x;
        margins.top = root.y;
    }

    onVisibleChanged: {
        if (visible)
            updatePosition();
    }

    HoverHandler {
        target: content
        onHoveredChanged: root.hovered = hovered
    }

    Rectangle {
        id: content
        anchors.fill: parent
        color: Theme.background
        radius: Theme.radius
        border.color: Theme.border
        border.width: 1

        ColumnLayout {
            id: layout
            anchors.centerIn: parent
            spacing: 12

            Text {
                id: dateText
                Layout.alignment: Qt.AlignHCenter
                text: root.dateTime
                color: Theme.foreground
                font.family: Theme.fontFamily
                font.pixelSize: 14
                font.weight: Font.DemiBold
            }

            Calendar {
                Layout.alignment: Qt.AlignHCenter
                currentDate: root.currentDate
            }
        }
    }
}
