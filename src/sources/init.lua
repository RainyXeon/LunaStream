local soundcloud = require("../sources/soundcloud.lua")
local avaliable = {}

function Init()
  soundcloud.init()
  avaliable["scsearch"] = soundcloud
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