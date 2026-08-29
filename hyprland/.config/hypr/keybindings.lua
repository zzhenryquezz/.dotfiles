---------------------
---- KEYBINDINGS ----
---------------------

hl.bind(MAIN_MOD .. " + Q", hl.dsp.window.close())
hl.bind(MAIN_MOD .. " + ESCAPE",
    hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(MAIN_MOD .. " + V", hl.dsp.window.float({ action = "toggle" }))
-- hl.bind(MAIN_MOD .. " + P", hl.dsp.window.pseudo())
-- hl.bind(MAIN_MOD .. " + SHIFT + J", hl.dsp.layout("togglesplit")) -- dwindle only

hl.bind(MAIN_MOD .. " + T", hl.dsp.exec_cmd("kitty"))

-- focus windows
hl.bind(MAIN_MOD .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(MAIN_MOD .. " + LEFT", hl.dsp.focus({ direction = "left" }))
hl.bind(MAIN_MOD .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(MAIN_MOD .. " + RIGHT", hl.dsp.focus({ direction = "right" }))
hl.bind(MAIN_MOD .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(MAIN_MOD .. " + UP", hl.dsp.focus({ direction = "up" }))
hl.bind(MAIN_MOD .. " + J", hl.dsp.focus({ direction = "down" }))
hl.bind(MAIN_MOD .. " + DOWN", hl.dsp.focus({ direction = "down" }))

-- swap window
hl.bind(MAIN_MOD .. " + SHIFT + H", hl.dsp.window.swap({ direction = "left" }))
hl.bind(MAIN_MOD .. " + SHIFT + L", hl.dsp.window.swap({ direction = "right" }))
hl.bind(MAIN_MOD .. " + SHIFT + K", hl.dsp.window.swap({ direction = "up" }))
hl.bind(MAIN_MOD .. " + SHIFT + J", hl.dsp.window.swap({ direction = "down" }))

-- move workspaces
hl.bind(MAIN_MOD .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(MAIN_MOD .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(MAIN_MOD .. " + CTRL + L", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(MAIN_MOD .. " + CTRL + RIGHT", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(MAIN_MOD .. " + CTRL + H", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(MAIN_MOD .. " + CTRL + LEFT", hl.dsp.focus({ workspace = "e-1" }))

-- Move active window to a workspace with MAIN_MOD + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(MAIN_MOD .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(MAIN_MOD .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end


-- Move/resize windows with MAIN_MOD + LMB/RMB and dragging
hl.bind(MAIN_MOD .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(MAIN_MOD .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
    { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
    { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
    { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
    { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- misc
hl.bind(MAIN_MOD .. " + CTRL + ALT + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(MAIN_MOD .. " + F", hl.dsp.window.fullscreen({ action = "toggle" }))

-- apps
hl.bind(MAIN_MOD .. " + W", hl.dsp.submap("work"))
hl.bind(MAIN_MOD .. " + P", hl.dsp.submap("personal"))

hl.define_submap("work", "reset", function()
    hl.bind("A", hl.dsp.exec_cmd("kitty zsh -lc '~/.local/bin/work atlas tui'"))
    hl.bind("T", hl.dsp.exec_cmd("kitty zsh -lc '~/.local/bin/dot tmux project'"))
    hl.bind("E", hl.dsp.exec_cmd("kitty yazi ~/work"))
    hl.bind("B", hl.dsp.exec_cmd("google-chrome-stable --profile-directory='Default'"))
    hl.bind("I", hl.dsp.exec_cmd("kitty --class popup-xl sh -lc '~/.local/bin/work inbox'"))

    hl.bind("escape", hl.dsp.submap("reset"))
end)

hl.define_submap("personal", "reset", function()
    hl.bind("A", hl.dsp.exec_cmd("kitty zsh -lc '~/.local/bin/kuro atlas tui'"))
    hl.bind("T", hl.dsp.exec_cmd("kitty zsh -lc '~/.local/bin/dot tmux create ~/kuro'"))
    hl.bind("E", hl.dsp.exec_cmd("kitty yazi ~/kuro"))
    hl.bind("B", hl.dsp.exec_cmd("google-chrome-stable --profile-directory='Profile 1'"))
    hl.bind("I", hl.dsp.exec_cmd("kitty --class popup-xl sh -lc '~/.local/bin/kuro inbox'"))

    hl.bind("escape", hl.dsp.submap("reset"))
end)


-- media commands
hl.bind(MAIN_MOD .. " + M", hl.dsp.submap("music"))

hl.define_submap("music", "reset", function()
    hl.bind("P", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
    hl.bind("Q", hl.dsp.submap("reset"))
    hl.bind("escape", hl.dsp.submap("reset"))
end)

-- spotify commands
hl.bind(MAIN_MOD .. " + A", hl.dsp.submap("apps"))

hl.define_submap("apps", "reset", function()

    hl.bind("S", hl.dsp.submap("spotify"))

    hl.define_submap("spotify", "reset", function()
        hl.bind("SPACE", hl.dsp.exec_cmd("playerctl -p spotify play-pause"), { locked = true })
        hl.bind("L", hl.dsp.exec_cmd("playerctl -p spotify next"), { locked = true })
        hl.bind("N", hl.dsp.exec_cmd("playerctl -p spotify next"), { locked = true })
        hl.bind("H", hl.dsp.exec_cmd("playerctl -p spotify previous"), { locked = true })
        hl.bind("P", hl.dsp.exec_cmd("playerctl -p spotify previous"), { locked = true })
        hl.bind("Q", hl.dsp.submap("reset"))
        hl.bind("escape", hl.dsp.submap("reset"))
    end)

    hl.bind("Q", hl.dsp.submap("reset"))
    hl.bind("escape", hl.dsp.submap("reset"))
end)

-- Example special workspace (scratchpad)
hl.bind(MAIN_MOD .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(MAIN_MOD .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))
hl.bind(MAIN_MOD .. " + D", hl.dsp.workspace.toggle_special("magic2"))
hl.bind(MAIN_MOD .. " + SHIFT + D", hl.dsp.window.move({ workspace = "special:magic2" }))
