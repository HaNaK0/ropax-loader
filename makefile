termux != echo $(PREFIX) | grep -o "com.termux"
ifdef termux 
	platform = android
else
	platform = pc
endif

game.love : *.lua assets/* conf.lua platform.lua
	lua-language-server --check ./
	zip -FS -r -i "*.lua" "assets/*" @ game.love .

termux : game.love
	cp -v game.love ~/storage/shared/Documents/konduktör/

conf.lua : platforms/$(platform)/conf.lua
	cp platforms/$(platform)/conf.lua conf.lua

platform.lua : platforms/$(platform)/platform.lua
	cp platforms/$(platform)/platform.lua platform.lua

clean :
	rm game.love conf.lua platform.lua
