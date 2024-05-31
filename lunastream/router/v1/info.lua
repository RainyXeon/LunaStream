---@diagnostic disable: undefined-global
local metadata = require"lunastream.constants.metadata"
local turbo = require("turbo")

local InfoV1Handler = class("InfoV1Handler", turbo.web.RequestHandler)
function InfoV1Handler:get()
  self:write(metadata)
end
return InfoV1Handler