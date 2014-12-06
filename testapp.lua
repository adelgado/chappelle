local app   = require('chappelle')
local nginx = require('nginx')
local json  = require('bodyparser')

app.use(nginx)

app.use(json())

app.get('/', function (req, res)
  res.send(req.raw_body)
end)

app.listen()

--app.listen(1234)
