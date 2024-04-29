local awful = require('awful')

local script = [[
    bash -c "uptime -p"
]]

awful.widget.watch(script, 60, function(widget, stdout)
    awesome.emit_signal('daemon::uptime', stdout:gsub('\n',''))
end)
