local json = require("json")

return function (req, res)
  local getEncode = req.path:match("?encodedTrack=([^%s]+)")
  if not getEncode then
    res.body = json.encode({
      error = "Missing encodedTrack field"
    })
    res.code = 400
    res.headers["Content-Type"] = "application/json"
    return
  end

  local encoded = require("../utils/url.lua").decode(getEncode)

  local result, err = require("../track/decoder.lua")(encoded)

  if err then
    res.body = json.encode({
      error = err
    })
    res.code = 400
    res.headers["Content-Type"] = "application/json"
    return
  end

  res.body = json.encode(result)
  res.code = 200
  res.headers["Content-Type"] = "application/json"
end