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
config.font_size = 13.5
config:set_strict_mode(true)

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
