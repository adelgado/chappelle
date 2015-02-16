local M = {}

require'util'

local routes = require('routes')

local application_middlewares = {} -- list

-- register a application middleware, ORDER MATTERS!
function M.use(middleware)
	table.insert(application_middlewares, middleware)
end

-- auxiliary methods
function M.get(path, middlewares)
	routes.create('GET', path, middlewares)
end

function M.post(path, middlewares)
	routes.create('POST', path, middlewares)
end

function M.put(path, middlewares)
	routes.create('PUT', path, middlewares)
end

function M.delete(path, middlewares)
	routes.create('DELETE', path, middlewares)
end

-- starts the request lifecycle
function M.start()
	log'::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::'

	-- list that will hold all middlewares for a
	-- given request. It will be composed with 
	-- application middlewares and route_middlewares
	local request_chain = {}

	-- the connector middleware should always
	-- be the first of the request chain
	local connector = table.remove(application_middlewares, 1)

	-- middleware that finds the right route,
	-- matching request path and http method
	-- against the registered routes
	local build_route = function (req, res, continue)
		local matched_route = routes.match(req.method, req.path)
		if matched_route then
			request_chain = table.concatenate(request_chain, application_middlewares)
			request_chain = table.concatenate(request_chain, matched_route.middlewares)
		else -- didnt found match
			return res.set_status(404).send()
		end
		continue()
	end

	-- initial middlewares that will build the rest of the request chain
	request_chain = {connector, build_route}

	-- tables that will be passed to the request chain
	-- of middlewars to compose req & res objects
	local req = {}
	local res = {}

	local current_middleware_index = 0

	-- function that will consume asynchronously 
	-- the middlewares of the request chain
	local function continue()
		current_middleware_index = current_middleware_index + 1
		local current_middleware = request_chain[current_middleware_index]

		if type(current_middleware) == 'nil' then
			return error('can not call "continue" on last middleware of the chain')
		end

		current_middleware(req, res, continue)
	end

	continue()
end

return M
