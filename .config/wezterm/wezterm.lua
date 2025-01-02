local wezterm = require("wezterm")
local config = wezterm.config_builder()
config.font = wezterm.font("JetBrains Mono", { weight = "DemiBold" })
config.font_size = 12
config.force_reverse_video_cursor = true
config.hide_mouse_cursor_when_typing = false

require("keys").setup(config)

config.color_scheme = "tokyonight_night"
config.tab_and_split_indices_are_zero_based = true

config.window_close_confirmation = "NeverPrompt"

config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.window_padding = {
	bottom = 0,
	left = 0,
	right = 0,
}

return config
