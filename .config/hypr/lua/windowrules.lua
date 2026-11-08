-- Window Rules
-- See https://wiki.hypr.land/Configuring/Window-Rules/

hl.window_rule({
    name = "pygame-asteroids",
    match = {
        title = "^(pygame window)$",
    },
    float = true,
    center = true,
    size = "1280 720",
})
