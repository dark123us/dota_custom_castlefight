set -a
. ./env
. ./vars.sh
set +a

cd $PATHREP

cd src/game/scripts/vscripts/lib
git clone ssh://git@github.com/dark123us/dota-ecs
git clone ssh://git@github.com/dark123us/dota-lua-debug
git clone ssh://git@github.com/dark123us/dota2_api

cd $PATHREP
cd src/content/panorama/lib
git clone ssh://git@github.com/dark123us/dota-custom-panorama-debug debug

git submodule init
git submodule update

