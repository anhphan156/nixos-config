local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local wibox = require("wibox")
local naughty = require("naughty")
local helpers = require("helpers")

local box_maker = require("ui.components.box_maker")

local profile_box = require("ui.popups.dashboard.profile_box")
local uptime_box = require("ui.popups.dashboard.uptime_box")
local battery_box = require("ui.popups.dashboard.battery_box")
local ram_box = require("ui.popups.dashboard.ram_box")
local weather_box = require("ui.popups.dashboard.weather_box")

local fortune_text = wibox.widget.textbox()

local dashboard = awful.popup({
	widget = wibox.container.background,
	bg = beautiful.invisible,
	--bg = '#990000',
	visible = false,
	forced_width = 1980,
	maximum_width = 1980,
	maximum_height = 720,
	ontop = true,
	border_width = 0,
	placement = function(c)
		awful.placement.top_left(
			c,
			{ margins = { top = dpi(200), bottom = dpi(10), left = dpi(100), right = dpi(10) } }
		)
	end,
})

local grid = wibox.widget({
	-- {
	-- 	row_index = 1,
	-- 	col_index = 1,
	-- 	row_span = 2,
	-- 	col_span = 1,
	-- 	widget = profile_box,
	-- },
	-- {
	-- 	row_index = 9,
	-- 	col_index = 1,
	-- 	row_span = 1,
	-- 	col_span = 2,
	-- 	widget = uptime_box,
	-- },
	-- {
	-- 	row_index = 1,
	-- 	col_index = 3,
	-- 	row_span = 3,
	-- 	col_span = 2,
	-- 	widget = battery_box,
	-- },
	-- {
	-- 	row_index = 4,
	-- 	col_index = 3,
	-- 	row_span = 3,
	-- 	col_span = 2,
	-- 	widget = ram_box,
	-- },
	-- {
	-- 	row_index = 1,
	-- 	col_index = 5,
	-- 	row_span = 2,
	-- 	col_span = 2,
	-- 	widget = weather_box,
	-- },
	-- {
	-- 	row_index = 3,
	-- 	col_index = 5,
	-- 	row_span = 4,
	-- 	col_span = 2,
	-- 	widget = box_maker.flex_box({ widget = wibox.widget.textbox, text = "test 1" }),
	-- },
	-- {
	-- 	row_index = 1,
	-- 	col_index = 7,
	-- 	row_span = 6,
	-- 	col_span = 3,
	-- 	widget = box_maker.flex_box({ widget = wibox.widget.textbox, text = "test 2" }),
	-- },
	-- {
	-- 	row_index = 7,
	-- 	col_index = 3,
	-- 	row_span = 1,
	-- 	col_span = 7,
	-- 	widget = box_maker.flex_box({ widget = wibox.widget.textbox, text = "test 3" }),
	-- },
	homogeneous = true,
	expand = false,
	spacing = dpi(12),
	column_count = 9,
	min_cols_size = dpi(180),
	min_rows_size = dpi(80),
	layout = wibox.layout.grid,
})

grid:add_widget_at(profile_box, 1, 1, 6, 2);
grid:add_widget_at(uptime_box, 7, 1, 1, 2);
grid:add_widget_at(battery_box, 1, 3, 3, 2);
grid:add_widget_at(ram_box, 4, 3, 3, 2);
grid:add_widget_at(weather_box, 1, 5, 2, 2);
grid:add_widget_at(box_maker.flex_box({ widget = wibox.widget.textbox, text = "test 1" }), 3, 5, 4, 2);
grid:add_widget_at(box_maker.flex_box({ widget = wibox.widget.textbox, text = "test 2" }), 1, 7, 6, 3);

grid:add_widget_at(box_maker.flex_box({
	{
		widget = fortune_text, text = "Fetching fortune text ..."
	},
	widget = wibox.container.place
}), 7, 3, 1, 7);

dashboard:setup({
	widget = grid
})

awesome.connect_signal("dashboard::toggle", function()
	dashboard.visible = not dashboard.visible
	helpers.minimize_all_clients(dashboard.visible)
end)

awesome.connect_signal('daemon::fortune', function(fortune)
	fortune_text.markup = '<i>' .. fortune .. '</i>'
end)

return dashboard
