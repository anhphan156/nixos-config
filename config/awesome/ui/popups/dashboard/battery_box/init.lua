local beautiful = require('beautiful')
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
    local green = { '#33f266' }
    local yellow = { '#f2f422' }
    local red = { '#aa2222' }

    battery_arcchart.value = percentage
    battery_text.text = percentage .. '%'
    
    if(tonumber(percentage) < 15) then
        battery_arcchart.colors = red
    elseif(tonumber(percentage) < 50) then
        battery_arcchart.colors = yellow
    elseif(tonumber(percentage) < 101) then
        battery_arcchart.colors = green
    end
end)

return battery_box
