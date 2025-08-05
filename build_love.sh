lua-language-server -logpath log/ --check ./

rsync -a ~/storage/pictures/Sprites/ropax_loader/ assets/sprites/
zip -FS -r -i "*.lua" "assets/*" @ game.love . && \
	cp -v game.love ~/storage/shared/Documents/konduktör/game.love 
