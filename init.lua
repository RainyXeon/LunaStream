local pegasus = require 'pegasus'
local router = require 'router.init'
local config = require 'config'

local server = pegasus:new({ 
  port=config.server.port 
})

server:start(function (req, res)
  local path = req:path()

  -- Health checker / Test router
  if path == "/catgirls" then 
    return res:write("Wtf bro 💀") 
  end

  -- Main router handler
  return router:handler(req, res)
end)