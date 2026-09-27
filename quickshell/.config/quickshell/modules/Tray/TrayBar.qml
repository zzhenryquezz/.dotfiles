import QtQuick
import Quickshell
import Quickshell.Services.SystemTray

import qs.components
import qs.config

Row {
    id: root
    property PanelWindow bar: null
    spacing: 4

    Repeater {
        model: SystemTray.items

        delegate: Chip {
            id: item
            required property SystemTrayItem modelData
            imageSource: item.modelData.icon

            QsMenuAnchor {
                id: menuAnchor
                menu: item.modelData.menu
                anchor {
                    window: bar
                    item: item
                    rect.y: item.height
                }
            }

            PopupWindow {
                id: menuWindow
                anchor.window: root.bar
                anchor.item: item
                anchor.rect.x: 0
                anchor.rect.y: item.height
                color: Theme.background

                visible: false
            }

            MouseArea {
                anchors.fill: item
                acceptedButtons: Qt.LeftButton | Qt.RightButton
                cursorShape: Qt.PointingHandCursor

                onClicked: mouse => {
                    if (mouse.button === Qt.LeftButton) {
                        item.modelData.activate();
                    }

                    if (mouse.button === Qt.RightButton && item.modelData.menu) {
                        // menuWindow.visible = true;
                        menuAnchor.open();
                    }
                }
            }
        }
    }
}
