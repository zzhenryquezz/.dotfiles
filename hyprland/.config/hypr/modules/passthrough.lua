
hl.bind(MAIN_MOD .. " + CTRL + ALT + P", hl.dsp.submap("passthrough"))

hl.define_submap("passthrough", "reset", function()
    hl.bind( MAIN_MOD .. " + escape", hl.dsp.submap("reset"))
end)
