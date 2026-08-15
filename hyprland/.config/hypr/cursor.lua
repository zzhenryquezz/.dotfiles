---------------------
---- CURSOR ---------
---------------------

hl.env("XCURSOR_SIZE", "30")
hl.env("HYPRCURSOR_SIZE", "30")
hl.env("WLR_NO_HARDWARE_CURSORS", 1)

hl.on("hyprland.start", function()
    hl.exec_cmd("hyprctl setcursor Bibata-Modern-Ice 30")
end)

hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})

hl.config({
    cursor = {
        default_monitor = MONITOR_PRIMARY_ID
    }
})


