-----------------------
---- MONITORS ---------
-----------------------
hl.monitor({
    output   = MONITOR_PRIMARY_ID,
    mode     = "3840x2160@30",
    position = "0x0",
    scale    = 1.33,
})

hl.monitor({
    output = MONITOR_SECONDARY_ID,
    mode   = "1920x1080@60",
    scale  = 1,
})

for i = 1, 4 do
    hl.workspace_rule({
        workspace = tostring(i),
        monitor   = MONITOR_PRIMARY_ID
    })
end

for i = 5, 10 do
    hl.workspace_rule({
        workspace = tostring(i),
        monitor   = MONITOR_SECONDARY_ID
    })
end
