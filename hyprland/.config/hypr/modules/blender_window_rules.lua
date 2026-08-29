hl.env("GDK_BACKEND", "wayland,x11,*")

local float_window_size = "1200 800"


-- make preferences window float
hl.window_rule({
    match = { class = "blender", title = "Preferences" },
    float = true,
    center = true,
    size = float_window_size,
})

-- Set size for all float windows of Blender
hl.window_rule({
    match = {
        class = "blender",
        float = true,
    },
    center = true,
    size = float_window_size,
})

