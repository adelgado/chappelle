local u = require'util'
local resources = {}
local settings  = {}
local chappelle = {}

local function has_handler()
	return false
end

local start = function ()
	raw_header = ngx.req.raw_header()
	first_line = string.match(raw_header, '^(.-)\n')
	method = ngx.req.get_method()

	matcher = method .. ' /(.-) HTTP'

	url = string.match(first_line, matcher)

	if url then
		ngx.print(url)
		if has_handler(url, method) then
			ngx.print('OK')
			resources[req.url][method](req, res)
		else
			ngx.print('404')
		end
	end
end

-- local function has_handler(url, method)
-- 	if type(resources[url])  ~= 'table' then
-- 		return false
-- 	end

-- 	if type(resources[url][method]) ~= 'function' then
-- 		return false
-- 	end

-- 	return true
-- end

-- local function make_resource(method)
-- 	return function(resource_match, handler)
-- 		if type(resources[resource_match]) ~= 'table' then
-- 			resources[resource_match] = {}
-- 		end

-- 		resources[resource_match][method] = handler
-- 	end
-- end

-- chappelle.get    = make_resource 'GET'
-- chappelle.post   = make_resource 'POST'
-- chappelle.put    = make_resource 'PUT'
-- chappelle.delete = make_resource 'DELETE'

-- local function error_404(req, res)
-- 	res:writeHead(404, {
-- 		["Content-Type"] = "text/plain",
-- 		["Content-Length"] = #body
-- 	})
-- 	res:finish(body)
-- end

start()
