local awful = require('awful')
local wibox = require('wibox')
local gears = require('gears')
local beautiful = require('beautiful')

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

control_center:setup({
    {
        widget = wibox.widget.textbox,
        text = 'asdf'
    },
    widget = wibox.container.place,
    forced_width = dpi(500),
    forced_height = dpi(700),
})

awesome.connect_signal('control_center::toggle', function()
    control_center.visible = not control_center.visible
end)
