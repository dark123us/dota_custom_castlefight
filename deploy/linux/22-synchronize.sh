set -a
. ./env
. ./vars.sh
. ./func.sh
set +a


# clear_dest
# create_custom
# install_lib
install_custom


# echo $PATHREPLINUX/$SOURCE/content $CONTENT
# diff -qr "$PATHREPLINUX/$SOURCE/content" "$CONTENT"

WATCH_GAME=game
WATCH_CONTENT=content

WATCH_DIRS="-r $PATHREP/$SOURCE/$WATCH_CONTENT/"
WATCH_DIRS=$WATCH_DIRS" -r $PATHREP/$SOURCE/$WATCH_GAME/"
COMMANDS="-e modify"

clear
echo $(date)
echo $WATCH_DIRS
while true; do
    inotifywait $WATCH_DIRS $COMMANDS |\
        (
            while read directory action file; do
                clear
                echo $(date)
                echo $WATCH_DIRS
                echo $directory $action $file
#             if [[ $file != *".rst"* ]]; then
#                 echo 'not find if file '$file
#                 continue
#             fi
                if [[ $directory == *$WATCH_CONTENT* ]]; then
                    echo "in content"
                    sync_custom_content
                    # sleep 1
                    # make support
                elif [[ $directory == *$WATCH_GAME* ]]; then
                    echo "in game"
                    sync_custom_game
                    # sleep 1
                    # make support
                fi
            done
        )
done
