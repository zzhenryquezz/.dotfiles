
import Quickshell 
import Quickshell.Io 
import QtQuick 

Scope {
    id: root
    property string command: ""
    property string value: ""
    property int interval: 1000

    Process {
        id: proc
        command: ["sh", "-c", root.command]
        running: true
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
