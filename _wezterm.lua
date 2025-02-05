-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = 'AdventureTime'

-- Things that are already covered by quick selection mode
-- https://github.com/wez/wezterm/blob/b28bbbc4c8345197e433590c9ce50a7bf3ea5bc7/wezterm-gui/src/overlay/quickselect.rs#L26
config.quick_select_patterns = {
  -- match linear tickets for poolside
  'POOL-[0-9]{1,20}',
}
config.scrollback_lines = 10000

-- and finally, return the configuration to wezterm
return config
