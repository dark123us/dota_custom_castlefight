SUFFIX=dota_addons/$NAMECUSTOM
LIB=lib

CONTENT=$PATHDOTALINUX/content/$SUFFIX
GAME=$PATHDOTALINUX/game/$SUFFIX
GAMELIB=$GAME/scripts/vscripts/$LIB
CONTENTLIB=$CONTENT/panorama/$LIB
CONTENTLIBXML=$CONTENT/panorama/layout/custom_game/$LIB

LIBSRC=$PATHREPLINUX/$SOURCE/submodules
# RSYNC_GAME="-av --include='file.lua' --exclude='*'"

SRC_GAME_LIBS=$PATHREPLINUX/$SOURCE/game/scripts/vscripts/$LIB
