require'util'

log':::::::::::::::::::::::::::::::::::::'
log'has {started}'
local chappelle = {}

local application_middlewares = {}
local route_middlewares = {}


local match_route = function (req, res, continue)
	for i, v in ipairs(route_middlewares) do
		if v.method == req.method then
			if v.path == req.path then
				return v
			end
		end
	end
end

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


function chappelle.start()
	-- tables that will be passed to the middleware chain
	-- to compose req & res objects
	local req = {}
	local res = {}

	--match de rota
	local matched = route_middlewares[1]

	local middleware_chain = table.concatenate(application_middlewares, matched.middlewares)

	local current_middleware_index = 0

	local function continue()
		current_middleware_index = current_middleware_index + 1
		local current_middleware = middleware_chain[current_middleware_index]

		if type(current_middleware) == 'nil' then
			return error('can not call "continue" on last middleware of the chain')
		end

		current_middleware(req, res, continue)
	end

	continue()
end

return chappelle
