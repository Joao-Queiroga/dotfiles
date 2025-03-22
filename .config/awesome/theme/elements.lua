local gmc = dofile(theme_path .. "gmc.lua")

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

-- Font
theme.font = --[["JetbrainsMono Nerd Font 9" ]] "Terminus 8" -- "Tamsyn 10" -- "Sans 8"
theme.taglist_font = "Jetbrains Mono 9"
theme.widget_font = "JetbrainsMono Nerd Font 11"

-- Gap
theme.useless_gap = 3

-- Border
theme.border_width = 2

theme.border_normal = gmc.color.comment
theme.border_focus = gmc.color.purple
theme.border_marked = gmc.color.orange

-- Tag List
theme.bg_normal     = gmc.color.background     .. "cc"
theme.bg_focus      = gmc.color.purple    .. "cc"
theme.bg_urgent     = gmc.color.red .. "cc"
theme.bg_minimize   = gmc.color.currentline   .. "cc"
theme.bg_systray    = gmc.color.background   .. "cc"

theme.fg_normal     = gmc.color.foreground
theme.fg_focus      = gmc.color.foreground
theme.fg_urgent     = gmc.color.background
theme.fg_minimize   = gmc.color.foreground

theme.taglist_bg_focus = gmc.color.purple .. "cc"
theme.taglist_fg_focus = gmc.color.foreground

-- Generate taglist squares:
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, gmc.color.foreground
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, gmc.color.foreground
)

-- Task List
theme.tasklist_bg_normal = gmc.color.currentline    .. "88"
theme.tasklist_bg_focus  = gmc.color.comment   .. "88"
theme.tasklist_fg_focus  = gmc.color.foreground

-- Menu
theme.menu_submenu_icon  = theme_path .. "misc/default/submenu.png"

theme.menu_height = 20      -- dpi(15)
theme.menu_width  = 180     -- dpi(100)
--theme.menu_context_height = 20

theme.menu_bg_normal = gmc.color.background  .. "cc"
theme.menu_bg_focus  = gmc.color.comment .. "cc"
theme.menu_fg_focus  = gmc.color.foreground

theme.menu_border_color = gmc.color.currentline .. "cc"
theme.menu_border_width = 1

-- Systray
theme.systray_spacing = 2
