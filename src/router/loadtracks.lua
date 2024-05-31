local metadata = require("../constants/metadata.lua")
local json = require("json")
local soundcloud = require("../sources/soundcloud.lua")
local url = require("../utils/url.lua")
soundcloud:init()

return function (req, res)
  local getIdentifier = req.path:match("?identifier=([^%s]+)")
  if not getIdentifier then
    res.body = json.encode({
      error = "Missing identifier"
    })
    res.code = 400
    res.headers["Content-Type"] = "application/json"
    return
  end
  local getQuery = getIdentifier:match("([^%s]+):([^%s]+)")
  if not getQuery then
    res.body = json.encode({
      error = "Identifier not in required form like source:query"
    })
    res.code = 400
    res.headers["Content-Type"] = "application/json"
    return
  end
  res.body = json.encode(metadata)
  res.code = 200
  res.headers["Content-Type"] = "application/json"
end