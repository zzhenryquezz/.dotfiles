import Quickshell 
import Quickshell.Io 
import QtQuick 

Scope {
    id: root
    property string command: ""
    property string value: ""
    property int interval: 1000
    property bool running: false

    Component.onCompleted: {
        if (root.command) {
            proc.running = true;
        }
    }

    Process {
        id: proc
        command: ["sh", "-c", root.command]
        running: root.running
        stdout: StdioCollector {
            onStreamFinished: root.value = this.text.trim()
        }
    }

    Timer {
        interval: root.interval
        running: true
        repeat: true
        onTriggered: proc.running = true
    }
}
