local app   = require('chappelle')
local nginx = require('connectors/nginx')
local json  = require('bodyparser')

app.use(nginx)

local m1 = function(req, res, continue)
  res.send('I am middleware1!\n')
  continue()
end

local m2 = function(req, res, continue)
  res.send('I am middleware2!\n')
  continue()
end

local m3 = function(req, res, continue)
  res.send('I am middleware3!\n')
  continue()
end

local m4 = function(req, res, continue)
  res.finish('I am middleware4!\n')
end

app.use(m1)

app.get('/teste', {m2, m3, m4})

app.start()

--app.listen(1234)
