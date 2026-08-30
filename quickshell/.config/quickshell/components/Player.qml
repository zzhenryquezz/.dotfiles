import QtQuick
import Quickshell.Services.Mpris
import QtQuick.Layouts

import qs.config

RowLayout {
    id: root
    visible: root.player !== undefined
    property int startIndex: 0
    readonly property var player: Mpris.players.values.find(p => p.isPlaying)

    Chip {
        id: chip
        icon: ""
        text: ""
    }

    Timer {
        interval: 500
        running: true
        repeat: true
        onTriggered: root.updatePlayer()
    }

    function updatePlayer() {
        if (!root.player) {
            return;
        }

        let icon = "󰎈";
        let textColor = Theme.foreground;

        if (root.player.identity === "Spotify") {
            icon = "󰓇";
            textColor = Theme.success;
        }

        if (root.player.identity === "Chrome") {
            icon = "";
            textColor = Theme.warning;
        }

        let text = root.player.metadata["xesam:title"] + " - " + root.player.metadata["xesam:artist"].join(", ");

        text = text.length > 30 ? text.substring(root.startIndex, root.startIndex + 30) + "..." : text;

        root.startIndex = (root.startIndex + 1) % text.length;

        chip.text = text;
        chip.icon = icon;
        chip.textColor = textColor;
    }
}
