pragma ComponentBehavior: Bound

import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

import "../config"

RowLayout {
    id: workspaces
    spacing: 0
    property int quantity: 9

    Repeater {
        model: workspaces.quantity

        Rectangle {
            id: ws
            required property int index
            property bool active: Hyprland.workspaces.values.some(w => w.id === ws.index + 1)
            property bool focused: Hyprland.focusedWorkspace?.id === (ws.index + 1)
            property bool first: ws.index === 0
            property bool last: ws.index === (workspaces.quantity - 1)

            width: 32
            height: 38

            // Apply independent corner radii directly

            // Base background fill
            color: "transparent"
            Canvas {
                id: canvas
                anchors.fill: parent

                property real radiusTL: ws.first ? Theme.radius : 0
                property real radiusBL: ws.first ? Theme.radius : 0
                property real radiusTR: ws.last ? Theme.radius : 0
                property real radiusBR: ws.last ? Theme.radius : 0

                property color fillColor: ws.focused ? Theme.primary : Theme.background
                property color borderColor: ws.focused ? Theme.primary : Theme.border
                property color bottomColor: ws.focused || ws.active ? Theme.primary : Theme.border
                property real borderWidth: 2

                onPaint: {
                    var ctx = getContext("2d");
                    ctx.reset();

                    var w = width;
                    var h = height;
                    var bw = borderWidth;
                    var halfBw = bw / 2;

                    var rTL = radiusTL;
                    var rTR = radiusTR;
                    var rBR = radiusBR;
                    var rBL = radiusBL;

                    ctx.lineJoin = "miter";
                    ctx.lineCap = "butt";

                    // 1. FILL BACKGROUND
                    ctx.beginPath();
                    ctx.moveTo(rTL, 0);
                    ctx.lineTo(w - rTR, 0);
                    ctx.arcTo(w, 0, w, rTR, rTR);
                    ctx.lineTo(w, h - rBR);
                    ctx.arcTo(w, h, w - rBR, h, rBR);
                    ctx.lineTo(rBL, h);
                    ctx.arcTo(0, h, 0, h - rBL, rBL);
                    ctx.lineTo(0, rTL);
                    ctx.arcTo(0, 0, rTL, 0, rTL);
                    ctx.closePath();
                    ctx.fillStyle = fillColor;
                    ctx.fill();

                    ctx.lineWidth = bw;

                    // 2. MAIN BORDER FRAME (Top, Left, Right, and Outer Bottom Curves)
                    ctx.beginPath();
                    if (ws.first) {
                        ctx.moveTo(rBL + halfBw, h - halfBw);
                        ctx.arcTo(halfBw, h - halfBw, halfBw, h - (rBL + halfBw), rBL);
                        ctx.lineTo(halfBw, rTL + halfBw);
                        ctx.arcTo(halfBw, halfBw, rTL + halfBw, halfBw, rTL);
                    } else {
                        ctx.moveTo(0, halfBw);
                    }

                    ctx.lineTo(w - (ws.last ? rTR + halfBw : 0), halfBw);

                    if (ws.last) {
                        ctx.arcTo(w - halfBw, halfBw, w - halfBw, rTR + halfBw, rTR);
                        ctx.lineTo(w - halfBw, h - (rBR + halfBw));
                        ctx.arcTo(w - halfBw, h - halfBw, w - (rBR + halfBw), h - halfBw, rBR);
                    }

                    ctx.strokeStyle = borderColor;
                    ctx.stroke();

                    // 3. BOTTOM ACCENT BORDER (Flat bottom section only)
                    ctx.beginPath();
                    var startX = ws.first ? rBL + halfBw : 0;
                    var endX = ws.last ? w - (rBR + halfBw) : w;

                    ctx.moveTo(startX, h - halfBw);
                    ctx.lineTo(endX, h - halfBw);

                    ctx.strokeStyle = bottomColor;
                    ctx.stroke();
                }

                onFillColorChanged: requestPaint()
                onBottomColorChanged: requestPaint()
                onBorderColorChanged: requestPaint()
            }

            Text {
                anchors.centerIn: parent

                text: ws.index + 1
                color: ws.focused ? Theme.primaryForeground : Theme.foreground
                font.family: Theme.fontFamily

                font {
                    pixelSize: 16
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: Hyprland.dispatch(`hl.dsp.focus({ workspace = ${ws.index + 1} })`)
            }
        }
    }

}
