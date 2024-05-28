hatsuharu:
	luastatic src/hatsuharu.lua /usr/lib/x86_64-linux-gnu/liblua5.4.a
	rm -rf hatsuharu.luastatic.c

.PHONY: clean
clean:
	rm -rf hatsuharu

.PHONY: install
install:
	sudo luarocks install pegasus
	sudo luarocks install lua-cjson
	sudo luarocks install luastatic
	sudo apt install libssl-dev
	sudo luarocks install luasec