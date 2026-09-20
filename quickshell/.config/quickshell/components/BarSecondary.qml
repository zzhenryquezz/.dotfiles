import Quickshell
import QtQuick.Layouts
import qs.components

import qs.modules.WorkspaceBarNumber
import qs.modules.Clock
import qs.modules.Audio
import qs.modules.Submap

PanelWindow {
    screen: Quickshell.screens[1]
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

        WorkspaceBar {
            rangeStart: 5
            rangeEnd: 8
        }

        Submap {}
    }

    Clock {
        anchors.centerIn: parent
    }

    RowLayout {
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        spacing: 4

        Audio {}
    }
}
