local beautiful = require('beautiful')
local dpi = beautiful.xresources.apply_dpi
local wibox = require('wibox')
local gears = require('gears')

local battery_arcchart = wibox.container.arcchart()
local battery_text = wibox.widget.textbox()

local battery_box = wibox.widget{
    {
        {
            {
                forced_width = dpi(200),
                forced_height = dpi(160),
                border_width = dpi(0),
                bg = '#111111',
                colors = { '#33f266' },
                thickness = dpi(25),
                start_angle = -1.57079632679,
                rounded_edge = true,
                value = 90,
                min_value = 0,
                max_value = 100,
                widget = battery_arcchart
            },
            {
                {
                    widget = battery_text,
                    text = 'battery',
                    font = 'sans 18'
                },
                widget = wibox.container.place
            },
            layout = wibox.layout.stack
        },
        widget = wibox.container.place,
    },
    widget = wibox.container.background,
    bg = beautiful.titlebar_bg_normal,
    shape = function(cr, width, height) gears.shape.rounded_rect(cr, width, height, 12) end
}

awesome.connect_signal('daemon::battery', function(percentage)
    battery_arcchart.value = percentage
    battery_text.text = percentage .. '%'
end)

return battery_box
