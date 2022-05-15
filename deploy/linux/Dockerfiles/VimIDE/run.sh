VER=v2
NAME=vim_ide
REGISTER=hub.cap.by
SRC=$(realpath "../../../")

DOTAPATH="/mnt/d/SteamLibrary/steamapps/common/dota 2 beta"
NAMECUSTOM=$(cat $SRC/deploy/namecustom.env | tr -d '[:space:]')
GAME=game
CONTENT=content

# PATHGIT=<pathgit.env
# PATHGAME=<pathgame.env
# NAMECUSTOM=<namecustom.env

DOTAGAMEPATH=$DOTAPATH/$GAME/dota_addons/$NAMECUSTOM
DOTACONTENTPATH=$DOTAPATH/$CONTENT/dota_addons/$NAMECUSTOM

VOLUMES=( -v $SRC:/app )
if [[ -d $DOTAGAMEPATH ]]; then
	VOLUMES+=( -v "$DOTAGAMEPATH":/dota/$GAME )
	# VOLUMES+=( -v "${DOTAGAMEPATH// /"\ "}"/:/dota/$GAME )
fi
if [[ -d $DOTACONTENTPATH ]]; then
	VOLUMES+=( -v "$DOTACONTENTPATH":/dota/$CONTENT )
fi
echo ${VOLUMES[@]}


docker run -it --rm --name $NAME-$VER "${VOLUMES[@]}" $REGISTER/$NAME:$VER bash

