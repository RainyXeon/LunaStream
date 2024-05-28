local json = require 'cjson'
local source_soundcloud = require 'src.sources.soundcloud'

local loadtrack = {}
local soundcloud = source_soundcloud:new()

soundcloud:init()

function loadtrack:load(res)
  local resolve = soundcloud:search("the weeknd - one of the girls")
  return res:write(json.encode({
    loadType = "SEARCH",
    data = resolve
  }))
end

return loadtrack