local wezterm = require 'wezterm'
local keys = require 'keys'
local config = {}
config.font = wezterm.font 'JetBrains Mono'
config.font_size = 12

config.color_scheme = 'tokyonight_night'
config.tab_and_split_indices_are_zero_based = true

config.leader = { key = "b", mods="CTRL" }

config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.window_padding = {
	bottom = 0,
	left = 0,
	right = 0
}

config.keys = keys

return config
