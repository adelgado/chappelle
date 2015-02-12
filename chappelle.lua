require'util'


local chappelle               = {} -- table

local application_middlewares = {} -- list
local routes 								  = {} -- list

-- register a application middleware to be used, ORDER MATTERS!
function chappelle.use(middleware)
	table.insert(application_middlewares, middleware)
end

-- register a route with its handlers
local create_route = function(method, path, middlewares)
	if(type(middlewares) == 'function') then
		middlewares = {middlewares}
	end

	table.insert(routes, {
		path        = path,        -- string lik /uri/with/:placeholders or regexp
		middlewares = middlewares, -- list of functions with (req, res, next) as signature
		method      = method       -- string with http method
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
	create_route('PUT', path, middlewares)
end

function chappelle.delete(path, middlewares)
	create_route('DELETE', path, middlewares)
end

function chappelle.start()
	log'::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::'
	-- tables that will be passed to the middleware chain
	-- to compose req & res objects
	local req = {}
	local res = {}

	local middleware_chain = {} -- list

	local connector = table.remove(application_middlewares, 1)

	-- middleware that finds the right route
	-- matching request path and http method
	local match_route = function (req, res, continue)
		for _, route in ipairs(routes) do
			if route.method == req.method then
				if route.path == req.path then
					middleware_chain = table.concatenate(middleware_chain, application_middlewares)
					middleware_chain = table.concatenate(middleware_chain, route.middlewares)
					break
				else -- didnt found match
					return res.set_status(404).send()
				end
			end
		end
		continue()
	end

	middleware_chain = {connector, match_route}

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
