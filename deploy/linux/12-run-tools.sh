set -a
. ./env
. ./vars.sh
set +a

NAMEBAT=run-tools.bat

echo "@Echo off&SetLocal EnableExtensions EnableDelayedExpansion" > $NAMEBAT
echo "SET PATHDOTA=$PATHDOTA" >> $NAMEBAT
echo "SET NAMECUSTOM=$NAMECUSTOM" >> $NAMEBAT
echo "SET MAP=${NAMEMAP%.*}" >> $NAMEBAT
echo "echo \"in console run '\ndota_launch_custom_game %NAMECUSTOM% %MAP% jointeam good\n'\"" >> $NAMEBAT
echo '"%PATHDOTA%\game\bin\win64\dota2.exe" -addon %NAMECUSTOM% -map %MAP% -tools -threads 4 -novid -console' >> $NAMEBAT
echo "pause " >> $NAMEBAT

cmd.exe /c "$PATHREP/deploy/linux/$NAMEBAT"
