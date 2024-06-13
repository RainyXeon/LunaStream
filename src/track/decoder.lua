local base64 = require("base64")

local decoder = {
  track = nil,
  start = 1
}

function decoder.new(input)
  decoder.track = input
  return decoder
end

function decoder.read()
  local point = string.find(decoder.track, "#")
  if (point == nil) then return error("Out of index") end
  local res = string.sub(decoder.track, decoder.start, point - 1)
  decoder.track = string.sub(decoder.track, point + 1 or 1, #decoder.track)
  return res
end

function decoder.version1()
  local result = {}
  result.title = base64.decode(decoder.read())
  result.author = base64.decode(decoder.read())
  result.length = tonumber(decoder.read())
  result.identifier = base64.decode(decoder.read())
  result.is_stream = false
  if decoder.read() == "1" then
    result.is_stream = true
  end
  result.url = base64.decode(decoder.read())
  result.artwork_url = nil
  if decoder.read() == "1" then
    result.artwork_url = base64.decode(decoder.read())
  end
  result.isrc = nil
  if decoder.read() == "1" then
    result.isrc = base64.decode(decoder.read())
  end
  result.source_name = decoder.read()
  return result
end

return function(input)
  if string.sub(input, 1, 1) ~= "#" then
    return nil, "Not a LunaStream encoded track"
  end
  local encoded = string.sub(input, 2, #input)
  local newDec = decoder.new(encoded)
  local version = newDec.read()
  if version == "1" then
    return decoder.version1(), nil
  else
    return nil, "Unknown track version"
  end
end