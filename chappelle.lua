require'util'

-- module with the API
local chappelle = {}

local nginx = require('nginx')
-- parsing nginx lua http modules request and response
local req, res = nginx.parse(ngx)
-- TODO: add suport for apache's mod_lua

local application_middlewares = {}
local route_middlewares = {}

-- register a application middleware to be used, ORDER MATTERS!
function chappelle.use(middleware)
	table.insert(application_middlewares, middleware)
end

-- register a route with its handlers
function create_route(method, route, middlewares)
	table.insert(route_middlewares, {
		route       = route,      -- /uri/with/:placeholders or regexp
		middlewares = middlewares -- list of functions with (req, res, next) as signature
		method      = method      -- http method
	})
end

-- auxiliary methods
function chappelle.get(route, middlewares)
	create_route('GET', route, middlewares)
end

function chappelle.get(route, middlewares)
	create_route('POST', route, middlewares)
end

function chappelle.get(route, middlewares)
	create_route('PUT', route, middlewares)
end

function chappelle.get(route, middlewares)
	create_route('DELETE', route, middlewares)
end

--- Create server and listen on a port
-- @param port The port to listen on
--function chappelle.listen(port, host)
--	http.createServer(function (req, res)
--		print(req.method, req.url)
--
--		if has_handler(req.url, method) then
--			print('OK')
--			resources[req.url][method](req, res)
--		else
--			error_404(req, res)
--		end
--	end):listen(port)
--end
--
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
return chappelle