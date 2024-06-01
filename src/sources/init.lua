local soundcloud = require("../sources/soundcloud.lua")

function Init()
  soundcloud.init()
end

function Search(query, source)
  if source == "scsearch" then
    return soundcloud.search(query)
  else return nil, "Source invalid" end
end

return {
  init = Init,
  search = Search
}