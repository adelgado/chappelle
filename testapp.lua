local app   = require('chappelle')
local nginx = require('nginx')
local json  = require('bodyparser')
require'util'

app.use(nginx)

app.use(json())

app.get('/', function (req, res)
	log'socorramme estou numa rota'
	log(req)
  res.send(req.raw_body)
end)

app.listen()

--app.listen(1234)
