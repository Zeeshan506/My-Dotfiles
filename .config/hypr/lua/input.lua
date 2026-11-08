-- Input & Peripherals configuration
-- See https://wiki.hypr.land/Configuring/Variables/#input

hl.config({
    input = {
        kb_layout = "us",
        follow_mouse = 1,
        repeat_rate = 30,
        repeat_delay = 350,
        numlock_by_default = true,
        sensitivity = 0,

        touchpad = {
            natural_scroll = true,
            tap_to_click = true,
        },
    },
})
