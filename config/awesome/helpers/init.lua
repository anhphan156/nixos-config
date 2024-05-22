local awful = require('awful')

local helpers = {}

helpers.minimize_all_clients = function(b)
	for c in awful.client.iterate(function() return true end) do
		c.minimized = b
	end
end

return helpers
