SUFFIX=dota_addons/$NAMECUSTOM
LIB=lib

CONTENT_DST=$PATHDOTA/content/$SUFFIX
GAME_DST=$PATHDOTA/game/$SUFFIX
CONTENT_LIB=panorama/$LIB
GAME_LIB=scripts/vscripts/$LIB
# CONTENTLIBXML=$CONTENT/panorama/layout/custom_game/$LIB

RSYNC="rsync -rmv "
# RSYNC="rsync -rm "
# LIBSRC=$PATHREPLINUX/$SOURCE/submodules
# RSYNC_GAME="-av --include='file.lua' --exclude='*'"

# SRC_GAME_LIBS=$PATHREPLINUX/$SOURCE/game/scripts/vscripts/$LIB

declare -A GAME_LIB_INSTALL
declare -A GAME_LIB_SYNC
declare -A CONTENT_LIB_INSTALL
declare -A CONTENT_LIB_SYNC

_RxLua=( rx.lua )
_dota_ecs=( ecs.lua ecs/*.lua )
_dota_lua_debug1=( debug.lua debug/*.lua )
_dota_lua_debug2=( debug.lua debug/*.lua 
    debug/lualogging/logging.lua debug/lualogging/logging/*.lua)

GAME_LIB_INSTALL[RxLua]=${_RxLua[@]}
GAME_LIB_INSTALL[dota-ecs]=${_dota_ecs[@]}
GAME_LIB_INSTALL[dota-lua-debug]=${_dota_lua_debug2[@]}

GAME_LIB_SYNC[dota-ecs]=${_dota_ecs[@]}
GAME_LIB_SYNC[dota-lua-debug]=${_dota_lua_debug1[@]}

# printf "%s\n" "${!GAME_LIB_INSTALL[RxLua]}"
# printf "%s\n" "${!GAME_LIB_INSTALL[dota-ecs]}"
