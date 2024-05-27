local metadata = require 'src.constants.metadata'
local json = require 'cjson'
local json_string = json.encode(metadata)

local loadtrack = {}

function loadtrack:load(res)
  return res:write(json_string)
end

return loadtrack