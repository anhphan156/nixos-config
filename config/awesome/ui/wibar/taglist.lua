local awful = require('awful')
local wibox = require('wibox')
local beautiful = require('beautiful')
local keys = require("key_mapping.keys")

return function(s)
	return awful.widget.taglist({
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
end
