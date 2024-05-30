---@diagnostic disable: need-check-nil

local luarocks_installer = {}
local package_list = { "pegasus", "lua-cjson", "lua-curl" }
local luarocks = "luarocks"

function luarocks_installer:check()
	luarocks_installer:version_checker()
	for _, value in pairs(package_list) do
		local isExist = luarocks_installer:exists_checker(value)
		if not isExist then
			if value == "lua-curl" then
				print("[RocksChecker]: (lua-curl) is being installed..")
				os.execute(
					luarocks .. " install lua-curl CURL_INCDIR=/usr/include/x86_64-linux-gnu"
				)
			else
				luarocks_installer:install(value)
			end
		end
	end
end

function luarocks_installer:version_checker()
	local handle = io.popen("luarocks --version ")
	local result = handle:read("*a")
	handle:close()
	if result:find("3.8.0") then
		print("[RocksChecker]: LuaRocks v3.8.0 found! Skipping...")
		return
	else
		print("[RocksChecker]: LuaRocks v3.8.0 not found!")
		print("[RocksChecker]: Installing alternative...")
		os.execute("luarocks install luarocks 3.8.0-1 --tree lua_modules")
		luarocks = "./lua_modules/bin/luarocks"
		return
	end
end

function luarocks_installer:install(package)
	print("[RocksChecker]: (" .. package .. ") is being installed...")
	os.execute(luarocks .. " install " .. package .. " --tree lua_modules")
end

function luarocks_installer:exists_checker(package)
	local handle =
		io.popen(luarocks .. " show " .. package .. " --tree lua_modules")
	local result = handle:read("*a")
	handle:close()
	if #result == 0 then
		print("[RocksChecker]: (" .. package .. ") does not exist!")
		return false
	else
		print("[RocksChecker]: (" .. package .. ") exist!")
		return true
	end
end

return luarocks_installer
