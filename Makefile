.PHONY: linux
linux:
	mkdir build
	node ./scripts/build_linux.js
	rm -rf main.luastatic.c
	mv main build/lunastream.linux

lunastream:
	make linux

.PHONY: clean
clean:
	rm -rf build

.PHONY: install
install:
	sudo apt install libcurl4-nss-dev zip unzip npm
	npm i
	luarocks install luarocks 3.8.0-1 --tree lua_modules
	luarocks install lua-cjson --tree lua_modules
	luarocks install luastatic --tree lua_modules
	sudo luarocks install turbo --tree lua_modules
	luarocks install lua-curl CURL_INCDIR=/usr/include/x86_64-linux-gnu --tree lua_modules

.PHONY: uninstall
uninstall:
	luarocks install luarocks 3.8.0-1 --tree lua_modules
	luarocks remove lua-cjson --tree lua_modules
	luarocks remove luastatic --tree lua_modules
	luarocks remove lua-curl --tree lua_modules
	sudo luarocks remove turbo --tree lua_modules
	sudo rm -rf lua_modules
