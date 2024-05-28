local curl = require "cURL"
local http = {}

function http:request(url)
  local t = {}
  local handle = curl.easy{
    url = url,
    writefunction = function (str)
      DataString = str
    end
  }
  handle:setopt_writefunction(table.insert, t)
  handle:perform()
  return table.concat(t)
end

-- local data = http:request("https://a-v2.sndcdn.com/assets/0-a901c1e0.js")

-- print(data)

return http