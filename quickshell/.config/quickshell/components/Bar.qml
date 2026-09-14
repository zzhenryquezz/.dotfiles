import Quickshell
import QtQuick.Layouts
import QtQuick

import qs.config
import qs.services
import qs.modules.WorkspaceBarNumber

PanelWindow {
    id: bar
    screen: Quickshell.screens[0]
    required property var modelData
    color: "transparent"
    implicitHeight: 40

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
            rangeStart: 0
            rangeEnd: 3
        }

        Pomo {
            id: pomodoro
        }

        Player {}

        Submap {}
    }

    Clock {
        anchors.centerIn: parent
        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                Quickshell.execDetached(["gtk-launch", "--class", "popup-xl", "calendar.notion.com"]);
            }
        }
    }

    RowLayout {
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        spacing: 4

        UpdateCheck {
            height: bar.implicitHeight
        }

        Docker {}

        Chip {
            Audio {
                id: audio
            }
            icon: ""
            text: audio.volume + "%"
        }

        KeyboardLayout {}

        Chip {
            icon: ""
            textColor: network.connected ? Theme.success : Theme.danger

            Network {
                id: network
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    Quickshell.execDetached(["kitty", "--class", "popup-xl", "-e", "impala"]);
                }
            }
        }

        Chip {
            icon: ""
            text: cpu.usage.toString().padStart(2, "0") + "%"
            textColor: cpu.usage > 50 ? (cpu.usage > 80 ? Theme.danger : Theme.warning) : Theme.success
            Cpu {
                id: cpu
            }
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    Quickshell.execDetached(["kitty", "--class", "popup-xl", "--title=btop", "-e", "btop"]);
                }
            }
        }

        Chip {
            icon: ""
            text: memory.usage + "%"
            textColor: memory.usage > 50 ? (memory.usage > 80 ? Theme.danger : Theme.warning) : Theme.success

            Memory {
                id: memory
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    Quickshell.execDetached(["kitty", "--class", "popup-xl", "--title=btop", "-e", "btop", "-p", "1"]);
                }
            }
        }
    }
}
