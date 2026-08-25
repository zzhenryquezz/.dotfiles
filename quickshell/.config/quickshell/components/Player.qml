import QtQuick
import Quickshell.Services.Mpris
import QtQuick.Layouts

RowLayout {
    id: root
    visible: root.player !== undefined
    property string icon: "󰎈"
    readonly property var player: Mpris.players.values.find(p => p.isPlaying)

    Chip {
        icon: root.icon
        text: root.player ? root.player.identity + " - " + root.player.trackTitle : ""
    }
}
