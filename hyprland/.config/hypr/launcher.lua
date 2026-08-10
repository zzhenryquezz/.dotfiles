-----------------------
---- LAUNCHER ---------
-----------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("vicinae server")
end)

-- blur
hl.layer_rule({
    match = { namespace = "vicinae" },
    name = "vicinae-blur",
    blur = true,
    ignore_alpha = 0,
})

-- disable animation for vicinae only
hl.layer_rule({
    match = { namespace = "vicinae" },
    name = "vicinae-no-animation",
    no_anim = true,
})


hl.bind(MAIN_MOD .. " + SPACE", hl.dsp.exec_cmd("vicinae vicinae://toggle"))
