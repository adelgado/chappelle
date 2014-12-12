require'util'

-- middleware acting as a ngx connector
return function (req, res, done)
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

  res.send   = ngx.print

  res.finish = function(body)
    -- status = res.status() or 500
    -- headers = self.get_all_headers()
    -- ngx.res.set_headers()
    -- ngx.res.status = status
    -- body = body  or res.body()
    ngx.print(body)
    ngx.flush()
  end

  done()
end
