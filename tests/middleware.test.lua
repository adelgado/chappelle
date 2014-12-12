chappelle = require'../chappelle'

setup(function ()
	chappelle.use(function (req, res, done)
		if not res.body then
			res.body = req.body .. "1"
		end
	end)
	chappelle.use(function (req, res, done)
		if not res.body then
			res.body = req.body .. "2"
		end
	end)
	chappelle.use(function (req, res, done)
		if not res.body then
			res.body = req.body .. "3"
		end
	end)

	chappelle.
end)

describe('Application middlewares', function()
	it('should be called in order', function()


	end)
end)
