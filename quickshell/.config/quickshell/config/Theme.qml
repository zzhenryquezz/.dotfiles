pragma Singleton

import QtQuick

QtObject {
    readonly property color primary: Mocha.sky
    readonly property color primaryForeground: Mocha.crust

    readonly property color background: Mocha.crust
    readonly property color foreground: Mocha.text

    readonly property color border: Mocha.surface0

    readonly property color secondary: Mocha.mauve

    readonly property color danger: Mocha.red
    readonly property color success: Mocha.teal
    readonly property color warning: Mocha.yellow

    readonly property string fontFamily: "JetBrainsMono Nerd Font Propo"

    readonly property int radius: 4
}
