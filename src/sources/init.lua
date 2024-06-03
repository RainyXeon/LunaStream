local soundcloud = require("../sources/soundcloud.lua")
local config = require("../utils/config.lua")
local avaliable = {}

function Init()
  if config.server.soundcloud then
    soundcloud.init()
    avaliable["scsearch"] = soundcloud
  end
end

function Search(query, source)
  local getSrc = avaliable[source]
  if not getSrc then
    return {
			loadType = "error",
			tracks = {},
			message = "Source invalid or not avaliable"
		}
  end
  return getSrc.search(query)
end

function LoadForm(link)
  for _, src in pairs(avaliable) do
    local isLinkMatch = src.isLinkMatch(link)
    if isLinkMatch then return src.loadForm(link) end
  end
  return {
    loadType = "error",
    tracks = {},
    message = "Link invalid or not avaliable"
  }
end

return {
  init = Init,
  search = Search,
  loadForm = LoadForm
}