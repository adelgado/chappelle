-- a "Connector????" for nginx lua http module
local M = {}

function M.parse(nginx)
  local req = {}
  local res = {}

  req.method   = nginx.req.get_method()
  req.query    = nginx.req.get_uri_args()
  req.raw_body = nginx.req.get_body_data()
  req.headers  = nginx.req.get_headers()

  req.get_header = function(header)
    return req.headers[header:lower()]
  end

  return req, res
end

return M