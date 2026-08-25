import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

import qs.config
import qs.components

Rectangle {
    id: root
    property string textColor: Theme.foreground
    property string backgroundColor: Theme.background

    color: root.backgroundColor
    radius: height / 2

}
