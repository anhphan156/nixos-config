local wibox = require('wibox')
local awful = require('awful')
local beautiful = require('beautiful')
local naughty = require('naughty')
local liblua_pam = require("liblua_pam")

local temp = wibox.widget.textbox()

local lockscreen = wibox {
    ontop = true,
    type = 'splash',
    visible = false,
    screen = screen.primary,
    bg = beautiful.invisible,
    widget = {
        temp,
        widget = wibox.container.place
    }
}

awful.placement.maximize(lockscreen)

local dummy_textbox = wibox.widget.textbox()
local get_passwd = function()
    awful.prompt.run {
        exe_callback = function(input) 
            local auth = liblua_pam.auth_current_user(input)
            if auth then
                lockscreen.visible = false
            else
                temp.text = "false"
            end
        end,
        textbox = dummy_textbox
    }
end

awesome.connect_signal('lockscreen::toggle', function() 
    lockscreen.visible = not lockscreen.visible
end)

awesome.connect_signal('lockscreen::lock', function() 
    lockscreen.visible = true
    get_passwd()
end)
