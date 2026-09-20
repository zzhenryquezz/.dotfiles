import QtQuick
import Quickshell.Services.Mpris
import QtQuick.Layouts

import qs.config
import qs.components


RowLayout {
    id: root
    visible: root.player !== undefined
    property string display: "track"
    property int startIndex: 0
    property int maxLength: 16
    readonly property var player: Mpris.players.values.find(p => p.isPlaying)

    Chip {
        id: chip
        icon: ""
        text: ""
        maxLength: root.maxLength
        implicitWidth: 200

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                root.display = root.display === "track" ? "player" : "track";
                root.updatePlayer();
            }
        }
    }

    Timer {
        interval: 500
        running: root.display === "track"
        repeat: true
        onTriggered: root.updatePlayer()
    }

    function displayPlayer() {
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

        chip.icon = icon;
        chip.text = root.player.identity;
        chip.textColor = textColor;
    }

    function displayTrack() {
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

        let fullText = root.player.trackTitle + " - " + root.player.trackArtist;
        let text = fullText;
        let index = 0;
        let maxLength = root.maxLength;
        let maxIndex = fullText.length - maxLength;

        const separator = "     ";
        const loop = text + separator + text;
        const start = root.startIndex % (loop.length + separator.length);
        const end = Math.min(start + maxLength, loop.length);

        text = loop.slice(start, end);
        // text = text.slice(root.startIndex, root.startIndex + maxLength);
        // index = (root.startIndex + 1) % text.length;
        index = (root.startIndex + 1) % (fullText.length + separator.length);

        root.startIndex = index;
        chip.text = text;
        chip.icon = icon;
        chip.textColor = textColor;
    }

    function updatePlayer() {
        if (!root.player) {
            return;
        }

        if (root.display === "player") {
            root.displayPlayer();
        } 

        if (root.display === "track") {
            root.displayTrack();
        }
    }
}
