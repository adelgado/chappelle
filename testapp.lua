-- TODO Make it into a table
require'util'

local chappelle = require('chappelle')
local nginx     = require('./connectors/nginx')

local app = chappelle()

app.use(nginx)

app.use(function (req, res, done)
	done()
end)

app.get('/', function (req, res)
	-- res.status(420).finish('hello world')
	res.finish('hello world')
end)

app.start()
