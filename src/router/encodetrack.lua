local json = require("json")

return function (req, res)
  if req.headers["Content-Type"] ~= "application/json" then
    res.body = json.encode({
      error = "Missing body"
    })
    res.code = 400
    res.headers["Content-Type"] = "application/json"
    return
  end

  if not req.body then
    res.body = json.encode({
      error = "Missing body"
    })
    res.code = 400
    res.headers["Content-Type"] = "application/json"
    return
  end
  local result, err = require("../track/encoder.lua")(
    json.decode(req.body)
  )

  if err then
    res.body = json.encode({
      error = err
    })
    res.code = 400
    res.headers["Content-Type"] = "application/json"
    return
  end

  res.body = result
  res.code = 200
  res.headers["Content-Type"] = "text/plain"
end