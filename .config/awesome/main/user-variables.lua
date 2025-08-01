local home = os.getenv("HOME")

local _M = {
	modkey = "Mod4",

	terminal = "kitty -1",
	file_manager = "thunar",
	browser = "brave",

	wallpaper = home .. "/.config/.background",
	icon_theme = "Papirus-Dark",
}

return _M
