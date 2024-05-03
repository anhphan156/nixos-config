local awful = require('awful')

local script = [[
    bash -c "echo uptime"
]]

awful.widget.watch(script, 60, function(widget, stdout)
    awesome.emit_signal('daemon::uptime', stdout:gsub('\n',''))
end)
