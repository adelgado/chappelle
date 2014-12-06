require'util'

local chappelle = {}

local application_middlewares = {}
local route_middlewares = {}

-- register a application middleware to be used, ORDER MATTERS!
function chappelle.use(middleware)
	table.insert(application_middlewares, middleware)
end

-- register a route with its handlers
local create_route = function(method, path, middlewares)
	if(type(middlewares) == 'function') then
		middlewares = {middlewares}
	end

	table.insert(route_middlewares, {
		path        = path,       -- /uri/with/:placeholders or regexp
		middlewares = middlewares, -- list of functions with (req, res, next) as signature
		method      = method       -- http method
	})
end

-- auxiliary methods
function chappelle.get(path, middlewares)
	create_route('GET', path, middlewares)
end

function chappelle.post(path, middlewares)
	create_route('POST', path, middlewares)
end

function chappelle.put(path, middlewares)
	create_route('PUT', route, middlewares)
end

function chappelle.delete(path, middlewares)
	create_route('DELETE', path, middlewares)
end


function chappelle.listen(port)
	-- tables that will be passed to the middleware chain
	-- to compose req & res objects
	local req = {}
	local res = {}

	--match de rota
	local matched = route_middlewares[1]

	local middleware_chain = table.concatenate(application_middlewares, matched.middlewares)

	ngx.say(table.tostring(application_middlewares))
	ngx.say(table.tostring(matched.middlewares))
	ngx.say(table.tostring(middleware_chain))
	--fazer match primeiro pra dar 404 antes de comçear a parsear as coisas
	local current_middleware_index = 1

	local next = function()
		current_middleware_index = current_middleware_index + 1
		local current_middleware = middleware_chain[current_middleware_index]

		if (type(current_middleware) == nil) then
			return error('can not call "next" on last middleware of the chain')
		end

		current_middleware(req, res, next)
	end

	middleware_chain[current_middleware_index](req, res, next)
end

return chappelle
--local function make_resource(method)
--	return function(resource_match, handler)
--		if type(resources[resource_match]) ~= 'table' then
--			resources[resource_match] = {}
--		end
--
--		resources[resource_match][method] = handler
--	end
--end
--
--local function has_handler(url, method)
--	if type(resources[url])  ~= 'table' then
--		return false
--	end
--
--	if type(resources[url][method]) ~= 'function' then
--		return false
--	end
--
--	return true
--end
--
--local function error_404(req, res)
--	res:writeHead(404, {
--		["Content-Type"] = "text/plain",
--		["Content-Length"] = #body
--	})
--	res:finish(body)
--end
--	
----return chappelle
--
