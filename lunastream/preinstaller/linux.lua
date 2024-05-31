---@diagnostic disable: need-check-nil

local linux_installer = {}

function linux_installer:check()
	local nonexists = ""

	local isLuarocksExist =
		linux_installer:exists_checker("luarocks", "luarocks")
	if not isLuarocksExist then
		nonexists = "luarocks=3.8.0+dfsg1-1 " .. nonexists
	end

	local isCurlExist =
		linux_installer:exists_checker("libcurl4-nss-dev", "(NSS flavour)")
	if not isCurlExist then
		nonexists = "libcurl4-nss-dev " .. nonexists
	end

	if (nonexists:len() > 0) then
		linux_installer:install(nonexists)
	end
end

function linux_installer:exists_checker(program, supposed)
	local handle = io.popen("dpkg -l | grep " .. program)
	local result = handle:read("*a")
	handle:close()
	if not result:find(supposed) then
		print("[LibInstaller] (" .. program .. ") does not exist!")
		return false
	else
		print("[LibInstaller] (" .. program .. ") exist!")
		return true
	end
end

function linux_installer:install(list)
	print("[LibInstaller] Perform installing some missing program...")
	os.execute("sudo apt install " .. list)
end

return linux_installer
