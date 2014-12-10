require'util'

local chappelle = {}

local application_middlewares = {}
local route_middlewares = {}

-- register a application middleware to be used, ORDER MATTERS!
function chappelle.use(middleware)
	print(middleware)
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

	log('application_middlewares')
	log(application_middlewares)

	log'middleware chain'
	log(middleware_chain)

	log(#middleware_chain)

	-- Antes de qualquer lógica de ver se o match existe a boa é dar um 404 pra não gastar processamento
	-- fazer match primeiro pra dar 404 antes de começar a parsear as coisas
	local current_middleware_index = 1

	local done2 = function()
		current_middleware_index = current_middleware_index + 1
		log'should be 2'
		log(current_middleware_index)
		local current_middleware = middleware_chain[current_middleware_index]
		log'should be function'
		log(type(current_middleware))

		if type(current_middleware) == "nil" then
			return error('can not call "next" on last middleware of the chain')
		end

		-- current_middleware(req, res, done)
	end

	local done = function()
		current_middleware_index = current_middleware_index + 1
		log'should be 2'
		log(current_middleware_index)
		local current_middleware = middleware_chain[current_middleware_index]
		log'should be function'
		log(type(current_middleware))

		if type(current_middleware) == "nil" then
			return error('can not call "next" on last middleware of the chain')
		end

		current_middleware(req, res, done)
	end

	log'should be a function'
	log(type(middleware_chain[current_middleware_index]))

	middleware_chain[current_middleware_index](req, res, done)
end

return chappelle
