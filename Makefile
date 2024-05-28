hatsuharu:
	mkdir build
	make linux

.PHONY: clean
linux:
	luastatic src/hatsuharu.lua /usr/lib/x86_64-linux-gnu/liblua5.4.a
	rm -rf hatsuharu.luastatic.c
	mv hatsuharu ./build/hatsuharu.linux

.PHONY: clean
clean:
	rm -rf build

.PHONY: install
install:
	sudo luarocks install pegasus
	sudo luarocks install lua-cjson
	sudo luarocks install luastatic
	sudo apt install libssl-dev
	sudo luarocks install luasec