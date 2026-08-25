import Quickshell
import Quickshell.Io
import QtQuick

Scope {
    id: root
    property double startAt: 0
    property double endAt: 0
    property int durationInMilliseconds: 0
    property int interval: 5
    property bool isRunning: false

    property int remainingTime: 0
    property string text: "00:00"
    property string identifier: "default"
    property string filename: Quickshell.env("HOME") + "/.local/state/pomodoro-" + root.identifier + ".json"

    Component.onCompleted: {
        root.refresh();
    }

    FileView {
        id: file
        path: root.filename
        onLoaded: root.load()
    }

    Timer {
        id: timer
        interval: 1000
        running: root.isRunning
        repeat: true

        onTriggered: root.refresh()
    }

    function load() {
        var data = JSON.parse(file.text());

        root.isRunning = data.isRunning || false;

        if (root.isRunning) {
            root.startAt = data.startAt || 0;
            root.endAt = data.endAt || 0;
            root.durationInMilliseconds = data.durationInMilliseconds || 0;
        }

        root.refresh();
    }

    function refresh() {
        let minutes = root.durationInMilliseconds / 60000;
        let seconds = (root.durationInMilliseconds % 60000) / 1000;
        let remaining = root.durationInMilliseconds;
        let negative = false;
        let absolute = Math.abs(remaining);


        if (root.isRunning) {
            const now = Date.now();
            const end = root.endAt;

            remaining = Math.floor((end - now) / 1000);
            absolute = Math.abs(remaining);
            negative = remaining < 0;

            minutes = Math.floor(absolute / 60);
            seconds = Math.floor(absolute % 60);
        }

        if (seconds < 0) {
            seconds = seconds * -1;
        }

        if (minutes < 0) {
            minutes = minutes * -1;
        }

        const s = Math.floor(seconds).toString().padStart(2, '0');
        const m = Math.floor(minutes).toString().padStart(2, '0');

        root.remainingTime = remaining;
        root.text = `${remaining < 0 ? '-' : ''}${m}:${s}`;
    }

    function save() {
        file.setText(JSON.stringify({
            startAt: root.startAt,
            endAt: root.endAt,
            durationInMilliseconds: root.durationInMilliseconds,
            isRunning: root.isRunning
        }));
    }

    function reset() {
        root.startAt = 0;
        root.endAt = 0;
        root.isRunning = false;
        root.save();
        root.refresh();
    }

    function start() {
        const now = Date.now();
        root.startAt = now;
        root.endAt = now + root.durationInMilliseconds;
        root.isRunning = true;
        root.save();
        root.refresh();
    }

    function stop() {
        root.isRunning = false;
        root.save();
        root.refresh();
    }
}
