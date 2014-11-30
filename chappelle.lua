local chappelle = {}

local resources = {}
local settings  = {}

ngx.say('hello world')
--- Create server and listen on a port
-- @param port The port to listen on
function chappelle.listen(port, host)
	http.createServer(function (req, res)
		print(req.method, req.url)

		if has_handler(req.url, method) then
			print('OK')
			resources[req.url][method](req, res)
		else
			error_404(req, res)
		end
	end):listen(port)
end

local function make_resource(method)
	return function(resource_match, handler)
		if type(resources[resource_match]) ~= 'table' then
			resources[resource_match] = {}
		end

		resources[resource_match][method] = handler
	end
end

chappelle.get    = make_resource 'GET'
chappelle.post   = make_resource 'POST'
chappelle.put    = make_resource 'PUT'
chappelle.delete = make_resource 'DELETE'

local function has_handler(url, method)
	if type(resources[url])  ~= 'table' then
		return false
	end

	if type(resources[url][method]) ~= 'function' then
		return false
	end

	return true
end

local function error_404(req, res)
	res:writeHead(404, {
		["Content-Type"] = "text/plain",
		["Content-Length"] = #body
	})
	res:finish(body)
end
	
--return chappelle
