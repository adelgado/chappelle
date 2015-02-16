require'util'

-- middleware acting as a ngx connector
return function (req, res, continue)
  -- TODO: Create interface for reference when building new connector
  log'is using {nginx} as connector'

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

  res.send = ngx.print

  res.finish = function(payload)
    if payload then
       res.send(payload)     
    end
    ngx.flush(true)
  end

  req.get_header = function(header)
    return req.headers[header:lower()]
  end

  res.set_status = function(status)
    ngx.status = status
    return res
  end

  continue()
end
