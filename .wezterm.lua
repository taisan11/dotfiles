-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}
config = wezterm.config_builder()
-- if wezterm.config_builder then
--   config = wezterm.config_builder()
-- end
-- ime
config.use_ime = true
config.window_decorations = "RESIZE"
config.font = wezterm.font_with_fallback({
    { family = "HackGen Console NF" },
    { family = "Noto Color Emoji" },
    { family = "Noto Sans CJK JP" },
    { family = "JetBrains Mono" },
    { family = "NerdFont" },
})
config.font_size = 16
config:set_strict_mode(true)
config.window_background_opacity = 0.86
config.macos_window_background_blur = 30
-- config.window_decorations = ""
config.window_frame = {
    inactive_titlebar_bg = "none",
    active_titlebar_bg = "none",
}

config.window_background_gradient = {
    colors = { "#000000" },
}

config.keys = {
    {
        key = 'r',
        mods = 'CMD|SHIFT',
        action = wezterm.action.ReloadConfiguration,
    },
    {
        key = 'w',
        mods = 'CMD',
        action = wezterm.action.CloseCurrentPane { confirm = true },
    },
}

-- and finally, return the configuration to wezterm
return config
