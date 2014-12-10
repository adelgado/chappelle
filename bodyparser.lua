require'util'
local decode = require('cjson').decode

-- options: bodyMaxSize etc
return function (options)
	return function (req, res, done)
		log('bodyparser')
		local content_type = req.get_header('Content-Type')

		if(content_type == 'application/json') then
			req.body = decode(req.raw_body)
		end

		done()
	end
end
