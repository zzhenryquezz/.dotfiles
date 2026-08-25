import Quickshell
import QtQuick

Scope {
    property list<KeyboardDevice> keyboards: []
    property KeyboardDevice main: null

    property string layoutDescriptionShort: main ? main.active_layout_description_short : ""

    Component {
        id: keyboardComponent
        KeyboardDevice {}
    }

    Poller {
        id: poll

        command: "hyprctl devices -j"
        interval: 500

        onValueChanged: {
            const json = JSON.parse(value)
            const data = json.keyboards || []

            keyboards = data.map(item => {
                const k = keyboardComponent.createObject(poll)


                const layouts = item.layout.split(",")
                const variants = item.variant.split(",")
                const activeIndex = item.active_layout_index

                const layout = layouts[activeIndex] || ""
                const variant = variants[activeIndex] || ""

                k.name = item.name
                k.main = item.main

                k.active_layout_description_short = [layout, variant].filter(Boolean).join(" ")


                return k
            })

            main = keyboards.find(k => k.main) || null
        }
    }
}
