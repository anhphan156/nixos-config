local awful = require('awful')
local beautiful = require('beautiful')
local keys = require("key_mapping.keys")

local layoutbox = function(s)
    return awful.widget.layoutbox({
        screen = s,
        buttons = keys.layoutbox_buttons,
        forced_width = dpi(30),
        forced_height = beautiful.wibar_icon_size,
    })
end

return layoutbox
