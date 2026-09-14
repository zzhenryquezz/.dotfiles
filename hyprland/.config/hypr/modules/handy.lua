hl.bind(MAIN_MOD .. " + CTRL + SPACE", hl.dsp.exec_cmd("~/Downloads/Handy_0.9.4_amd64.AppImage --toggle-transcription"))

hl.window_rule({
    match = {
        class = "Handy",
        title = "Recording"
    },
    no_initial_focus = true,
    border_size = 0,
    float = true,
    no_shadow = true,
    no_blur = true,
    -- move to bottom center of the screen
    move = {
        "monitor_w - window_w - 10",
        "0"
    },
})
