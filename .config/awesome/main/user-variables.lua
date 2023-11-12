local home = os.getenv("HOME")

local _M = {
	modkey = "Mod4",

	terminal = "kitty -1",
	file_manager = "thunar",
	browser = "firefox",

	wallpaper = home .. "/.config/.background",
	icon_theme = "ePapirus-Dark",
}

return _M
