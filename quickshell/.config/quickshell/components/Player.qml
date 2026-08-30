import QtQuick
import Quickshell.Services.Mpris
import QtQuick.Layouts

import qs.config

RowLayout {
    id: root
    visible: root.player !== undefined
    property int startIndex: 0
    property int maxLength: 21
    readonly property var player: Mpris.players.values.find(p => p.isPlaying)

    Chip {
        id: chip
        icon: ""
        text: ""
        maxLength: root.maxLength
        implicitWidth: 260
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

        let fullText = root.player.metadata["xesam:title"] + " - " + root.player.metadata["xesam:artist"].join(", ");
        let text = fullText;
        let index = 0;
        let maxLength = root.maxLength;


        if (text.length > maxLength) {
            const separator = " | ";
            const loop = text + separator + text;

            text = loop.slice(root.startIndex, root.startIndex + maxLength);
            // text = text.slice(root.startIndex, root.startIndex + maxLength);
            // index = (root.startIndex + 1) % text.length;
            index = (root.startIndex + 1) % (fullText.length + separator.length);
        }

        root.startIndex = index;
        chip.text = text;
        chip.icon = icon;
        chip.textColor = textColor;
    }
}
