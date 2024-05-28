-- local metadata = require 'src.constants.metadata'
local json = require 'cjson'
-- local json_string = json.encode(metadata)
local source_soundcloud = require 'src.sources.soundcloud'

local loadtrack = {}
local soundcloud = source_soundcloud:new()

soundcloud:init()

function loadtrack:load(res)
  local test_resolve = soundcloud:search("the weeknd - one of the girls")
  return res:write(json.encode(test_resolve))
end

return loadtrack