import Quickshell
import QtQuick

Scope {
    id: root

    property int sessionDuration: 25
    property int breakDuration: 5

    property bool isRunning: timer.isRunning
    property bool isDue: timer.isRunning && timer.remainingTime <= 0

    readonly property int remainingTime: timer.remainingTime
    property string text: timer.text
    property string identifier: "session"

    PomodoroTimer {
        id: timer
    }

    Component.onCompleted: {
        timer.durationInMilliseconds = root.sessionDuration * 60 * 1000;
    }

    function start() {
        timer.start();
    }

    function toggleMode() {
        root.identifier = root.identifier === "session" ? "break" : "session";
        timer.durationInMilliseconds = root.identifier === "session" ? root.sessionDuration * 60 * 1000 : root.breakDuration * 60 * 1000;

        timer.save();
        timer.refresh();
    }

    function close() {
        timer.stop();
        timer.reset();

        root.toggleMode();
    }
}
