-- Visual Appearance, Gaps, Borders, Shadows, and Blur
-- See https://wiki.hypr.land/Configuring/Variables/

hl.config({
    general = {
        gaps_in = 4,
        gaps_out = 4,
        border_size = 1,
        layout = "scrolling",
        col = {
            active_border = "rgba(d0d0d0ff)",
            inactive_border = "rgba(202020ff)",
        },
    },

    scrolling = {
        column_width = 1.0,
        fullscreen_on_one_column = true,
    },

    decoration = {
        rounding = 0,

        blur = {
            enabled = true,
            size = 4,
            passes = 2,
        },

        shadow = {
            enabled = false,
            range = 12,
            render_power = 3,
        },
    },

    dwindle = {
        preserve_split = true,
    },

    misc = {
        disable_hyprland_logo = true,
        force_default_wallpaper = 0,
    },
})
