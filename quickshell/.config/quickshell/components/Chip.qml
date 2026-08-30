import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

import qs.config
import qs.components

Rectangle {
    id: root
    property string text: ""
    property string icon: ""
    property int fontSize: 16
    property string textColor: Theme.foreground
    property string backgroundColor: Theme.background
    property int maxLength: 20

    color: root.backgroundColor
    radius: height / 2
    implicitWidth: content.implicitWidth + 32
    implicitHeight: content.implicitHeight + 16

    RowLayout {
        id: content
        anchors.fill: parent
        anchors.leftMargin: 16
        anchors.rightMargin: 16
        spacing: 8

        Text {
            visible: root.icon.length > 0
            text: root.icon
            font.pixelSize: root.fontSize
            color: root.textColor
        }

        Text {
            visible: root.text.length > 0
            text: root.text
            Layout.preferredWidth: Math.min(root.maxLength * root.fontSize, root.text.length * root.fontSize * 0.6)
            elide: Text.ElideRight
            font.family: Theme.fontFamily
            font.pixelSize: root.fontSize
            color: root.textColor
        }
    }
}
