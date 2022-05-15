set -a
. ./env
. ./vars.sh
set +a

VER=v2
NAME=vim_ide
REGISTER=hub.cap.by:443

SRC=$PATHREP
DST="/home/dark123us"
GAME=game
CONTENT=content

# PATHGIT=<pathgit.env
# PATHGAME=<pathgame.env
# NAMECUSTOM=<namecustom.env

PATHDOTAGAME="$PATHDOTA/$GAME/dota_addons"
PATHDOTACONTENT="$PATHDOTA/$CONTENT/dota_addons"

PATHDOTAGAMECUSTOM="$PATHDOTAGAME/$NAMECUSTOM"
PATHDOTACONTENTCUSTOM="$PATHDOTACONTENT/$NAMECUSTOM"

# echo $DOTAGAMEPATH
# echo $DOTACONTENTPATH
# echo $SRC

VOLUMES=( -v $SRC:$DST/app )
# if [[ -d $PATHDOTAGAMECUSTOM ]]; then
# 	VOLUMES+=( -v "$PATHDOTAGAMECUSTOM":$DST/dota/$GAME )
# 	# VOLUMES+=( -v "${DOTAGAMEPATH// /"\ "}"/:/dota/$GAME )
# else 
# 	echo "Not found $PATHDOTAGAMECUSTOM, passing"
# fi
# if [[ -d $PATHDOTACONTENTCUSTOM ]]; then
# 	VOLUMES+=( -v "$PATHDOTACONTENTCUSTOM":$DST/dota/$CONTENT )
# else 
# 	echo "Not found $PATHDOTACONTENTCUSTOM, passing"
# fi
# 
VOLUMES+=( -v "$PATHDOTAGAME":$DST/dota2/$GAME )
VOLUMES+=( -v "$PATHDOTACONTENT":$DST/dota2/$CONTENT )
# 
echo ${VOLUMES[@]}


CMD="cd $DST/app; sudo -iu dark123us; mc"

docker run -it --rm --name $NAME-$VER "${VOLUMES[@]}" $REGISTER/$NAME:$VER bash -c "$CMD"

