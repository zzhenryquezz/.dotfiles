import QtQuick
import Quickshell
import qs.components

Chip {
    id: root
    property string format: "dd ddd hh:mm:ss"
    property string value: Qt.formatDateTime(new Date(), format)
    property string fullDateTime: Qt.formatDateTime(new Date(), "yyyy-MM-dd hh:mm:ss")
    property date currentDate: new Date()

    text: root.value
    icon: "󰦖"

    ClockPanel {
        id: panel
        x: root.x - 20
        dateTime: root.fullDateTime
        currentDate: root.currentDate
        visible: false

        function updateVisibility() {
            if (clockHover.hovered || hovered) {
                visible = true;
                hideTimer.stop();
            } else {
                hideTimer.restart();
            }
        }

        onHoveredChanged: updateVisibility()
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            const now = new Date();
            root.value = Qt.formatDateTime(now, "dd ddd hh:mm:ss");
            root.fullDateTime = Qt.formatDateTime(now, "yyyy-MM-dd hh:mm:ss");
            root.currentDate = now;
        }
    }

    HoverHandler {
        id: clockHover
        target: root
        onHoveredChanged: panel.updateVisibility()
    }

    Timer {
        id: hideTimer
        interval: 200
        repeat: false
        onTriggered: {
            if (!clockHover.hovered && !panel.hovered)
                panel.visible = false;
        }
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            Quickshell.execDetached(["gtk-launch", "--class", "popup-xl", "calendar.notion.com"]);
        }
    }
}
