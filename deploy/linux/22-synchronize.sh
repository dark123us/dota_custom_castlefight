set -a
. ./env
. ./vars.sh
. ./func.sh
set +a


# clear_dest
# create_custom
# install_lib
install_custom
sync_game_libs


# echo $PATHREPLINUX/$SOURCE/content $CONTENT
# diff -qr "$PATHREPLINUX/$SOURCE/content" "$CONTENT"

WATCH_GAME=game
WATCH_CONTENT=content
WATCH_LIBS=submodules

WATCH_DIRS="-r $PATHREPLINUX/$SOURCE/$WATCH_CONTENT/"
WATCH_DIRS=$WATCH_DIRS" -r $PATHREPLINUX/$SOURCE/$WATCH_GAME/"
WATCH_DIRS=$WATCH_DIRS" -r $PATHREPLINUX/$SOURCE/$WATCH_LIBS/"
COMMANDS="-e modify"

clear
echo $(date)
echo $WATCH_DIRS
while true; do
    inotifywait $WATCH_DIRS $COMMANDS |\
        (
            while read directory action file; do
                # sleep 1
                clear
                echo $(date)
                echo $WATCH_DIRS
                echo $directory $action $file
#             if [[ $file != *".rst"* ]]; then
#                 echo 'not find if file '$file
#                 continue
#             fi
                if [[ $directory == *$WATCH_LIBS* ]]; then
                    echo "in libs"
                    sync_content_libs
                    sync_game_libs
                    # sleep 1
                    # make support
                elif [[ $directory == *$WATCH_CONTENT* ]]; then
                    echo "in content"
                    sync_custom_content
                    # sleep 1
                    # make support
                elif [[ $directory == *$WATCH_GAME* ]]; then
                    echo "in game"
                    sync_custom_game
                    sync_game_libs
                    # sleep 1
                    # make support
                fi
            done
        )
done
