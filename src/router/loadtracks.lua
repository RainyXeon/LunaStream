local json = require("json")
local source = require("../sources/init.lua")
source.init()

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

  local getQuerySource = getIdentifier:match("([^%s]+):[^%s]+")
  local getQuery = getIdentifier:match("[^%s]+:([^%s]+)")
  -- local isLink = getIdentifier:find("https://") or getIdentifier:find("http://")

  if (
    not getQuery
    -- and not isLink
    and not getQuerySource
  ) then
    res.body = json.encode({
      error = "Identifier not in required form like source:query or not a link"
    })
    res.code = 400
    res.headers["Content-Type"] = "application/json"
    return
  end

  local results, err = source.search(getQuery, getQuerySource)

  if err then
    res.body = json.encode({
      loadType = "error",
      tracks = {},
      reason = err
    })
    res.code = 400
    res.headers["Content-Type"] = "application/json"
    return
  end

  res.body = json.encode({
    loadType = "search",
    tracks = results
  })
  res.code = 200
  res.headers["Content-Type"] = "application/json"
end