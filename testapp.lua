local app   = require('chappelle')
local json  = require('bodyparser')
require'util'

local chappelle = require('chappelle')
local nginx     = require('./connectors/nginx')

app.use(nginx)

app.use(json())

app.get('/', function (req, res)
	log'socorramme estou numa rota'
	log(req)
  res.send(req.raw_body)
end)

app.listen()

--app.listen(1234)
