local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local menubar = require("menubar")
local naughty = require("naughty")

local keys = require("key_mapping.keys")

local button_maker = require("ui.components.button_maker")
local box_maker = require("ui.components.box_maker")

myawesomemenu = {
	{
		"hotkeys",
		function()
			hotkeys_popup.show_help(nil, awful.screen.focused())
		end,
	},
	{ "manual", user.terminal .. " -e man awesome" },
	{ "edit config", user.editor_cmd .. " " .. awesome.conffile },
	{ "restart", awesome.restart },
	{
		"quit",
		function()
			awesome.quit()
		end,
	},
}

mymainmenu = awful.menu({
	items = {
		{ "awesome", myawesomemenu, beautiful.awesome_icon },
		{ "open terminal", user.terminal },
	},
})

mylauncher = awful.widget.launcher({
	image = beautiful.awesome_icon,
	menu = mymainmenu,
})

-- Menubar configuration
menubar.utils.terminal = user.terminal -- Set the terminal for applications that require it

awful.screen.connect_for_each_screen(function(s)
	-- Each screen has its own tag table.
	awful.tag({ "1", "2", "3", "4", "5", "6", "7" }, s, awful.layout.layouts[1])
	--     a

	local icon_size = dpi(50)

	-- Create an imagebox widget which will contain an icon indicating which layout we're using.
	-- We need one layoutbox per screen.
	s.mylayoutbox = awful.widget.layoutbox({
		screen = s,
		buttons = keys.layoutbox_buttons,
		forced_width = dpi(30),
		forced_height = icon_size,
	})
	-- Create a taglist widget
	s.mytaglist = awful.widget.taglist({
		screen = s,
		filter = awful.widget.taglist.filter.all,
		buttons = keys.taglist_buttons,
	})

	-- Create the wibox
	local wibar_margins = {
		top = dpi(10),
		bottom = dpi(10),
		left = dpi(10),
		right = dpi(10),
	}
	local wibar_shape = function(cr, width, height)
		--gears.shape.partial_squircle(cr, width, height, false, true, true, true, dpi(10), dpi(0.09))
		gears.shape.rounded_rect(cr, width, height, 12)
	end

	s.mywibox = awful.wibar({
		position = "top",
		screen = s,
		margins = wibar_margins,
		height = dpi(50),
		bg = beautiful.invisible,
	})

	-- Add widgets to the wibox
	s.mywibox:setup({
		{
			box_maker.box({ -- Left widgets
				mylauncher,

				button_maker.text_button("dashboard", dpi(0), beautiful.text_white_color, function()
					awesome.emit_signal("dashboard::toggle")
				end),

				s.mytaglist,

				layout = wibox.layout.fixed.horizontal,
			}, dpi(12)),

			box_maker.box({ -- Middle widgets
				widget = wibox.widget.textclock,
			}, dpi(12)),

			box_maker.box({ -- Right widgets
				button_maker.icon_button(
					beautiful.screenshot_icon,
					{ top = dpi(0), right = dpi(10), bottom = dpi(0), left = dpi(0) },
					dpi(30),
					icon_size,
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
					icon_size,
					function()
						awful.spawn.with_shell("rofi -modi emoji -show emoji")
					end
				),
				s.mylayoutbox,

				layout = wibox.layout.fixed.horizontal,
			}, dpi(12)),

			layout = wibox.layout.align.horizontal,
		},

		widget = wibox.container.background,
		bg = beautiful.invisible,
		shape = wibar_shape,
	})
end)
