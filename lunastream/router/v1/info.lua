local metadata = require 'lunastream.constants.metadata'
local json = require 'cjson'
local json_string = json.encode(metadata)

local infoRoute = {}

function infoRoute:load(res)
  return res:write(json_string)
end

return infoRoute