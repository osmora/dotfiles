------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
})

-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/
hl.on("hyprland.start", function ()
    hl.exec_cmd("uwsm app -t service -u noctalia.service -- noctalia --daemon")
    hl.exec_cmd("uwsm app -t service -u alacritty.service -- alacritty --daemon")
end)

--------------------
---- Load files ----
--------------------

require("hypr.input")

require("hypr.look")

require("hypr.binds")

require("hypr.rules")

require("noctalia").apply_theme()
