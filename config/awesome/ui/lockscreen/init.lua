local wibox = require('wibox')
local awful = require('awful')
local beautiful = require('beautiful')
local naughty = require('naughty')
local liblua_pam = require("liblua_pam")

local lockscreen = wibox {
    ontop = true,
    type = 'splash',
    visible = false,
    screen = screen.primary,
    bg = beautiful.invisible,
    widget = {
        {
            widget = wibox.widget.textbox,
            font = "icomoon 150",
            markup = "<span foreground='#ee3333'></span>"
        },
        widget = wibox.container.place
    }
}

awful.placement.maximize(lockscreen)

local function get_passwd()
    awful.prompt.run {
        hooks = {
            {{ }, 'Escape', function() 
                get_passwd()
            end}
        },
        exe_callback = function(input) 
            local auth = liblua_pam.auth_current_user(input)
            if auth then
                lockscreen.visible = false
            else
                get_passwd()
            end
        end,
        textbox = wibox.widget.textbox()
    }
end

awesome.connect_signal('lockscreen::lock', function() 
    lockscreen.visible = true
    get_passwd()
end)
