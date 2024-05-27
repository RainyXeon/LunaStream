local metadata = require 'metadata'
local json = require 'cjson'
local json_string = json.encode(metadata)

local versionRoute = {}

function versionRoute:load(res) 
  return res:write(json_string)
end

return versionRoute