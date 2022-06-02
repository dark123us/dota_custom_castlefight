CUR=$(pwd)
cd src/game/scripts/vscripts/lib
git clone ssh://git@github.com/dark123us/dota-ecs
git clone ssh://git@github.com/dark123us/dota-lua-debug
git submodule update
cd $CUR
