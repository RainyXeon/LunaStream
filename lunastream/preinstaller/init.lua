local linux_installer = require"lunastream.preinstaller.linux"
local luarocks_checker = require"lunastream.preinstaller.luarocks"
local osn = require"lunastream.preinstaller.os"
local supported = { "Debian Distro" }
local os_name = osn:get()

print("[PreInstaller] Detected OS: " .. os_name)

if os_name:find("Linux") then
	linux_installer:check()
	luarocks_checker:check()
else
	print("Your OS currently does not support LunaStream")
	print("Supported OS:")
	for _, v in pairs(supported) do
		print("- " .. v)
	end
	os.exit()
end
