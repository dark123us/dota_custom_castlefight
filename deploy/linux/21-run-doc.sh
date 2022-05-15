VER=v2
NAME=doc-builder
REGISTER=hub.cap.by:443
SRC=$(builtin cd "../"; pwd)
DST="/app"

PATHDOC=/app/app/develop/submodules/castlefight-doc
BUILD=/mnt/d/tmp/html

DOTAPATH="/mnt/d/SteamLibrary/steamapps/common/dota 2 beta"
NAMECUSTOM=$(cat $SRC/deploy/env/namecustom.env | tr -d '[:space:]')
GAME=game
CONTENT=content

DOTAGAMEPATH=$DOTAPATH/$GAME/dota_addons/$NAMECUSTOM
DOTACONTENTPATH=$DOTAPATH/$CONTENT/dota_addons/$NAMECUSTOM

VOLUMES=( -v $SRC:$DST/app )
if [[ -d $DOTAGAMEPATH ]]; then
	VOLUMES+=( -v "$DOTAGAMEPATH":$DST/dota/$GAME )
	# VOLUMES+=( -v "${DOTAGAMEPATH// /"\ "}"/:/dota/$GAME )
fi
if [[ -d $DOTACONTENTPATH ]]; then
	VOLUMES+=( -v "$DOTACONTENTPATH":$DST/dota/$CONTENT )
fi

VOLUMES+=( -v $BUILD:$PATHDOC/builds)

echo ${VOLUMES[@]}

# CMD="cd $DST/app; sudo -iu dark123us; mc"
CMD="ln -s $PATHDOC /docs; bash"

docker run -it --rm --name $NAME-$VER "${VOLUMES[@]}" $REGISTER/$NAME:$VER bash -c "$CMD"

