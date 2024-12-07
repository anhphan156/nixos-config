local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local wibox = require("wibox")
local keys = require("key_mapping.keys")

local song_title = wibox.widget.textbox()
song_title.font = 'Anka/Coder 16'
song_title.markup = '<span foreground = "' .. beautiful.text_red_color .. '"><b>It\'s a perfect day for music</b></span>'

local mpd_titlebar_init = function(c)
  local top_bar_config = {
    position = "top",
    size = dpi(50)
  }
  local left_bar_config = {
    position = "left",
    bg_normal = '#000000',
    bg_focus = '#000000',
    bg_urgent = '#000000',
  }

  awful.titlebar(c, top_bar_config):setup({
    {
      {
        {
          {
            buttons = keys.titlebar_icon_buttons(c),
            widget = wibox.widget.textbox,
            markup = '<span foreground = "' .. beautiful.text_red_color .. '"><b> </b></span>',
          },
          margins = {
            top = dpi(0),
            right = dpi(0),
            bottom = dpi(10),
            left = dpi(0),
          },
          widget = wibox.container.margin,
        },
        {
          widget = song_title
        },
        {
          buttons = keys.titlebar_icon_buttons(c),
          widget = wibox.widget.textbox,
          font = "Anka/Coder 35",
          markup = '<span foreground = "' .. beautiful.text_red_color .. '"><b>♫ </b></span>',
        },
        layout = wibox.layout.align.horizontal,
        expand = "none"
      },
      margins = {
        top = dpi(10),
        right = dpi(0),
        bottom = dpi(0),
        left = dpi(7),
      },
      widget = wibox.container.margin,
    },
    widget = wibox.container.background,
    bg = '#000000'
  })
  awful.titlebar(c, left_bar_config):setup({
    {
      {
        widget = wibox.widget.textbox,
      },
      {
        widget = wibox.widget.textbox,
      },
      {
        {
          awful.titlebar.widget.minimizebutton(c),
          awful.titlebar.widget.maximizedbutton(c),
          awful.titlebar.widget.closebutton(c),
          spacing = dpi(5),
          layout = wibox.layout.fixed.vertical(),
        },
        margins = dpi(5),
        widget = wibox.container.margin,
      },
      layout = wibox.layout.align.vertical,
      expand = "none"
    },
    widget = wibox.container.background,
    shape = function(cr, width, height)
      gears.shape.partially_rounded_rect(cr, width, height, false, true, false, true, 14)
    end,
    bg = '#222222',
  })
end

awesome.connect_signal('ncmpcpp::songchanged', function(title)
  song_title.markup = '<span foreground = "' .. beautiful.text_red_color .. '"><b>' .. title .. '</b></span>'
end)

return mpd_titlebar_init
