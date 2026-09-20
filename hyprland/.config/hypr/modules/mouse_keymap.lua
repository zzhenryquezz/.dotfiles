-- move mouse with keyboard keys
--
hl.bind(MAIN_MOD .. " + M", hl.dsp.submap("mouse"))

hl.define_submap("mouse", function()
    hl.bind("h", hl.dsp.exec_cmd("ydotool mousemove -x -10 -y 0"), {
        repeating = true
    })

    hl.bind("SHIFT + h", hl.dsp.exec_cmd("ydotool mousemove -x -100 -y 0"), {
        repeating = true
    })

    hl.bind("l", hl.dsp.exec_cmd("ydotool mousemove -x 10 -y 0"), {
        repeating = true
    })

    hl.bind("SHIFT + l", hl.dsp.exec_cmd("ydotool mousemove -x 100 -y 0"), {
        repeating = true
    })

    hl.bind("j", hl.dsp.exec_cmd("ydotool mousemove -y 10 -x 0"), {
        repeating = true
    })

    hl.bind("SHIFT + j", hl.dsp.exec_cmd("ydotool mousemove -y 100 -x 0"), {
        repeating = true
    })

    hl.bind("k", hl.dsp.exec_cmd("ydotool mousemove -y -10 -x 0"), {
        repeating = true
    })

    hl.bind("SHIFT + k", hl.dsp.exec_cmd("ydotool mousemove -y -100 -x 0"), {
        repeating = true
    })

    hl.bind("SPACE", hl.dsp.exec_cmd("ydotool click 0xc0"), {
        repeating = true
    })

    --  mouse down 
    hl.bind("v", hl.dsp.exec_cmd("ydotool click 0x40"), {
        repeating = true
    })

    hl.bind("SHIFT + v", hl.dsp.exec_cmd("ydotool click 0x60"), {
        repeating = true
    })

    hl.bind("SHIFT + SPACE", hl.dsp.exec_cmd("ydotool click 0xc1"))

    hl.bind("N", hl.dsp.exec_cmd("ydotool mousemove -w -x 0 -y -1"), {
        repeating = true
    })

    hl.bind("SHIFT + N", hl.dsp.exec_cmd("ydotool mousemove -w -x 0 -y -10"), {
        repeating = true
    })

    hl.bind("P", hl.dsp.exec_cmd("ydotool mousemove -w -x 0 -y 1"), {
        repeating = true
    })

    hl.bind("SHIFT + P", hl.dsp.exec_cmd("ydotool mousemove -w -x 0 -y 10"), {
        repeating = true
    })


    hl.bind("q", hl.dsp.submap("reset"))
    hl.bind("escape", hl.dsp.submap("reset"))
    hl.bind(MAIN_MOD .. " + M", hl.dsp.submap("reset"))
end)
