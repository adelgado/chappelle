local app = require '../application'

app.get('/', function (req, res)
	res:finish 'falaê, mundo!'
end)

app.post('/', function (req, res)

end)

app.start(8080)
