local versionRoute = require 'router.v1.version'

local V1 = {}

function V1:handler(req, res) 
  local path = req:path()
  
  if (string.find(path, "/version")) then
    return versionRoute:load(res)
  end

end

return V1