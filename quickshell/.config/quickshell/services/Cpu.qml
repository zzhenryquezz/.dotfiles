import Quickshell
import QtQuick

Scope {
    property int usage: parseInt(poller.value)

    Poller {
        id: poller
        command: "top -bn1 | grep 'Cpu(s)' | awk '{printf \"%d\", $2+$4}'"
        interval: 3000
    }
}
