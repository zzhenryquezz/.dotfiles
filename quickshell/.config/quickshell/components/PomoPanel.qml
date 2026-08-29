import Quickshell
import QtQuick.Layouts
import QtQuick

import qs.services
import qs.config

PanelWindow {
    id: root
    anchors.top: true
    anchors.left: true
    implicitWidth: root.contentWidth + 32
    implicitHeight: content.implicitHeight + 32
    screen: Quickshell.screens[0]
    color: "transparent"

    property Pomodoro pomodoro: null
    property Item anchorItem: null
    property string placement: "bottom"
    property int gap: 1
    property real x: 0
    property real y: 0

    property bool hovered: false

    readonly property int contentWidth: Math.max(header.implicitWidth, timeText.implicitWidth, feedbackText.implicitWidth, controls.buttonWidth * 2 + controls.spacing)
    readonly property bool hasPomodoro: root.pomodoro !== null
    readonly property bool isBreak: root.hasPomodoro && root.pomodoro.identifier === "break"
    readonly property int phaseDuration: root.hasPomodoro ? (root.isBreak ? root.pomodoro.breakDuration : root.pomodoro.sessionDuration) * 60 : 0
    readonly property real progress: !root.hasPomodoro || !root.pomodoro.isRunning || root.phaseDuration <= 0 ? 0 : Math.min(1, Math.max(0, 1 - Math.max(0, root.pomodoro.remainingTime) / root.phaseDuration))
    readonly property color phaseColor: root.isBreak ? Theme.success : Theme.primary

    function updatePosition() {
        margins.left = root.x;
        margins.top = root.y;
    }

    onVisibleChanged: {
        if (visible) {
            updatePosition();
        }
    }

    HoverHandler {
        target: content
        onHoveredChanged: {
            root.hovered = hovered;
        }
    }

    Rectangle {
        id: background
        anchors.fill: parent
        color: Theme.background
        radius: Theme.radius

        border.color: Theme.border
        border.width: 1

        ColumnLayout {
            id: content
            anchors.fill: parent
            anchors.margins: 16
            spacing: 12

            RowLayout {
                id: header
                ColumnLayout {
                    spacing: 2

                    Text {
                        text: root.isBreak ? "󰅶  Break" : "󰔟  Focus"
                        color: Theme.foreground
                        font.family: Theme.fontFamily
                        font.pixelSize: 16
                        font.weight: Font.DemiBold
                    }

                    Text {
                        text: root.isBreak ? "Take a moment to recharge" : "Keep your attention on one task"
                        color: Theme.foreground
                        opacity: 0.65
                        font.family: Theme.fontFamily
                        font.pixelSize: 11
                    }
                }
            }

            Text {
                id: timeText
                Layout.alignment: Qt.AlignHCenter
                text: root.hasPomodoro ? root.pomodoro.text : "00:00"
                color: root.pomodoro && root.pomodoro.isDue ? Theme.danger : root.phaseColor
                font.family: Theme.fontFamily
                font.pixelSize: 42
                font.weight: Font.DemiBold
            }

            Rectangle {
                implicitHeight: 6
                Layout.fillWidth: true
                color: Theme.border
                radius: height / 2

                Rectangle {
                    width: parent.width * root.progress
                    height: parent.height
                    color: root.pomodoro && root.pomodoro.isDue ? Theme.danger : root.phaseColor
                    radius: height / 2
                    Behavior on width {
                        NumberAnimation {
                            duration: 200
                        }
                    }
                }
            }

            Text {
                id: feedbackText
                horizontalAlignment: Text.AlignHCenter
                text: !root.hasPomodoro ? "Timer unavailable" : root.pomodoro.isDue ? "Time is up — start the next phase when ready." : root.pomodoro.isRunning ? "Timer is running." : "Ready to start a " + (root.isBreak ? "break" : "focus session") + "."
                color: root.pomodoro && root.pomodoro.isDue ? Theme.danger : Theme.foreground
                opacity: root.pomodoro && root.pomodoro.isDue ? 1 : 0.7
                font.family: Theme.fontFamily
                font.pixelSize: 11
                wrapMode: Text.NoWrap
            }

            RowLayout {
                id: controls
                spacing: 8
                readonly property int buttonWidth: Math.max(switchText.implicitWidth, actionText.implicitWidth) + 24
                readonly property int buttonHeight: Math.max(switchText.implicitHeight, actionText.implicitHeight) + 16

                Rectangle {
                    Layout.preferredWidth: controls.buttonWidth
                    Layout.preferredHeight: controls.buttonHeight
                    color: Theme.border
                    radius: Theme.radius
                    opacity: root.hasPomodoro && !root.pomodoro.isRunning ? 1 : 0.5

                    Text {
                        id: switchText
                        anchors.centerIn: parent
                        text: "󰜉  Switch to " + (root.isBreak ? "Focus" : "Break")
                        color: Theme.foreground
                        font.family: Theme.fontFamily
                        font.pixelSize: 11
                    }

                    MouseArea {
                        anchors.fill: parent
                        enabled: root.hasPomodoro && !root.pomodoro.isRunning
                        cursorShape: Qt.PointingHandCursor
                        onClicked: root.pomodoro.toggleMode()
                    }
                }

                Rectangle {
                    Layout.preferredWidth: controls.buttonWidth
                    Layout.preferredHeight: controls.buttonHeight
                    color: root.pomodoro && root.pomodoro.isRunning ? Theme.danger : root.phaseColor
                    radius: Theme.radius
                    opacity: root.hasPomodoro ? 1 : 0.5

                    Text {
                        id: actionText
                        anchors.centerIn: parent
                        text: root.pomodoro && root.pomodoro.isRunning ? (root.pomodoro.isDue ? "󰒭  Next phase" : "󰅖  End session") : "  Start"
                        color: Theme.primaryForeground
                        font.family: Theme.fontFamily
                        font.pixelSize: 11
                        font.weight: Font.DemiBold
                    }

                    MouseArea {
                        anchors.fill: parent
                        enabled: root.hasPomodoro
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if (root.pomodoro.isRunning) {
                                root.pomodoro.close();
                            } else {
                                root.pomodoro.start();
                            }
                        }
                    }
                }
            }
        }
    }
}
