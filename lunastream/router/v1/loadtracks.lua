---@diagnostic disable: undefined-global
local source_soundcloud = require"lunastream.sources.soundcloud"
local soundcloud = source_soundcloud:new()
soundcloud:init()

local turbo = require("turbo")
local LoadTracksV1Handler = class("LoadTracksV1Handler", turbo.web.RequestHandler)

function LoadTracksV1Handler:get()
	local resolve = soundcloud:search("MGMT - Little Dark Age")
	self:write({
		loadType = "SEARCH",
		-- data = resolve,
	})
end
return LoadTracksV1Handler