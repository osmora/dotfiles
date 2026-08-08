---------------------
---- KEYBINDINGS ----
---------------------

-- see https://wiki.hypr.land/Configuring/Basics/Binds/ for more

-- Functions
local exec = hl.dsp.exec_cmd
local fmt = string.format

-- Variables
local modifier     = "SUPER"
local terminal     = "alacritty msg create-window"
local file_manager = "thunar"
local ipc          = "noctalia msg"
local multimedia_rules = { locked = true, repeating = true }

-- Noctalia keybinds
local noctalia_keybinds = {
    { key = "period", action = "desktop-widgets-toggle-edit" },
    { key = "comma",  action = "settings-toggle" },
    { key = "slash",  action = "lockscreen-widgets-toggle-edit" },
    { key = "R",      action = "panel-toggle launcher" },
    { key = "M",      action = "panel-toggle session" },

    -- Key only
    { key = "Print",     key_only = true, action = "screenshot-region" },
    { key = "ALT + TAB", key_only = true, action = "window-switcher" },

    -- Laptop multimedia
    { key = "XF86AudioRaiseVolume", key_only = true, action = "volume-up",       rules = multimedia_rules },
    { key = "XF86AudioLowerVolume", key_only = true, action = "volume-down",     rules = multimedia_rules },
    { key = "XF86AudioMute",        key_only = true, action = "volume-mute",     rules = multimedia_rules },
    { key = "XF86AudioMicMute",     key_only = true, action = "mic-mute",        rules = multimedia_rules },
    { key = "XF86MonBrightnessUp",  key_only = true, action = "brightness-up",   rules = multimedia_rules },
    { key = "XF86MonBrightnessDown",key_only = true, action = "brightness-down", rules = multimedia_rules },
}
for _, item in ipairs(noctalia_keybinds) do
    local keybind = item.key_only and item.key or fmt("%s + %s", modifier, item.key)
    if item.rules then
        hl.bind(keybind, exec(fmt("%s %s", ipc, item.action)), item.rules)
    else
        hl.bind(keybind, exec(fmt("%s %s", ipc, item.action)))
    end
end

-- General keybinds
local general_keybinds = {
    -- Apps
    { key = "Q", action = exec(terminal) },
    { key = "E", action = exec(fmt("uwsm app -- %s", file_manager)) },

    -- Window Controls
    { key = "C", action = hl.dsp.window.close() },
    { key = "V", action = hl.dsp.window.float({ action = "toggle" }) },
    { key = "P", action = hl.dsp.window.pseudo() },
    { key = "J", action = hl.dsp.layout("togglesplit") },
    { key = "F", action = hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }) },

    -- Special Workspace (Scratchpad)
    { key = "S",         action = hl.dsp.workspace.toggle_special("magic") },
    { key = "SHIFT + S", action = hl.dsp.window.move({ workspace = "special:magic" }) },

    -- Move/resize windows with modifier + LMB/RMB and dragging
    { key = "mouse:272", action = hl.dsp.window.drag(),   rules = { mouse = true } },
    { key = "mouse:273", action = hl.dsp.window.resize(), rules = { mouse = true } },

    -- Scroll through existing workspaces with modifier + scroll
    { key = "mouse_up",   action = hl.dsp.focus({ workspace = "e-1" }) },
    { key = "mouse_down", action = hl.dsp.focus({ workspace = "e+1" }) },
}
for _, item in ipairs(general_keybinds) do
    local keybind = fmt("%s + %s", modifier, item.key)
    if item.rules then
        hl.bind(keybind, item.action, item.rules)
    else
        hl.bind(keybind, item.action)
    end
end

for _, direction in ipairs({ "left", "right", "up", "down" }) do
    hl.bind(
        fmt("%s + %s", modifier, direction),
        hl.dsp.focus({ direction = direction })
    )

    hl.bind(
        fmt("%s + SHIFT + %s", modifier, direction),
        hl.dsp.window.move({ direction = direction })
    )
end

-- Switch workspaces with modifier + [0-9]
-- Move active window to a workspace with modifier + SHIFT + [0-9]
for i = 1, 10 do
    local keybind = i % 10 -- 10 maps to key 0
    hl.bind(
        fmt("%s + %s", modifier, keybind),
        hl.dsp.focus({ workspace = i})
    )

    hl.bind(
        fmt("%s + SHIFT + %s", modifier, keybind),
        hl.dsp.window.move({ workspace = i })
    )
end
