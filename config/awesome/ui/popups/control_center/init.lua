local awful = require('awful')
local wibox = require('wibox')
local gears = require('gears')
local beautiful = require('beautiful')
local music_player = require('ui.popups.control_center.music_player')
local box_maker = require("ui.components.box_maker")
local button_maker = require("ui.components.button_maker")

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
    spacing              = dpi(10),
    minimum_column_width = dpi(64),
    minimum_row_height   = dpi(20),
    column_count = 8,
    forced_width = dpi(520),
    forced_height = dpi(710),
}

grid:add_widget_at(
    box_maker.control_center_box({
        {
            widget = wibox.widget.textbox,
            font = "sans 18",
            markup = "Test"
        },
        {
            widget = wibox.widget.textbox,
            font = "sans 18",
            markup = "Hello backspace"
        },
        layout = wibox.layout.fixed.horizontal,
    })
, 1, 1, 1, 6);

grid:add_widget_at(
    {
        button_maker.icon_button(
            beautiful.poweroff_icon,
            dpi(0),
            dpi(40),
            dpi(40),
            function()
                awesome.emit_signal('acpi::power_button')
                control_center.visible = false
            end
        ),
        widget = wibox.container.place
    }
, 1, 7, 1, 1);

grid:add_widget_at(
    box_maker.control_center_box({ widget = wibox.widget.textbox, text = "test 3"})
, 2, 1, 6, 4);

grid:add_widget_at(
    box_maker.control_center_box({ widget = wibox.widget.textbox, text = "test 4"})
, 2, 5, 6, 3);

grid:add_widget_at(
    box_maker.control_center_box({ widget = wibox.widget.textbox, text = "test 5"})
, 8, 1, 2, 7);
grid:add_widget_at(
    box_maker.control_center_box({ widget = wibox.widget.textbox, text = "test 6"})
, 10, 1, 2, 7);
grid:add_widget_at(
    box_maker.control_center_box(music_player)
, 12, 1, 3, 7);

control_center:setup({
    {
        widget = grid,
    },
    widget = wibox.container.margin,
    margins = { top = dpi(30), left = dpi(20), right = dpi(5) }
})

awesome.connect_signal('control_center::toggle', function()
    control_center.visible = not control_center.visible
    if(control_center.visible) then
        awesome.emit_signal('music_player::set_title')
    end
end)
