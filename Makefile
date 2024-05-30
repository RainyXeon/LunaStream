# All file have to build
ENTRYPOINT = lunastream/main.lua
# lunastream/utils
U_HTTP = lunastream/utils/http.lua
U_READCONFIG = lunastream/utils/readconfig.lua
U_URL = lunastream/utils/url.lua
UTILS = $(U_HTTP) $(U_READCONFIG) $(U_URL)
# lunastream/sources
SR_SOUNDCLOUD = lunastream/sources/soundcloud.lua
SOURCES = $(SR_SOUNDCLOUD)
# lunastream/router
RO_INIT = lunastream/router/init.lua
RO_V1_INIT = lunastream/router/v1/init.lua
RO_V1_INFO = lunastream/router/v1/info.lua
RO_V1_LOADTRACKS = lunastream/router/v1/loadtracks.lua
RO_V1 = $(RO_V1_INIT) $(RO_V1_INFO) $(RO_V1_LOADTRACKS)
ROUTER = $(RO_INIT) $(RO_V1)
# lunastream/constants
CO_METADATA = lunastream/constants/metadata.lua
CONSTANTS = $(CO_METADATA)
# lunastream/preinstaller
PRE_INIT = lunastream/preinstaller/init.lua
PRE_LINUX = lunastream/preinstaller/linux.lua
PRE_LUAROCKS = lunastream/preinstaller/luarocks.lua
PREINSTALLER = $(PRE_INIT) $(PRE_LINUX) $(PRE_LUAROCKS)

FINAL = $(UTILS) $(SOURCES) $(ROUTER) $(CONSTANTS) $(PREINSTALLER)

lunastream:
	make linux

.PHONY: linux_pack
linux_pack:
	make linux
	zip lunastream_linux.zip lunastream.linux

.PHONY: linux
linux:
	mkdir build
	./lua_modules/bin/luastatic $(ENTRYPOINT) $(FINAL) /usr/lib/x86_64-linux-gnu/liblua5.1.a -I/usr/include/lua5.1
	rm -rf main.luastatic.c
	mv main build/lunastream.linux

.PHONY: clean
clean:
	rm -rf build

.PHONY: install
install:
	sudo apt install libcurl4-nss-dev zip unzip
	luarocks install pegasus --tree lua_modules
	luarocks install lua-cjson --tree lua_modules
	luarocks install luastatic --tree lua_modules
	luarocks install lua-curl CURL_INCDIR=/usr/include/x86_64-linux-gnu --tree lua_modules

.PHONY: uninstall
uninstall:
	luarocks remove pegasus --tree lua_modules
	luarocks remove lua-cjson --tree lua_modules
	luarocks remove luastatic --tree lua_modules
	luarocks remove lua-curl --tree lua_modules
