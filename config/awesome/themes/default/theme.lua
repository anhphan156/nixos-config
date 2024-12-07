---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
--local themes_path = gfs.get_themes_dir()
local themes_path = gfs.get_xdg_config_home() .. "/awesome/themes/"

local theme = {}

theme.font = "sans 14"

theme.bg_normal = "#222222"
theme.bg_focus = "#535d6c"
theme.bg_urgent = "#ff0000"
theme.bg_minimize = "#444444"
theme.bg_systray = theme.bg_normal

theme.fg_normal = "#aaaaaa"
theme.fg_focus = "#ffffff"
theme.fg_urgent = "#ffffff"
theme.fg_minimize = "#ffffff"

theme.useless_gap = dpi(10)
theme.border_width = dpi(0)
theme.border_normal = "#000000"
theme.border_focus = "#535d6c"
theme.border_marked = "#91231c"

theme.corner_radius = dpi(14)
theme.wibar_icon_size = dpi(50)

theme.text_white_color = "#aaaaaa"
theme.text_red_color = "#ce3332"
theme.grey = '#444444'

theme.battery_green_color = "#33f266"
theme.battery_yellow_color = "#f2f422"
theme.battery_red_color = theme.text_red_color
theme.battery_unplugged_background_color = "#111111"
theme.battery_plugged_background_color = "#229944"

theme.invisible = "#00000000"
theme.profile_pic = themes_path .. "default/firefly.png"

theme.screenshot_icon = themes_path .. "default/icons/screenshot.png"
theme.emoji_picker_icon = themes_path .. "default/icons/emoji.png"
theme.control_center_icon = themes_path .. "default/icons/control_center.png"
theme.uptime_icon = themes_path .. "default/icons/compositor.png"
theme.poweroff_icon = themes_path .. "default/icons/poweroff.png"
theme.lock_icon = themes_path .. "default/icons/lock.png"
theme.battery_icon = themes_path .. "default/icons/battery.png"
theme.ram_icon = themes_path .. "default/icons/ram.png"
theme.overcast_icon = themes_path .. "default/icons/cloud.png"
theme.rain_icon = themes_path .. "default/icons/rain.png"
theme.sunny_icon = themes_path .. "default/icons/sun.png"
theme.cloud_icon = themes_path .. "default/icons/cloud.png"
theme.mist_icon = themes_path .. "default/icons/mist.png"
theme.clear_icon = themes_path .. "default/icons/star.png"
theme.play_icon = themes_path .. "default/icons/play.png"
theme.next_icon = themes_path .. "default/icons/next.png"
theme.prev_icon = themes_path .. "default/icons/prev.png"
theme.repeat_icon = themes_path .. "default/icons/repeat.png"
theme.shuffle_icon = themes_path .. "default/icons/shuffle.png"

theme.tag_icon_active = " "
theme.tag_icon_inactive = "  "

--theme.dashboard_icon = themes_path .. "default/icons/dashboard.png"
theme.dashboard_icon = " 󰯊 "

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

theme.titlebar_bg_normal = "#222222"
theme.titlebar_bg_focus = "#222222"
theme.taglist_fg_focus = "#ee5500"

theme.radialprogressbar_border_width = dpi(5)
theme.radialprogressbar_border_color = '#111111'
theme.radialprogressbar_color = '#eeeeee'

-- Generate taglist squares:
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(taglist_square_size, theme.fg_normal)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(taglist_square_size, theme.fg_normal)

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path .. "default/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width = dpi(100)

theme.systray_icon_spacing = dpi(10)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = themes_path .. "default/titlebar/close_normal.png"
theme.titlebar_close_button_focus = themes_path .. "default/titlebar/close_focus.png"
theme.titlebar_close_button_normal_hover = themes_path .. "default/titlebar/close_hover.png"
theme.titlebar_close_button_focus_hover = themes_path .. "default/titlebar/close_hover.png"

theme.titlebar_minimize_button_normal = themes_path .. "default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus = themes_path .. "default/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = themes_path .. "default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive = themes_path .. "default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = themes_path .. "default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active = themes_path .. "default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = themes_path .. "default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive = themes_path .. "default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = themes_path .. "default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active = themes_path .. "default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = themes_path .. "default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive = themes_path .. "default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = themes_path .. "default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active = themes_path .. "default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = themes_path .. "default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive = themes_path .. "default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = themes_path .. "default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active = themes_path .. "default/titlebar/maximized_focus_active.png"

theme.wallpaper = themes_path .. "default/firefly.jpg"

-- You can use your own layout icons like this:
theme.layout_fairh = themes_path .. "default/layouts/fairhw.png"
theme.layout_fairv = themes_path .. "default/layouts/fairvw.png"
theme.layout_floating = themes_path .. "default/layouts/floatingw.png"
theme.layout_magnifier = themes_path .. "default/layouts/magnifierw.png"
theme.layout_max = themes_path .. "default/layouts/maxw.png"
theme.layout_fullscreen = themes_path .. "default/layouts/fullscreenw.png"
theme.layout_tilebottom = themes_path .. "default/layouts/tilebottomw.png"
theme.layout_tileleft = themes_path .. "default/layouts/tileleftw.png"
theme.layout_tile = themes_path .. "default/layouts/tilew.png"
theme.layout_tiletop = themes_path .. "default/layouts/tiletopw.png"
theme.layout_spiral = themes_path .. "default/layouts/spiralw.png"
theme.layout_dwindle = themes_path .. "default/layouts/dwindlew.png"
theme.layout_cornernw = themes_path .. "default/layouts/cornernww.png"
theme.layout_cornerne = themes_path .. "default/layouts/cornernew.png"
theme.layout_cornersw = themes_path .. "default/layouts/cornersww.png"
theme.layout_cornerse = themes_path .. "default/layouts/cornersew.png"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(theme.menu_height, theme.bg_focus, theme.fg_focus)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = themes_path .. "default/titlebar/icon_theme.png"

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
