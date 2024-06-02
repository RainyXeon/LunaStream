local fs = require("fs")
local json = require("json")
local file = fs.readFileSync('./config.json', 'utf8')
local default = require('../constants/default.lua')
if not file then file = "{}" end
local decoded = json.decode(file)

local function merge_default(def, given)
  if type(given) == "nil" then return def end
  local defaultKeys = Get_keys(def);
  local givenKey = Get_keys(given);

  for _, gkey in pairs(givenKey) do
    local currIndex = IndexOf(defaultKeys, gkey)
    if type(defaultKeys[currIndex]) == "nil" then
      given[gkey] = nil
    end
  end

  for _, dkey in pairs(defaultKeys) do
    if type(given[dkey]) == "nil" then given[dkey] = def[dkey] end
    if type(given[dkey]) == "table" then
      merge_default(def[dkey], given[dkey])
    end
    if type(given[dkey]) ~= type(def[dkey]) then
      given[dkey] = def[dkey]
    end
  end

  return given
end

-- Return the first index with the given value (or nil if not found).
function IndexOf(array, value)
  for i, v in ipairs(array) do
    if v == value then
      return i
    end
  end
  return nil
end

function Get_keys(tab)
  local keyset = {}
  local n = 0;

  for k in pairs(tab) do
    n = n + 1
    keyset[n]=k
  end
  return keyset
end

return merge_default(default, decoded or {})