local app = require '../chappelle'

app.get('/', function (req, res)
	res:finish('hello world')
end)

app.start()
