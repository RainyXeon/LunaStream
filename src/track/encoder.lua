local base64 = require("base64")
local required = {
  "title",
  "author",
  "length",
  "identifier",
  "is_stream",
  "uri"
}

return function (data)
  for _, value in pairs(required) do
    if data[value] == nil then
      return nil, "Missing field: " .. value
    end
  end

  local encoded = "#1"
  encoded = encoded .. "#" .. base64.encode(data.title)
  encoded = encoded .. "#" .. base64.encode(data.author)
  encoded = encoded .. "#" .. data.length
  encoded = encoded .. "#" .. base64.encode(data.identifier)
  if data.is_stream then
    encoded = encoded .. "#" .. "1"
  else
    encoded = encoded .. "#" .. "0"
  end
  encoded = encoded .. "#" .. base64.encode(data.uri)
  if data.artwork_url then
    encoded = encoded .. "#" .. "1"
    encoded = encoded .. "#" .. base64.encode(data.artwork_url)
  else
    encoded = encoded .. "#" .. "0"
  end
  if data.isrc then
    encoded = encoded .. "#" .. "1"
    encoded = encoded .. "#" .. base64.encode(data.isrc)
  else
    encoded = encoded .. "#" .. "0"
  end

  encoded = encoded .. "#"

  return encoded, nil
end