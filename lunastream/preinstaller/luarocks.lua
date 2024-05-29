---@diagnostic disable: need-check-nil

local luarocks_installer = {}
local package_list = {
  "pegasus",
  "lua-cjson",
  "luastatic",
  "lua-curl"
}

function luarocks_installer:check()

end

function luarocks_installer:install()

end

return luarocks_installer