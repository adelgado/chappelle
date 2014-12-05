local M = {}

-- options: bodyMaxSize etc
-- decode: function to decode the json, if none provided will try to use cjson
function bodyparser.json(options, decode)
  _decode = decode or require('cjson').decode
  return function (req, res, next)
    req.body = _decode(req.raw_body)
    return next()
  end
end

return M