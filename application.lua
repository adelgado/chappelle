local routes = {}

local make_resource = function (method)
	return function (route, handler)
		if not routes[route] or type(routes[route]) ~= 'table' then
			routes[route] = {}
		end

		routes[route][method] = handler
	end
end

local start = function(port)

end

return {
	get    = make_resource 'get'
	post   = make_resource 'post'
	put    = make_resource 'put'
	delete = make_resource 'delete'
}
