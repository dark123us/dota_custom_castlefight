function clear_dest {
    if [ -d "$CONTENT_DST" ]; then
	rm -rf "$CONTENT_DST"
    fi
    if [ -d "$GAME_DST" ]; then
    	rm -rf "$GAME_DST"
    fi
}

get_include_ret=()
function get_include {
    get_include_ret=()
    if [ $# -eq 0 ]; then
        return
    fi
    local arr=("$@")
    # echo ${arr[*]}
    for i in "${arr[@]}"; do
        get_include_ret+=( --include=$i )
    done
    get_include_ret+=( --include='*/' )
    get_include_ret+=( --exclude='*' )
    # echo ${func_ret[*]}
}

function install_game_lib {
    dst=$GAME_DST/$GAME_LIB
    if [ ! -d "$dst" ]; then
        mkdir "$dst"
    fi
    for K in "${!GAME_LIB_INSTALL[@]}"; do
        dst=$GAME_DST/$GAME_LIB/$K
        if [ ! -d "$dst" ]; then
            mkdir "$dst"
        fi
        get_include ${GAME_LIB_INSTALL[$K]}
        params=${get_include_ret[@]}
        val="$RSYNC ${params[@]} '$PATHREP/$SOURCE/game/$GAME_LIB/$K/' '$dst'"
        echo $val 
        $RSYNC ${params[@]} "$PATHREP/$SOURCE/game/$GAME_LIB/$K/" "$dst"
    done
}

function sync_game_lib {
    for K in "${!GAME_LIB_SYNC[@]}"; do
        dst=$GAME_DST/$GAME_LIB/$K
        get_include ${GAME_LIB_SYNC[$K]}
        params=${get_include_ret[@]}
        val="$RSYNC ${params[@]} '$PATHREP/$SOURCE/game/$GAME_LIB/$K/' '$dst/'"
        echo $val 
        $RSYNC ${params[@]} "$PATHREP/$SOURCE/game/$GAME_LIB/$K/" "$dst"
    done
}

function install_content_lib {
    dst=$CONTENT_DST/$CONTENT_LIB
    if [ ! -d "$dst" ]; then
        mkdir "$dst"
    fi
    for K in "${!CONTENT_LIB_INSTALL[@]}"; do
        dst=$CONTENT_DST/$CONTENT_LIB/$K
        src=$PATHREP/$SOURCE/content/$CONTENT_LIB/$K
        if [ ! -d "$dst" ]; then
            mkdir "$dst"
        fi
        get_include ${CONTENT_LIB_INSTALL[$K]}
        params=${get_include_ret[@]}
        val="$RSYNC ${params[@]} '$src/' '$dst'"
        echo $val 
        $RSYNC ${params[@]} "$src/" "$dst"
    done
}

function sync_content_lib {
    for K in "${!CONTENT_LIB_SYNC[@]}"; do
        dst=$CONTENT_DST/$CONTENT_LIB/$K
        src=$PATHREP/$SOURCE/content/$CONTENT_LIB/$K
        get_include ${CONTENT_LIB_SYNC[$K]}
        params=${get_include_ret[@]}
        val="$RSYNC ${params[@]} '$src/' '$dst'"
        echo $val 
        $RSYNC ${params[@]} "$src/" "$dst"
    done
}

function sync_game {
    ext=(*.lua *.txt *.png)
    get_include ${ext[@]}
    params=${get_include_ret[@]}
    val="$RSYNC ${params[@]} '$PATHREP/$SOURCE/game/' '$GAME_DST'"
    echo $val 
    $RSYNC --exclude=$LIB/* ${params[@]} "$PATHREP/$SOURCE/game/" "$GAME_DST/"
}

function sync_content {
    ext=(*.js *.css *.xml *.vmap *.png *.tif *.tga *.txt *.vmat *.vtex *.psd)
    get_include ${ext[@]}
    params=${get_include_ret[@]}
    $RSYNC --exclude=$LIB/* ${params[@]} "$PATHREP/$SOURCE/content/" "$CONTENT_DST/"
}

function install_custom {
    if [ ! -d "$CONTENT_DST" ]; then
	    mkdir "$CONTENT_DST"
    fi
    if [ ! -d "$GAME_DST" ]; then
	    mkdir "$GAME_DST"
    fi
    sync_game
    sync_content
    install_game_lib
    install_content_lib
}

function build_map {
	echo "@Echo off&SetLocal EnableExtensions EnableDelayedExpansion" > build-map.bat
	echo "SET PATHDOTA=$PATHDOTAWINDOWS" >> build-map.bat
	echo "SET PATHREP=$PATHREPWINDOWS" >> build-map.bat
	echo "SET NAMECUSTOM=$NAMECUSTOM" >> build-map.bat
	echo "SET MAP=$NAMEMAP" >> build-map.bat
	echo "SET tmpfile=index.html" >> build-map.bat
	echo 'start "" "file://%PATHREP%/deploy/linux/%tmpfile%"' >> build-map.bat

	# rem "%PATHGAME%\game\bin\win64\dota2.exe" -addon %NAMECUSTOM% -tools -threads 3 -console
	# rem "%PATHGAME%\game\bin\win64\dota2cfg.exe" -addon %NAMECUSTOM% -threads 3 -console

	echo 'rem "%PATHDOTA%\game\bin\win64\resourcecompiler.exe" -fshallow -maxtextureres 256 -dxlevel 110 -quiet -html -unbufferedio -noassert -i "%PATHDOTA%\content\dota_addons\%NAMECUSTOM%\maps\%MAP%"  -world -phys -vis -gridnav -breakpad  -nompi  -nop4 -outroot "%tmp%\valve\hammermapbuild\game" > %tmpfile%' >> build-map.bat

	echo '"%PATHDOTA%\game\bin\win64\resourcecompiler.exe" -fshallow -maxtextureres 256 -dxlevel 110 -quiet -html -unbufferedio -noassert -i "%PATHDOTA%\content\dota_addons\%NAMECUSTOM%\maps\%MAP%.vmap"  -world -phys -vis -gridnav -breakpad  -nompi  -nop4 -outroot "%tmp%\valve\hammermapbuild\game"' >> build-map.bat

	# echo 'pause' >> build-map.bat

	echo 'echo "<br />"' >> build-map.bat
	echo 'mkdir "%PATHDOTA%\game\dota_addons\%NAMECUSTOM%\maps\"' >> build-map.bat
	echo 'echo "<br />"' >> build-map.bat
	echo 'move "%tmp%\valve\hammermapbuild\game\dota_addons\%NAMECUSTOM%\maps\%MAP%.vpk" "%PATHDOTA%\game\dota_addons\%NAMECUSTOM%\maps\%MAP%.vpk"' >> build-map.bat

	echo cmd.exe /c "$PATHREPWINDOWS/deploy/linux/build-map.bat"

	cp index.tmpl index.html


	cmd.exe /c "$PATHREPWINDOWS/deploy/linux/build-map.bat" >> index.html
}

function run-tools {
	NAMEBAT=run-tools.bat

	echo "@Echo off&SetLocal EnableExtensions EnableDelayedExpansion" > $NAMEBAT
	echo "SET PATHDOTA=$PATHDOTAWINDOWS" >> $NAMEBAT
	echo "SET NAMECUSTOM=$NAMECUSTOM" >> $NAMEBAT
	echo "SET MAP=$NAMEMAP" >> $NAMEBAT
	echo "echo \"in console run 'dota_launch_custom_game %NAMECUSTOM% %MAP% jointeam good'\"" >> $NAMEBAT
	# echo '"%PATHDOTA%\game\bin\win64\dota2.exe" -addon %NAMECUSTOM% -map %MAP% -tools -threads 4 -novid -vconsole' >> $NAMEBAT
	# echo '"%PATHDOTA%\game\bin\win64\dota2.exe" -addon %NAMECUSTOM% -uidev -dev -novid -tools -vconsole -toconsole -condebug -nominidumps +dota_launch_custom_game %NAMECUSTOM% %MAP% jointeam good' >> $NAMEBAT
	echo '"%PATHDOTA%\game\bin\win64\dota2.exe" -addon %NAMECUSTOM% -novid -tools -vconsole -toconsole +dota_launch_custom_game %NAMECUSTOM% %MAP% jointeam good' >> $NAMEBAT
	echo "pause " >> $NAMEBAT

	cmd.exe /c "$PATHREPWINDOWS/deploy/linux/$NAMEBAT"
}

# LIBS=(debug-dota ecs-dota)
# RSYNC="rsync -rmv "
# 
# LIBS=()
# for i in $(ls -l $LIBSRC | awk '/^d/ {print $9}'); do 
#     LIBS+=(${i%%/}) 
# done
# 
# GAMELIBS=()
# for i in $(ls -l $SRC_GAME_LIBS | awk '/^d/ {print $9}'); do 
#     GAMELIBS+=(${i%%/}) 
# done
# echo "gamelibs is ${GAMELIBS[*]}"
# 
# 
# ext=(lua txt)
# get_include ${ext[@]}
# RSYNC_INC_GAME="${get_include_ret[@]}"
# 
# ext=( js css xml vmap png tif tga txt vmat vtex psd )
# get_include ${ext[@]}
# RSYNC_INC_CONTENT="${get_include_ret[@]}"
# 
# ext=( xml )
# get_include ${ext[@]}
# RSYNC_INC_XML="${get_include_ret[@]}"
# 
# ext=( js css )
# get_include ${ext[@]}
# RSYNC_INC_JS="${get_include_ret[@]}"
# 
# echo '  =================== '
# echo $RSYNC_INC_GAME
# echo $RSYNC_INC_CONTENT
# 
# https://wiki.dieg.info/rsync
# -e, ???rsh=COMMAND -?????????? ?????????????? ?????????? ?????????????????? ???????????????? (ssh, rsh, remsh), ???????? ???????????? ???????????????????? ?????????????????? RSYNC_RSH.

# for i in ${!LIBS[*]}; do
#    echo ${LIBS[$i]}
# done


# function sync_content_libs {
# 	for i in ${!LIBS[*]}; do
# 		src=$LIBSRC/${LIBS[$i]}/content/
#         dst=$CONTENTLIB/${LIBS[$i]}
#         if [ -d $src ]; then
#             if [ ! -d "$dst" ]; then
#                 mkdir "$dst"
#             fi
#             $RSYNC $RSYNC_INC_JS "$src" "$dst/"
#         fi
# 	done
# 	for i in ${!LIBS[*]}; do
# 		src=$LIBSRC/${LIBS[$i]}/content/layout/
#         dst=$CONTENTLIBXML/${LIBS[$i]}
#         if [ -d $src ]; then
#             if [ ! -d "$dst" ]; then
#                 mkdir "$dst"
#             fi
# 			$RSYNC $RSYNC_INC_XML "$src" "$dst/"
# 		fi
# 	done
# }
# 
# function sync_game_libs {
#     ext=(lua txt)
#     get_include ${ext[@]}
#     params=${get_include_ret[@]}
#     lib=$SRC_GAME_LIBS
# 
# 	for i in ${GAMELIBS[@]}; do
# 		src=$lib/$i/init.lua
#         dst=$GAMELIB/$i.lua
# 		if [ -f $src ]; then
#             cp "$src" "$dst"
#             echo cp "$src" "$dst"
# 
#         fi
# 	done
# }



# function install_lib {
#     if [ ! -d "$CONTENTLIB" ]; then
# 	    mkdir -p "$CONTENTLIB"
#     fi
#     if [ ! -d "$CONTENTLIBXML" ]; then
#     	mkdir -p "$CONTENTLIBXML"
#     fi
#     if [ ! -d "$GAMELIB" ]; then
#     	mkdir -p "$GAMELIB"
#     fi
#     sync_content_libs
#     sync_game_libs
# }

