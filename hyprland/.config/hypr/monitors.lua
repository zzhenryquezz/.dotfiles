-----------------------
---- MONITORS ---------
-----------------------

local primary = {
    id = "DVI-D-1",
    scale = 1.33
    -- scale = 2.5
}

local secondary = {
    id    = "HDMI-A-1",
    -- scale    = 1.6,
    scale = 1,
}

hl.monitor({
    output   = primary.id,
    mode     = "3840x2160@30",
    position = "0x0",
    scale    = primary.scale,
})

hl.monitor({
    output = secondary.id,
    mode   = "1920x1080@60",
    scale  = secondary.scale,
})

hl.config({
    cursor = {
        default_monitor = primary.id
    }
})

for i = 1, 4 do
    hl.workspace_rule({
        workspace = tostring(i),
        monitor   = primary.id,
    })
end

for i = 5, 10 do
    hl.workspace_rule({
        workspace = tostring(i),
        monitor   = secondary.id,
    })
end
