require"lunastream.preinstaller.init"
local pegasus = require"pegasus"
local router = require"lunastream.router.init"
local metadata = require"lunastream.constants.metadata"
local config = require"lunastream.utils.readconfig"

local server = pegasus:new({ port = config.server.port })

server:start(function(req, res)
	local path = req:path()

	-- Version router
	if path == "/version" then
		return res:write(metadata.version.semver)
	end

	-- Main router handler
	return router:handler(req, res)
end)
