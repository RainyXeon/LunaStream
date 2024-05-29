local config = require 'lunastream.utils.readconfig'
local routerv1 = require 'lunastream.router.v1.init'
local Router = {}

function Router:handler(req, res)
  local path = req:path()
  local headers = req:headers()
  if
    not headers.authorization
    or headers.authorization ~= config.server.password
  then
    return res:statusCode(403, "Unauthorized"):write("Unauthorized")
  end

  if (string.find(path, "/v1")) then
    return routerv1.handler({}, req, res)
  end
end

return Router