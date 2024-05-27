local infoRoute = require 'src.router.v1.info'

local V1 = {}

function V1:handler(req, res)
  local path = req:path()

  if (string.find(path, "/info")) then
    return infoRoute:load(res)
  end

end

return V1