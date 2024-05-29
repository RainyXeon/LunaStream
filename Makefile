# All file have to build
ENTRYPOINT = src/lunastream.lua
# src/utils
U_HTTP = src/utils/http.lua
U_READCONFIG = src/utils/readconfig.lua
U_URL = src/utils/url.lua
UTILS = $(U_HTTP) $(U_READCONFIG) $(U_URL)
# src/sources
SR_SOUNDCLOUD = src/sources/soundcloud.lua
SOURCES = $(SR_SOUNDCLOUD)
# src/router
RO_INIT = src/router/init.lua
RO_V1_INIT = src/router/v1/init.lua
RO_V1_INFO = src/router/v1/info.lua
RO_V1_LOADTRACKS = src/router/v1/loadtracks.lua
RO_V1 = $(RO_V1_INIT) $(RO_V1_INFO) $(RO_V1_LOADTRACKS)
ROUTER = $(RO_INIT) $(RO_V1)
# src/constants
CO_METADATA = src/constants/metadata.lua
CONSTANTS = $(CO_METADATA)

FINAL = $(ENTRYPOINT) $(UTILS) $(SOURCES) $(ROUTER) $(CONSTANTS)

lunastream:
	make linux

.PHONY: linux_pack
linux_pack:
	make linux
	zip lunastream_linux.zip src/

.PHONY: linux
linux:
	luastatic $(FINAL) /usr/lib/x86_64-linux-gnu/liblua5.4.a
	rm -rf lunastream.luastatic.c

.PHONY: clean
clean:
	rm -rf lunastream

.PHONY: install
install:
	sudo apt install libcurl4-nss-dev zip unzip
	sudo luarocks install pegasus
	sudo luarocks install lua-cjson
	sudo luarocks install luastatic
	sudo luarocks install lua-curl CURL_INCDIR=/usr/include/x86_64-linux-gnu

.PHONY: uninstall
uninstall:
	sudo luarocks install pegasus
	sudo luarocks remove lua-cjson
	sudo luarocks remove luastatic
	sudo luarocks remove lua-curl
