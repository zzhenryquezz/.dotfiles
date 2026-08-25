// Bar.qml
import Quickshell
import QtQuick.Layouts
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import Quickshell.Services.Mpris

import "../config"
import qs.services

PanelWindow {
    id: bar
    screen: Quickshell.screens[0]
    required property var modelData
    color: "transparent"

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


    implicitHeight: 40

    Audio {
        id: audio
    }

    Network {
        id: network
    }

    Cpu {
        id: cpu
    }

    Memory {
        id: memory
    }

    Keyboard {
        id: keyboard
    }

    readonly property var player: Mpris.players.values.find(p => p.identity === "Spotify")

    RowLayout {
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter

        BarWorkspace {}

        Pill {
            visible: bar.player !== undefined
            implicitWidth: 200
            implicitHeight: 38
            Text {
                anchors.centerIn: parent
                text: " " + bar.player.trackTitle
                width: parent.width - 20
                elide: Text.ElideRight
                font.family: Theme.fontFamily
                font.pixelSize: 16
                color: Theme.success
            }

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    if (bar.player) {
                        bar.player.togglePlaying()
                    }
                }
            }
        }
    }

    BarClock {
        anchors.centerIn: parent
    }

    RowLayout {
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        spacing: 8

        Pill {
            implicitWidth: 80
            implicitHeight: 38
            Text {
                anchors.centerIn: parent
                text: " " + audio.volume + "%"
                font.family: Theme.fontFamily
                font.pixelSize: 16
                color: Theme.foreground
            }
        }

        Pill {
            implicitWidth: keyboard.layoutDescriptionShort.length * 10 + 52
            // implicitWidth: 200
            implicitHeight: 38

            Process {
                id: layoutSwitch
                command: ["hyprctl", "switchxkblayout", "all", "next"]
            }

            Text {
                anchors.centerIn: parent
                text: " " + keyboard.layoutDescriptionShort
                font.family: Theme.fontFamily
                font.pixelSize: 16
                color: Theme.foreground
            }

            MouseArea {
                anchors.fill: parent

                onClicked: layoutSwitch.startDetached()
            }
        }

        Pill {
            implicitWidth: 38
            implicitHeight: 38
            Text {
                anchors.centerIn: parent
                text: ""
                font.family: Theme.fontFamily
                font.pixelSize: 16
                color: network.connected ? Theme.success : Theme.danger
            }
        }

        Pill {
            implicitWidth: 80
            implicitHeight: 38
            Text {
                anchors.centerIn: parent
                text: " " + cpu.usage + "%"
                font.family: Theme.fontFamily
                font.pixelSize: 16
                color: cpu.usage > 50 ? (cpu.usage > 80 ? Theme.danger : Theme.warning) : Theme.success
            }
        }

        Pill {
            implicitWidth: 80
            implicitHeight: 38
            Text {
                anchors.centerIn: parent
                text: " " + memory.usage + "%"
                font.family: Theme.fontFamily
                font.pixelSize: 16
                color: memory.usage > 50 ? (memory.usage > 80 ? Theme.danger : Theme.warning) : Theme.success
            }
        }
    }
}
