-- Animations and Curves
-- See https://wiki.hypr.land/Configuring/Animations/

hl.curve("smooth", { type = "bezier", points = { { 0.25, 0.9 }, { 0.25, 1.0 } } })

hl.animation({ leaf = "windows",    enabled = true, speed = 4, bezier = "smooth" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 4, bezier = "smooth" })
hl.animation({ leaf = "border",     enabled = true, speed = 6, bezier = "default" })
hl.animation({ leaf = "fade",       enabled = true, speed = 4, bezier = "smooth" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 4, bezier = "smooth" })
