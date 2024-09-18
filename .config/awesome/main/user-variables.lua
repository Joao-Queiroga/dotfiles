local home = os.getenv("HOME")

local _M = {
	modkey = "Mod4",

	terminal = "kitty -1",
	file_manager = "thunar",
	browser = "zen-browser",

	wallpaper = home .. "/.config/.background",
	icon_theme = "ePapirus-Dark",
}

return _M
