local metadata = require("../constants/metadata.lua")

return function (req, res)
  res.body = metadata.version.semver
  res.code = 200
  res.headers["Content-Type"] = "application/json"
end