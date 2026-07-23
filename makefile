termux != echo $(PREFIX) | grep -o "com.termux"

game.love : *.lua assets/* conf.lua
	lua-language-server --check ./
	zip -FS -r -i "*.lua" "assets/*" @ game.love .

termux : game.love
	cp -v game.love ~/storage/shared/Documents/konduktör/

conf.lua : pc-conf.lua termux-conf.lua
ifdef termux
	cp termux-conf.lua conf.lua
else
	cp pc-conf.lua conf.lua
endif

clean :
	rm game.love conf.lua
