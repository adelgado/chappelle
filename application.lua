local resources = {}

local make_resource = function (method)
	return function (resource_match, handler)
		if type(resources[resource_match]) ~= 'table' then
			routes[resource_match] = {}
		end

		routes[resource_match][method] = handler
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
