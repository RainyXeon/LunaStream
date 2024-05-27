local pegasus = require 'pegasus'
local router = require 'src.router.init'
local metadata = require 'src.constants.metadata'
local config = require 'src.utils.readconfig'

local server = pegasus:new({
  port=config.server.port
})

server:start(function (req, res)
  local path = req:path()

  -- Version router
  if path == "/version" then
    return res:write(metadata.version.semver)
  end

  -- Main router handler
  return router:handler(req, res)
end)