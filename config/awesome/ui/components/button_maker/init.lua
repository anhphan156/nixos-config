local wibox = require('wibox')
local awful = require('awful')
local gears = require('gears')

local button_maker = {}

button_maker.text_button = function(text, margins, color, callback)
    local button = wibox.widget {
        {
            markup = '<span foreground="' .. color .. '">' .. text .. '</span>',
            widget = wibox.widget.textbox
        },
        margins = margins,
        widget = wibox.container.margin 
    } 

    button:connect_signal('button::release', callback)

    return button
end

return button_maker
