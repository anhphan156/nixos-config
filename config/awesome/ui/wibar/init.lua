local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local menubar = require("menubar")
local naughty = require("naughty")

local keys = require("key_mapping.keys")

local button_maker = require("ui.components.button_maker")
local box_maker = require("ui.components.box_maker")

awful.screen.connect_for_each_screen(function(s)
	s.systray = wibox.widget.systray()
	s.systray.visible = true
	-- Each screen has its own tag table.
	awful.tag({ "1", "2", "3", "4", "5", "6", "7" }, s, awful.layout.layouts[1])

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
		-- style = {
		-- 	shape = gears.shape.powerline,
		-- },
		-- layout = {
		-- 	spacing = 18,
		-- 	spacing_widget = {
		-- 		color = "#dddddd",
		-- 		shape = gears.shape.powerline,
		-- 		widget = wibox.widget.separator,
		-- 	},
		-- 	layout = wibox.layout.fixed.horizontal,
		-- },
		widget_template = {
			{
				{
					id = "text_icon",
					widget = wibox.widget.textbox,
					markup = "<b>" .. beautiful.tag_icon_inactive .. "</b>",
					font = "sans 16",
				},
				widget = wibox.container.margin,
				margins = {
					left = dpi(00),
					right = dpi(10),
				},
			},
			widget = wibox.container.background,
			create_callback = function(self, _, index, _)
				self:get_children_by_id("text_icon")[1].markup = index
							== tonumber(awful.screen.focused().selected_tag.name)
						and "<b> " .. beautiful.tag_icon_active .. "</b>"
					or "<b>" .. beautiful.tag_icon_inactive .. "</b>"
				-- self:connect_signal("mouse::enter", function()
				-- 	local text_icon = self:get_children_by_id("text_icon")[1].markup
				-- 	if
				-- 		text_icon == "<b>" .. beautiful.tag_icon_active .. "</b>"
				-- 		or text_icon == "<b>" .. beautiful.tag_icon_inactive .. "</b>"
				-- 	then
				-- 		self.backup = text_icon
				-- 		self.has_backup = true
				-- 	end
				-- 	self:get_children_by_id("text_icon")[1].markup = '<span foreground = "'
				-- 		.. beautiful.text_red_color
				-- 		.. '">'
				-- 		.. text_icon
				-- 		.. "</span>"
				-- end)
				-- self:connect_signal("mouse::leave", function()
				-- 	if self.has_backup then
				-- 		self:get_children_by_id("text_icon")[1].markup = self.backup
				-- 	end
				-- end)
			end,
			update_callback = function(self, _, index, _) --luacheck: no unused args
				self:get_children_by_id("text_icon")[1].markup = index
							== tonumber(awful.screen.focused().selected_tag.name)
						and "<b> " .. beautiful.tag_icon_active .. "</b>"
					or "<b>" .. beautiful.tag_icon_inactive .. "</b>"
			end,
		},
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
			expand = "none",
		},

		widget = wibox.container.background,
		bg = beautiful.invisible,
		shape = wibar_shape,
	})
end)
