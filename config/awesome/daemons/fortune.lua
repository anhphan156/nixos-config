local awful = require('awful')

local script = [[
    bash -c "fortune -n 100 -s" 
]]

awful.widget.watch(script, 180, function(widget, stdout)
    awesome.emit_signal('daemon::fortune', stdout:gsub('\n', '')) 
end)
