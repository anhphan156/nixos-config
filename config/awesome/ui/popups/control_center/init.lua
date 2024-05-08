local awful = require('awful')
local wibox = require('wibox')
local gears = require('gears')
local beautiful = require('beautiful')
local box_maker = require("ui.components.box_maker")

local control_center = awful.popup({
	widget = wibox.container.background,
    bg = beautiful.titlebar_bg_normal,
	visible = false,
	ontop = true,
	border_width = 0,
    shape = function(cr, width, height)
        gears.shape.infobubble(cr, width, height, beautiful.corner_radius, dpi(10), 6.01 * width / 7 - dpi(10))
    end,
	placement = function(c)
		awful.placement.top_right(c,
			{ 
                margins = { 
                    top = dpi(80),
                    bottom = dpi(10),
                    left = dpi(0),
                    right = dpi(10) 
                } 
            }
		)
	end,
})

local grid = wibox.widget{
    layout = wibox.layout.grid,
    homogeneous          = true,
    spacing              = dpi(5),
    minimum_column_width = dpi(25),
    minimum_row_height   = dpi(10),
    column_count = 8,
    forced_width = dpi(500),
    forced_height = dpi(700),
}

grid:add_widget_at(box_maker.flex_box({ widget = wibox.widget.textbox, text = "test 1"}), 1, 1, 1, 7);
grid:add_widget_at(box_maker.flex_box({ widget = wibox.widget.textbox, text = "test 2"}), 1, 8, 1, 1);
grid:add_widget_at(box_maker.flex_box({ widget = wibox.widget.textbox, text = "test 3"}), 2, 1, 1, 1);
grid:add_widget_at(box_maker.flex_box({ widget = wibox.widget.textbox, text = "test 4"}), 2, 2, 1, 1);

control_center:setup({
    {
        widget = grid,
    },
    widget = wibox.container.margin,
    margins = { top = dpi(30), left = dpi(20) }
})

awesome.connect_signal('control_center::toggle', function()
    control_center.visible = not control_center.visible
end)
