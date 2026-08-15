---------------------
---- KEYBINDINGS ----
---------------------

hl.bind(MAIN_MOD .. " + T", hl.dsp.exec_cmd("kitty"))
hl.bind(MAIN_MOD .. " + Q", hl.dsp.window.close())
hl.bind(MAIN_MOD .. " + M",
    hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(MAIN_MOD .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(MAIN_MOD .. " + P", hl.dsp.window.pseudo())
-- hl.bind(MAIN_MOD .. " + SHIFT + J", hl.dsp.layout("togglesplit")) -- dwindle only

-- apps
hl.bind(MAIN_MOD .. " + E", hl.dsp.exec_cmd("kitty yazi"))
hl.bind(MAIN_MOD .. " + I", hl.dsp.exec_cmd("kitty --class popup-xl sh -lc '~/.local/bin/work inbox'"))
hl.bind(MAIN_MOD .. " + O", hl.dsp.exec_cmd("kitty zsh -lc '~/.local/bin/dot tmux project'"))

-- focus windows
hl.bind(MAIN_MOD .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(MAIN_MOD .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(MAIN_MOD .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(MAIN_MOD .. " + J", hl.dsp.focus({ direction = "down" }))

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

-- Example special workspace (scratchpad)
hl.bind(MAIN_MOD .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(MAIN_MOD .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

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


-- print
hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -m region --raw | satty --filename -"))
hl.bind(MAIN_MOD .. " + CTRL + ALT + L", hl.dsp.exec_cmd("hyprlock"))
