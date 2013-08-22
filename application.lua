local routes = {}

-- Attaches a handler to a get request on a route
local get = function (route, handler)
	if not routes[route] or type(routes[route]) ~= 'table' then
		routes[route] = {}
	end

	routes[route]['get'] = handler
end

local start = function(port)

end

return {
	get = get
}
