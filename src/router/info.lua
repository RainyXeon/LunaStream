local metadata = require("src.constants.metadata")
local json = require("deps.json")

return function (req, res)
  res.body = json.encode(metadata)
  res.code = 200
  res.headers["Content-Type"] = "application/json"
end