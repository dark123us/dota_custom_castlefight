set -a
. ./env
. ./vars.sh
. ./func.sh
set +a

clear_dest
install_custom
sync_game_libs
build_map
