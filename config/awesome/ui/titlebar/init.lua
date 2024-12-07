local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local keys = require("key_mapping.keys")

local titlebar_init = function(c)
  awful.titlebar(c, { position = "left" }):setup({
    {
      {
        awful.titlebar.widget.closebutton(c),
        awful.titlebar.widget.maximizedbutton(c),
        awful.titlebar.widget.minimizebutton(c),
        spacing = dpi(5),
        layout = wibox.layout.fixed.vertical(),
      },
      margins = dpi(5),
      widget = wibox.container.margin,
    },
    {
      spacing = 0,
      spacing_widget = wibox.widget.separator,
      layout = wibox.layout.flex.vertical,
    },
    {
      {
        -- awful.titlebar.widget.iconwidget(c),
        buttons = keys.titlebar_icon_buttons(c),
        widget = wibox.widget.textbox,
        markup = '<span foreground = "' .. beautiful.text_red_color .. '"><b></b></span>',
      },
      margins = {
        top = dpi(0),
        right = dpi(0),
        bottom = dpi(10),
        left = dpi(10),
      },
      widget = wibox.container.margin,
    },
    layout = wibox.layout.align.vertical,
  })
end

return titlebar_init
