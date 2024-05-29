local json = require 'cjson'
local source_soundcloud = require 'lunastream.sources.soundcloud'
local url = require 'lunastream.utils.url'

local loadtrack = {}
local soundcloud = source_soundcloud:new()

soundcloud:init()

function loadtrack:load(req, res)
  if
    type(req.querystring) ~= "table"
    or type(req.querystring.identifier) ~= "string"
  then
    return res:statusCode(400, "identifier param not found!"):write(json.encode({
      error = "identifier param not found!"
    }))
  end

  local resolve = soundcloud:search(
    url:decode(req.querystring.identifier)
  )

  return res:write(json.encode({
    loadType = "SEARCH",
    data = resolve
  }))
end

return loadtrack