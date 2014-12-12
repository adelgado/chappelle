local res = {}

function res.status(status)
	res.status = status

	return res
end

function res.add_header(name, content)
	res.headers[name] = content

	return res
end

return res
