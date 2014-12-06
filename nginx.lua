-- middleware acting as a ngx connector
return function (req, res, next)

  local original_url = ngx.var.request_uri

  req.original_url = original_url 
  req.host         = ngx.var.host
  req.port         = ngx.var.server_port
  req.method       = ngx.req.get_method()
  req.query        = ngx.req.get_uri_args()
  req.raw_body     = ngx.req.get_body_data()
  req.headers      = ngx.req.get_headers()
  req.ip           = ngx.var.remote_addr
  req.path         = original_url:match("(.-)%?") or original_url
                    
  req.get_header = function(header)
    return req.headers[header:lower()]
  end

  res.send = ngx.print

  next()
end
