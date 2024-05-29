local infoRoute = require 'lunastream.router.v1.info'
local loadtracksRoute = require 'lunastream.router.v1.loadtracks'

local V1 = {}

function V1:handler(req, res)
  local path = req:path()

  if (string.find(path, "/info")) then
    return infoRoute:load(res)
  end

  if (string.find(path, "/loadtracks")) then
    return loadtracksRoute:load(req, res)
  end

end

return V1