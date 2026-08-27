import Quickshell
import QtQuick
import QtQuick.Layouts

import qs.config
import qs.services

Chip {
    id: root
    property var updates: []
    property int lastUpdateAt: 0
    property bool updatesLoaded: false
    property color updateColor: {
        if (root.lastUpdateAt <= 0) {
            return Theme.foreground;
        }

        const ageInDays = (Date.now() / 1000 - root.lastUpdateAt) / 86400;
        return ageInDays < 7 ? Theme.success : ageInDays < 30 ? Theme.warning : Theme.danger;
    }
    property string lastUpdateText: root.lastUpdateAt > 0
        ? "Last updated " + Qt.formatDateTime(new Date(root.lastUpdateAt * 1000), "yyyy-MM-dd")
        : "Last update date unavailable"

    icon: "󰏗"
    text: root.updatesLoaded ? root.updates.length.toString() : "..."
    textColor: root.updateColor

    Poller {
        id: updateCheck
        command: "checkupdates 2>/dev/null || true"
        interval: 30 * 60 * 1000
        onValueChanged: {
            root.updates = value.length > 0 ? value.split("\n") : [];
            root.updatesLoaded = true;
        }
    }

    Poller {
        id: lastUpdateCheck
        command: "date=$(grep -i 'starting full system upgrade' /var/log/pacman.log 2>/dev/null | tail -n 1 | sed -E 's/^\\[([^]]+)\\].*/\\1/'); test -n \"$date\" && date -d \"$date\" +%s"
        interval: 30 * 60 * 1000
        onValueChanged: root.lastUpdateAt = Number(value) || 0
    }

    SidePeek {
        id: panel
        implicitWidth: 800

        Rectangle {
            anchors.fill: parent
            color: Theme.background
            border.color: Theme.border
            border.width: 2
            radius: Theme.radius

            ColumnLayout {
                id: content
                anchors.fill: parent
                anchors.margins: 16
                spacing: 10

                RowLayout {
                    Layout.fillWidth: true

                    Text {
                        Layout.fillWidth: true
                        text: "󰏗  Package updates"
                        color: Theme.foreground
                        font.family: Theme.fontFamily
                        font.pixelSize: 16
                        font.weight: Font.DemiBold
                    }

                    Rectangle {
                        implicitWidth: 32
                        implicitHeight: 32
                        color: closeArea.containsMouse ? Theme.border : "transparent"
                        radius: Theme.radius

                        Text {
                            id: closeIcon
                            anchors.centerIn: parent
                            text: "󰅖"
                            color: Theme.foreground
                            font.family: Theme.fontFamily
                            font.pixelSize: 16
                        }

                        MouseArea {
                            id: closeArea
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: panel.open = false
                        }
                    }
                }

                Text {
                    text: root.updatesLoaded
                        ? root.updates.length === 0
                            ? "Your system is up to date."
                            : root.updates.length + " update" + (root.updates.length === 1 ? "" : "s") + " available"
                        : "Checking for updates..."
                    color: root.updateColor
                    font.family: Theme.fontFamily
                    font.pixelSize: 11
                }

                Text {
                    text: root.lastUpdateText
                    color: root.updateColor
                    font.family: Theme.fontFamily
                    font.pixelSize: 11
                }

                Rectangle {
                    visible: root.updatesLoaded && root.updates.length > 0
                    Layout.fillWidth: true
                    implicitHeight: 1
                    color: Theme.border
                }

                ListView {
                    id: updateList
                    visible: root.updates.length > 0
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    clip: true
                    spacing: 8
                    model: root.updates

                    delegate: Text {
                        required property string modelData
                        width: updateList.width
                        text: modelData
                        elide: Text.ElideRight
                        color: Theme.foreground
                        font.family: Theme.fontFamily
                        font.pixelSize: 11
                    }

                    Rectangle {
                        visible: updateList.contentHeight > updateList.height
                        anchors.right: parent.right
                        y: updateList.visibleArea.yPosition * updateList.height
                        width: 3
                        height: Math.max(20, updateList.visibleArea.heightRatio * updateList.height)
                        color: Theme.secondary
                        radius: width / 2
                    }
                }
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: panel.open = !panel.open
    }
}
