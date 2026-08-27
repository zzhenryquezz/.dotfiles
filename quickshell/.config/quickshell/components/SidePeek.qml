import Quickshell
import Quickshell.Wayland
import QtQuick

PanelWindow {
    id: root
    anchors.top: true
    anchors.bottom: true
    anchors.right: true
    screen: Quickshell.screens[0]
    color: "transparent"

    exclusionMode: ExclusionMode.Ignore

    property bool open: false
    property int transitionDuration: 250
    property int margin: 10
    property real slideOffset: root.open ? 0 : root.width

    visible: root.open || closeTimer.running
    margins.top: root.margin
    margins.bottom: root.margin
    margins.right: root.margin - root.slideOffset

    onOpenChanged: {
        if (!open) {
            closeTimer.restart();
        }
    }

    Behavior on slideOffset {
        NumberAnimation {
            duration: root.transitionDuration
            easing.type: Easing.OutCubic
        }
    }

    Timer {
        id: closeTimer
        interval: root.transitionDuration
    }
}
