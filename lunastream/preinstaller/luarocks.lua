---@diagnostic disable: need-check-nil

local luarocks_installer = {}
local package_list = { "pegasus", "lua-cjson", "lua-curl" }

function luarocks_installer:check()
	for _, value in pairs(package_list) do
		local isExist = luarocks_installer:exists_checker(value)
		if not isExist then
			if value == "lua-curl" then
				print("[RocksChecker]: (lua-curl) is being installed..")
				os.execute(
					"sudo luarocks install lua-curl CURL_INCDIR=/usr/include/x86_64-linux-gnu"
				)
			else
				luarocks_installer:install(value)
			end
		end
	end
end

function luarocks_installer:install(package)
	print("[RocksChecker]: (" .. package .. ") is being installed..")
	os.execute("sudo luarocks install " .. package .. " --tree lua_modules")
end

function luarocks_installer:exists_checker(package)
	local handle = io.popen("sudo luarocks show " .. package)
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
