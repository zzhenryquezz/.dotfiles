// Bar.qml
import Quickshell

PanelWindow {
    required property var modelData
    screen: modelData
    color: "transparent"

    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: 40

    BarWorkspace { }
}
