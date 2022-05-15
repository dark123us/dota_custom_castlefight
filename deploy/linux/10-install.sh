set -a
. ./env
. ./vars.sh
. ./func.sh
set +a
set -e

install_custom
build_map
run-tools
