local json = require 'cjson'

local file = io.open("config.json", "r")
local myTable = {}

if file then
  -- read all contents of file into a string
  local contents = file:read("*a")
  myTable = json.decode(contents);
  io.close(file)
else
  error("config.json file not found!", 1)
end

return myTable