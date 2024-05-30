local linux_installer = require"lunastream.preinstaller.linux"
local isWin = package.config:sub(1, 1) == "\\"
if not isWin then
	os.execute(
		"export LUA_PATH='lua_modules/share/lua/5.1/?.lua;lua_modules/share/lua/5.1/?/init.lua;;'"
	)
	os.execute("export LUA_CPATH='lua_modules/lib/lua/5.1/?.so' ")
	linux_installer:check()
end
local luarocks_checker = require"lunastream.preinstaller.luarocks"
luarocks_checker:check()
