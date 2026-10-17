import QtQuick

import qs.config

Item {
    id: root
    property date currentDate: new Date()
    property date displayDate: new Date(currentDate.getFullYear(), currentDate.getMonth(), 1)
    property bool hasNavigated: false
    readonly property int cellSize: 28
    readonly property int cellSpacing: 4
    readonly property int month: displayDate.getMonth()
    readonly property int year: displayDate.getFullYear()

    implicitWidth: Math.max(cellSize * 7 + cellSpacing * 6, header.implicitWidth)
    implicitHeight: header.implicitHeight + 8 + weekdayGrid.implicitHeight + 4 + dayGrid.implicitHeight

    onCurrentDateChanged: {
        if (!root.hasNavigated)
            root.displayDate = new Date(root.currentDate.getFullYear(), root.currentDate.getMonth(), 1);
    }

    function dateForIndex(index) {
        const firstDay = new Date(root.year, root.month, 1);
        return new Date(root.year, root.month, index - firstDay.getDay() + 1);
    }

    function isToday(date) {
        return date.getFullYear() === root.currentDate.getFullYear()
            && date.getMonth() === root.currentDate.getMonth()
            && date.getDate() === root.currentDate.getDate();
    }

    function navigateMonths(offset) {
        root.displayDate = new Date(root.year, root.month + offset, 1);
        root.hasNavigated = true;
    }

    function navigateYears(offset) {
        root.displayDate = new Date(root.year + offset, root.month, 1);
        root.hasNavigated = true;
    }

    Row {
        id: header
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 4

        Rectangle {
            width: 28
            height: 24
            color: yearBackArea.containsMouse ? Theme.border : "transparent"
            radius: Theme.radius

            Text {
                anchors.centerIn: parent
                text: "󰄽"
                color: Theme.foreground
                font.family: Theme.fontFamily
                font.pixelSize: 11
            }

            MouseArea {
                id: yearBackArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: root.navigateYears(-1)
            }
        }

        Rectangle {
            width: 24
            height: 24
            color: monthBackArea.containsMouse ? Theme.border : "transparent"
            radius: Theme.radius

            Text {
                anchors.centerIn: parent
                text: "󰅁"
                color: Theme.foreground
                font.family: Theme.fontFamily
                font.pixelSize: 14
            }

            MouseArea {
                id: monthBackArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: root.navigateMonths(-1)
            }
        }

        Text {
            width: 108
            height: 24
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: Qt.formatDate(root.displayDate, "MMMM yyyy")
            color: Theme.foreground
            font.family: Theme.fontFamily
            font.pixelSize: 14
            font.weight: Font.DemiBold
        }

        Rectangle {
            width: 24
            height: 24
            color: monthForwardArea.containsMouse ? Theme.border : "transparent"
            radius: Theme.radius

            Text {
                anchors.centerIn: parent
                text: "󰅂"
                color: Theme.foreground
                font.family: Theme.fontFamily
                font.pixelSize: 14
            }

            MouseArea {
                id: monthForwardArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: root.navigateMonths(1)
            }
        }

        Rectangle {
            width: 28
            height: 24
            color: yearForwardArea.containsMouse ? Theme.border : "transparent"
            radius: Theme.radius

            Text {
                anchors.centerIn: parent
                text: "󰄾"
                color: Theme.foreground
                font.family: Theme.fontFamily
                font.pixelSize: 11
            }

            MouseArea {
                id: yearForwardArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: root.navigateYears(1)
            }
        }
    }

    Grid {
        id: weekdayGrid
        anchors.top: header.bottom
        anchors.topMargin: 8
        anchors.horizontalCenter: parent.horizontalCenter
        columns: 7
        spacing: root.cellSpacing

        Repeater {
            model: ["S", "M", "T", "W", "T", "F", "S"]

            delegate: Text {
                required property string modelData

                width: root.cellSize
                height: 16
                horizontalAlignment: Text.AlignHCenter
                text: modelData
                color: Theme.foreground
                opacity: 0.6
                font.family: Theme.fontFamily
                font.pixelSize: 11
                font.weight: Font.DemiBold
            }
        }
    }

    Grid {
        id: dayGrid
        anchors.top: weekdayGrid.bottom
        anchors.topMargin: 4
        anchors.horizontalCenter: parent.horizontalCenter
        columns: 7
        spacing: root.cellSpacing

        Repeater {
            model: 42

            delegate: Rectangle {
                required property int index
                readonly property date day: root.dateForIndex(index)
                readonly property bool inCurrentMonth: day.getMonth() === root.month

                width: root.cellSize
                height: root.cellSize
                color: root.isToday(day) ? Theme.primary : "transparent"
                radius: Theme.radius

                Text {
                    anchors.centerIn: parent
                    text: parent.day.getDate()
                    color: parent.inCurrentMonth ? (root.isToday(parent.day) ? Theme.primaryForeground : Theme.foreground) : Theme.foreground
                    opacity: parent.inCurrentMonth ? 1 : 0.35
                    font.family: Theme.fontFamily
                    font.pixelSize: 12
                }
            }
        }
    }
}
