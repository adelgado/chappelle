local http = require'http'

local resources = {}

local make_resource = function(method)
	return function(resource_match, handler)
		if type(resources[resource_match]) ~= 'table' then
			resources[resource_match] = {}
		end

		resources[resource_match][method] = handler
	end
end

local has_handler = function(url, method)
	if type(resources[url])  ~= 'table' then
		return false
	end

	if type(resources[url][method]) ~= 'function' then
		return false
	end

	return true
end

local error_404 = function(req, res)
	local body = '404 Not Found'

	print(body)

	res:writeHead(404, {
		["Content-Type"] = "text/plain",
		["Content-Length"] = #body
	})
	res:finish(body)
end
	

local start = function(port)
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

return { get    = make_resource 'GET'
       , post   = make_resource 'POST'
       , put    = make_resource 'PUT'
       , delete = make_resource 'DELETE'
       , start  = start
   	   }
