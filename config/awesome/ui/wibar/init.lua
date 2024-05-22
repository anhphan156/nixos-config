local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")

local button_maker = require("ui.components.button_maker")
local box_maker = require("ui.components.box_maker")

return function(s)
	local wibar = awful.wibar({
		position = "top",
		screen = s,
		margins = {
			top = dpi(10),
			bottom = dpi(10),
			left = dpi(10),
			right = dpi(10),
		},
		height = dpi(50),
		bg = beautiful.invisible,
	})

	-- Add widgets to the wibox
	wibar:setup({
		{
			box_maker.box({ -- Left widgets
				button_maker.text_button(
					beautiful.dashboard_icon,
					{ right = dpi(10), left = dpi(10) },
					beautiful.text_red_color,
					function()
						awesome.emit_signal("dashboard::toggle")
					end
				),
				-- button_maker.icon_button(
				-- 	beautiful.dashboard_icon,
				-- 	{ top = dpi(0), right = dpi(10), bottom = dpi(0), left = dpi(0) },
				-- 	dpi(30),
				-- 	dpi(10),
				-- 	function()
				-- 		awesome.emit_signal("dashboard::toggle")
				-- 	end
				-- ),

				s.mytaglist,

				layout = wibox.layout.fixed.horizontal,
			}, dpi(12)),

			box_maker.box({ -- Middle widgets
				widget = wibox.widget.textclock,
			}, dpi(12)),

			box_maker.box({ -- Right widgets
				{
					s.systray,
					widget = wibox.container.margin,
					margins = { right = dpi(17), left = dpi(3), top = dpi(2) },
				},
				button_maker.icon_button(
					beautiful.screenshot_icon,
					{ top = dpi(0), right = dpi(10), bottom = dpi(0), left = dpi(0) },
					dpi(30),
					beautiful.wibar_icon_size,
					function()
						awful.spawn.easy_async_with_shell(
							[[maim -u -b 3 -m 5 -s /tmp/maim_clipboard \
                            && xclip -selection clipboard -t image/png /tmp/maim_clipboard \
                            && rm /tmp/maim_clipboard]],
							function(stdout, stderr)
								naughty.notify({ title = "Screenshot taken", text = "Screenshot saved to clipboard" })
								-- naughty.notify({ title = "Screenshot taken", text = stderr })
							end
						)
					end
				),
				button_maker.icon_button(
					beautiful.emoji_picker_icon,
					{ top = dpi(0), right = dpi(10), bottom = dpi(0), left = dpi(0) },
					dpi(30),
					beautiful.wibar_icon_size,
					function()
						awful.spawn.with_shell("rofi -modi emoji -show emoji")
					end
				),
				button_maker.icon_button(
					beautiful.control_center_icon,
					{ top = dpi(0), right = dpi(10), bottom = dpi(0), left = dpi(0) },
					dpi(30),
					beautiful.wibar_icon_size,
					function()
						awesome.emit_signal('control_center::toggle')
					end
				),
				s.mylayoutbox,

				layout = wibox.layout.fixed.horizontal,
			}, dpi(12)),

			layout = wibox.layout.align.horizontal,
			expand = "none",
		},

		widget = wibox.container.background,
		bg = beautiful.invisible,
		shape = function(cr, width, height)
			gears.shape.rounded_rect(cr, width, height, 12)
		end
	})

	return wibar
end
