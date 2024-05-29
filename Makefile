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

FINAL = $(UTILS) $(SOURCES) $(ROUTER) $(CONSTANTS)

lunastream:
	make linux

.PHONY: linux_pack
linux_pack:
	make linux
	zip lunastream_linux.zip lunastream.linux

.PHONY: linux
linux:
	mkdir build
	luastatic $(ENTRYPOINT) $(FINAL) /usr/lib/x86_64-linux-gnu/liblua5.4.a
	rm -rf main.luastatic.c
	mv main build/lunastream.linux

.PHONY: clean
clean:
	rm -rf build

.PHONY: install
install:
	sudo apt install libcurl4-nss-dev zip unzip
	sudo luarocks install pegasus
	sudo luarocks install lua-cjson
	sudo luarocks install luastatic
	sudo luarocks install lua-curl CURL_INCDIR=/usr/include/x86_64-linux-gnu

.PHONY: uninstall
uninstall:
	sudo luarocks remove pegasus
	sudo luarocks remove lua-cjson
	sudo luarocks remove luastatic
	sudo luarocks remove lua-curl
