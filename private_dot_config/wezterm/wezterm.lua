local wezterm = require 'wezterm'
return {
  font = wezterm.font 'JetBrainsMono Nerd Font',
  color_scheme = 'tokyonight_night',
	hide_tab_bar_if_only_one_tab = true,
	use_fancy_tab_bar = false,
	tab_bar_at_bottom = true,
	window_padding = {
		-- top = 0,
		bottom = 0,
		left = 0,
		right = 0
	}
}
