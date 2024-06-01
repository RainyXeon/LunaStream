local metadata = require("../constants/metadata.lua")
local json = require("json")

return function (req, res)
  res.body = json.encode(metadata)
  res.code = 200
  res.headers["Content-Type"] = "application/json"
end