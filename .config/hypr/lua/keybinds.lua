-- Keybindings and Mouse Controls
-- See https://wiki.hypr.land/Configuring/Binds/

local mainMod = "SUPER"
local terminal = "kitty"
local fileManager = "thunar"
local menu = "rofi -show drun"

-- Application launch & basic window management
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exit())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + Space", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.layout("fit expand"))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))

-- Screenshot bindings
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("hyprshot -m region -o ~/Pictures/Screenshots --freeze"))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("hyprshot -m window -o ~/Pictures/Screenshots"))
hl.bind(mainMod .. " + SHIFT + O", hl.dsp.exec_cmd("hyprshot -m output -o ~/Pictures/Screenshots"))

-- Utility bindings
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("waypaper"))
hl.bind(mainMod .. " + X", hl.dsp.exec_cmd("~/.config/waybar/power_menu-hyprland.sh"))
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd("cliphist list | hyprlauncher --dmenu | cliphist decode | wl-copy"))

-- Scrolling Layout Controls & Navigation
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Move columns/windows in track
hl.bind(mainMod .. " + CTRL + left",  hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + CTRL + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + CTRL + up",    hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + CTRL + down",  hl.dsp.window.move({ direction = "down" }))

-- Center current column/window into view
hl.bind(mainMod .. " + C", hl.dsp.layout("fit_into_view"))

-- Resize column widths
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.layout("colresize +0.05"), { repeating = true })
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.layout("colresize -0.05"), { repeating = true })

-- Fallback floating window resize
hl.bind(mainMod .. " + ALT + right", hl.dsp.window.resize({ x = 30, y = 0, relative = true }),   { repeating = true })
hl.bind(mainMod .. " + ALT + left",  hl.dsp.window.resize({ x = -30, y = 0, relative = true }),  { repeating = true })
hl.bind(mainMod .. " + ALT + up",    hl.dsp.window.resize({ x = 0, y = -30, relative = true }),  { repeating = true })
hl.bind(mainMod .. " + ALT + down",  hl.dsp.window.resize({ x = 0, y = 30, relative = true }),   { repeating = true })

-- Mouse move & resize
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Workspace navigation (Page Up / Page Down & Wheel)
hl.bind(mainMod .. " + Page_Down", hl.dsp.focus({ workspace = "m+1" }))
hl.bind(mainMod .. " + Page_Up",   hl.dsp.focus({ workspace = "m-1" }))
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Cycle focus between windows on active workspace
hl.bind(mainMod .. " + SHIFT + mouse_down", hl.dsp.window.cycle_next())
hl.bind(mainMod .. " + SHIFT + mouse_up",   hl.dsp.window.cycle_next({ prev = true }))

-- Move active window to next/previous workspace
hl.bind(mainMod .. " + SHIFT + Page_Down", hl.dsp.window.move({ workspace = "m+1" }))
hl.bind(mainMod .. " + SHIFT + Page_Up",   hl.dsp.window.move({ workspace = "m-1" }))

-- Quality of Life additions
hl.bind(mainMod .. " + K", hl.dsp.window.center())
hl.bind(mainMod .. " + P", hl.dsp.window.pin())
hl.bind(mainMod .. " + Z", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + Z", hl.dsp.window.move({ workspace = "special:magic" }))

-- Gloview integration (supporting native hl.plugin.gloview & dynamic hyprpm load)
local function gloview(action, arg)
    return function()
        if hl.plugin and hl.plugin.gloview and type(hl.plugin.gloview[action]) == "function" then
            hl.plugin.gloview[action](arg)
        else
            hl.dispatch("gloview:" .. action, arg or "")
        end
    end
end

hl.bind(mainMod .. " + Tab", gloview("toggle"))
hl.bind(mainMod .. " + SHIFT + Tab", gloview("desktop"))
hl.bind(mainMod .. " + CTRL + Tab", gloview("allworkspaces"))
hl.bind(mainMod .. " + bracketright", gloview("next"))
hl.bind(mainMod .. " + bracketleft", gloview("prev"))

-- Workspaces 1-9
for i = 1, 9 do
    hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end

-- Laptop/media keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl set 5%+"),                    { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl set 5%-"),                    { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioPlay",        hl.dsp.exec_cmd("playerctl play-pause"),                       { locked = true })
hl.bind("XF86AudioNext",        hl.dsp.exec_cmd("playerctl next"),                             { locked = true })
hl.bind("XF86AudioPrev",        hl.dsp.exec_cmd("playerctl previous"),                         { locked = true })
