---@diagnostic disable: undefined-global
-- require("lunastream.utils.setpath")
-- require("lunastream.preinstaller.init")
local turbo = require("turbo")
local metadata = require("lunastream.constants.metadata")
local config = require("lunastream.utils.readconfig")
local router = require("lunastream.router.init")

local VersionHandler = class("VersionHandler", turbo.web.RequestHandler)
function VersionHandler:get()
  self:write(metadata.version.semver)
end

for _, v in pairs(router) do 
	table.insert({"/version", VersionHandler}, v)
end

local app = turbo.web.Application:new(router)

app:listen(config.server.port)
print("[main] Now started at port: " .. config.server.port)
turbo.ioloop.instance():start()
