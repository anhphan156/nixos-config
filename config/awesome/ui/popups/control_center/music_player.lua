local wibox = require('wibox')
local awful = require('awful')
local button_maker = require('ui.components.button_maker')
local beautiful = require('beautiful')
local naughty = require('naughty')

local icon_size = dpi(60)

local is_playing = false

local title_text = wibox.widget.textbox()
title_text.font = '14'
title_text.markup = 'Not Playing'
title_text.forced_width = dpi(300)
title_text.forced_height = dpi(20)
title_text.halign = 'center'

local check_is_playing = function()
    awful.spawn.easy_async_with_shell('mpc status "%state%"', function(stdout)
        if stdout:gsub('\n','') == 'paused' then
            is_playing = false
            title_text.markup = '<span foreground=\'' .. beautiful.text_white_color .. '\'><i>Not Playing</i></span>'
        else
            is_playing = true
        end
    end)
end

local set_title = function()
    awful.spawn.easy_async_with_shell('mpc --format "%title% by %artist%" current', function(stdout)
        title_text.markup = '<span foreground=\'' .. beautiful.text_white_color .. '\'><i>' .. stdout .. '</i></span>'
    end)
end

local toggle = function()
    if not is_playing
    then 
        awful.spawn.with_shell('mpc play')
        is_playing = true
        set_title()
    else
        awful.spawn.with_shell('mpc pause')
        is_playing = false
        title_text.markup = '<span foreground=\'' .. beautiful.text_white_color .. '\'><i>Not Playing</i></span>'
    end
end

local next = function()
    awful.spawn.with_shell('mpc next')
    set_title()
end

local prev = function()
    awful.spawn.with_shell('mpc prev')
    set_title()
end

local song_repeat = function()
    awful.spawn.with_shell('mpc repeat')
    set_title()
end

local random = function()
    awful.spawn.with_shell('mpc random')
    set_title()
end

local music_player = wibox.widget{
    {
        {
            title_text,
            widget = wibox.container.place
        },
        {
            button_maker.icon_button(
                beautiful.repeat_icon,
                dpi(0),
                icon_size,
                icon_size,
                song_repeat
            ),
            button_maker.icon_button(
                beautiful.prev_icon,
                dpi(0),
                icon_size,
                icon_size,
                prev
            ),
            button_maker.icon_button(
                beautiful.play_icon,
                dpi(0),
                icon_size,
                icon_size,
                toggle
            ),
            button_maker.icon_button(
                beautiful.next_icon,
                dpi(0),
                icon_size,
                icon_size,
                next
            ),
            button_maker.icon_button(
                beautiful.shuffle_icon,
                dpi(0),
                icon_size,
                icon_size,
                random
            ),
            layout = wibox.layout.fixed.horizontal,
            spacing = dpi(10)
        },
        layout = wibox.layout.fixed.vertical
    },
    widget = wibox.container.place
}

awesome.connect_signal('music_player::set_title', function() 
    set_title()
    check_is_playing()
end)

return music_player
