// Bar.qml
import Quickshell
import QtQuick.Layouts
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import Quickshell.Services.Mpris

import "../config"

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

    Poller {
        id: volume
        command: "wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{printf \"%d\", $2*100}'"
        interval: 1000
    }

    Poller {
        id: network
        command: "iwctl station wlan0 show | grep 'Connected network' | awk '{if ($3) print \"connected\"; else print \"not connected\"}'"
        interval: 1000
    }

    Poller {
        id: cpu
        command: "top -bn1 | grep 'Cpu(s)' | awk '{printf \"%d\", $2+$4}'"
        interval: 3000
    }

    Poller {
        id: memory
        command: "free -m | awk 'NR==2{printf \"%d\", $3*100/$2 }'"
        interval: 3000
    }
    Poller {
        id: keyboardLayout
        command: "i=$(hyprctl devices -j | jq -r '.keyboards[] | select(.main) | .active_layout_index'); l=$(hyprctl getoption input:kb_layout -j | jq -r '.str' | cut -d, -f$((i+1))); v=$(hyprctl getoption input:kb_variant -j | jq -r '.str' | cut -d, -f$((i+1))); echo \"$l${v:+ $v}\""
        interval: 1000
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
        // anchors.rightMargin: 20
        anchors.verticalCenter: parent.verticalCenter
        spacing: 8

        Pill {
            implicitWidth: 80
            implicitHeight: 38
            Text {
                anchors.centerIn: parent
                text: " " + volume.value + "%"
                font.family: Theme.fontFamily
                font.pixelSize: 16
                color: Theme.foreground
            }
        }

        Pill {
            implicitWidth: keyboardLayout.value.length * 10 + 52
            implicitHeight: 38

            Process {
                id: layoutSwitch
                command: ["hyprctl", "switchxkblayout", "all", "next"]
            }

            Text {
                anchors.centerIn: parent
                text: " " + keyboardLayout.value
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
                color: network.value === "connected" ? Theme.success : Theme.danger
            }
        }

        Pill {
            implicitWidth: 80
            implicitHeight: 38
            Text {
                anchors.centerIn: parent
                text: " " + cpu.value + "%"
                font.family: Theme.fontFamily
                font.pixelSize: 16
                color: cpu.value > 50 ? (cpu.value > 80 ? Theme.danger : Theme.warning) : Theme.success
            }
        }

        Pill {
            implicitWidth: 80
            implicitHeight: 38
            Text {
                anchors.centerIn: parent
                text: " " + memory.value + "%"
                font.family: Theme.fontFamily
                font.pixelSize: 16
                color: memory.value > 50 ? (memory.value > 80 ? Theme.danger : Theme.warning) : Theme.success
            }
        }
    }
}
