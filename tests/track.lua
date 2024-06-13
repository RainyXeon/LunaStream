local base64 = require("base64")
local encoded =
  1 .. "#" .. base64.encode("Kero Kero Bonito - Dump")
    .. "#" .. base64.encode("Kero Kero Bonito")
    .. "#" .. 120000
    .. "#" .. base64.encode("bianGQOB0O8")
    .. "#" .. 0
    .. "#" .. base64.encode("https://www.youtube.com/watch?v=bianGQOB0O8")
    .. "#" .. 1
    .. "#" .. base64.encode("https://i3.ytimg.com/vi/bianGQOB0O8/maxresdefault.jpg")
    .. "#" .. 0
    -- .. "_" .. 1
    -- .. "_" .. base64.encode("wtf")
    .. "#" .. "youtube"
    .. "#"

local decoder = {
  track = nil,
  start = 1
}

function decoder.new(input)
  decoder.track = input
  return decoder
end

function decoder.point_index()
  local res = string.find(decoder.track, "#")
  return res
end

function decoder.read()
  local point = decoder.point_index()
  if (point == nil) then return error("Out of index") end
  local res = string.sub(decoder.track, decoder.start, point - 1)
  decoder.track = string.sub(decoder.track, point + 1 or 1, #decoder.track)
  return res
end

print("Encoded: ".. encoded)
print()
local newDec = decoder.new(encoded)
print("Decoded: ")
print("- Version                  | " .. newDec.read())
print("- Title                    | " .. base64.decode(newDec.read()))
print("- Author                   | " .. base64.decode(newDec.read()))
print("- Length                   | " .. newDec.read())
print("- Identifier               | " .. base64.decode(newDec.read()))

local isStream = "false"
if newDec.read() == "1" then isStream = "true" end
print("- Is Stream                | " .. isStream)

print("- URL                      | " .. base64.decode(newDec.read()))

local isArtwork = "false"
if newDec.read() == "1" then isArtwork = "true" end

print("- Is Artwork URL avaliable | " .. isArtwork)
if isArtwork == "true" then
print("- Artwork URL              | " .. base64.decode(newDec.read()))
end

local isISRC = "false"
if newDec.read() == "1" then isISRC = "true" end

print("- Is ISRC avaliable        | " .. isISRC)
if isISRC == "true" then
print("- ISRC                     | " .. base64.decode(newDec.read()))
end

print("- Source Name              | " .. newDec.read())