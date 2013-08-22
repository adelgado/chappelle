local app = require '../application'

app.get('/', function (req, res)
	res.send 'falaê, mundo!'
end)

app.start(8080)
