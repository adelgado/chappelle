local app   = require('chappelle')
local nginx = require('connectors/nginx')
local json  = require('bodyparser')
require'util'


app.use(nginx)

app.use(json())

app.get('/', function (req, res)
	log'hit "/"'
  res.send('hello world!')
end)

app.start()

--app.listen(1234)
