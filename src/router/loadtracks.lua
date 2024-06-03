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
  local isLink = getIdentifier:find("https://") or getIdentifier:find("http://")

  if (
    not getQuery
    and not isLink
    and not getQuerySource
  ) then
    res.body = json.encode({
      error = "Identifier not in required form like source:query or not a link"
    })
    res.code = 400
    res.headers["Content-Type"] = "application/json"
    return
  end

  local search_res = nil

  if isLink then
    search_res = source.loadForm(getIdentifier)
  else
    search_res = source.search(getQuery, getQuerySource)
  end

  if search_res and search_res.loadType == "error" then
    res.body = json.encode(search_res)
    res.code = 400
    res.headers["Content-Type"] = "application/json"
    return
  end

  res.body = json.encode(search_res)
  res.code = 200
  res.headers["Content-Type"] = "application/json"
end