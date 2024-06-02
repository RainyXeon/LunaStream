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
    return nil, "Source invalid or not avaliable"
  end
  return getSrc.search(query)
end

return {
  init = Init,
  search = Search
}