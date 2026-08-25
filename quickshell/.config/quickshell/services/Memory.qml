import Quickshell
import QtQuick

Scope {
    property int usage: parseInt(poller.value)

    Poller {
        id: poller
        command: "free -m | awk 'NR==2{printf \"%d\", $3*100/$2 }'"
        interval: 3000
    }
}
