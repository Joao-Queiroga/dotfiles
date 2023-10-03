local home = os.getenv("HOME")

local _M = {
	modkey = "Mod4",

	terminal = "wezterm",
	file_manager = "pcmanfm",
	browser = "brave",

	wallpaper = home .. "/.config/.background",
	icon_theme = "ePapirus-Dark"
}

return _M
