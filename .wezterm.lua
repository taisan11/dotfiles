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
        mods = 'CTRL|SHIFT',
        action = wezterm.action.ReloadConfiguration,
    },
    {
        key = 'w',
        mods = 'CTRL',
        action = wezterm.action.CloseCurrentPane { confirm = true },
    },
    {
            key = 'c',
    mods = 'CTRL',
    action = wezterm.action_callback(function(window, pane)
        selection_text = window:get_selection_text_for_pane(pane)
        is_selection_active = string.len(selection_text) ~= 0
        if is_selection_active then
            window:perform_action(wezterm.action.CopyTo('ClipboardAndPrimarySelection'), pane)
        else
            window:perform_action(wezterm.action.SendKey{ key='c', mods='CTRL' }, pane)
        end
    end),
    },
}

-- and finally, return the configuration to wezterm
return config
