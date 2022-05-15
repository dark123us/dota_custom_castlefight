@ECHO off
setlocal EnableDelayedExpansion

SET res=true
IF NOT EXIST env\namecustom.env SET res=false
IF NOT EXIST env\pathdota.env SET res=false
IF NOT EXIST env\pathgit.env SET res=false 
IF NOT EXIST env\source.env SET res=false

if "%res%"=="false" (
	echo "Environment not found - fill folder env"
	pause
	exit 0
)

SET /p PATHGIT=<env\pathgit.env
SET /p PATHDOTA=<env\pathdota.env
SET /p NAMECUSTOM=<env\namecustom.env
SET /p SOURCE=<env\source.env

SET SUFFIX[0]=game
SET SUFFIX[1]=content
SET tmpfile=%RANDOM%.tmp


SET GAME=%PATHDOTA%\game\dota_addons\%NAMECUSTOM%
SET CONTENT=%PATHDOTA%\content\dota_addons\%NAMECUSTOM%

SET GITSUBMODULES=%PATHGIT%\%SOURCE%\submodules
SET GAMEMODULE=%GAME%\scripts\vscripts\vendors
SET CONTENTMODULE=%CONTENT%\panorama\vendors

SET MODULE=debug-dota
SET FROM[0]=%GITSUBMODULES%\%MODULE%\game
SET FROM[1]=%GITSUBMODULES%\%MODULE%\content
SET TO[0]=%GAMEMODULE%\%MODULE%
SET TO[1]=%CONTENTMODULE%\%MODULE%
set SUFFIX[0]=game
set SUFFIX[1]=content

SET MODULE=ecs-dota

SET FROM[2]=%GITSUBMODULES%\%MODULE%\game
SET FROM[3]=%GITSUBMODULES%\%MODULE%\content
SET TO[2]=%GAMEMODULE%\%MODULE%
SET TO[3]=%CONTENTMODULE%\%MODULE%
set SUFFIX[2]=game
set SUFFIX[3]=content

SET FROM[4]=%PATHGIT%\%SOURCE%\game
SET FROM[5]=%PATHGIT%\%SOURCE%\content
SET TO[4]=%GAME%
SET TO[5]=%CONTENT%
set SUFFIX[4]=game
set SUFFIX[5]=content

for /L %%I in (0,1,5) do (
	set SRC="!FROM[%%I]!"
	set DST="!TO[%%I]!"
	
	IF EXIST "!DST!" (
		ECHO move files back from !DST! to !SRC!
		rmdir !SRC!
	        md !SRC!
                xcopy /Y /E /H !DST! !SRC! > nul
                rmdir /S /Q !DST!

	) ELSE (
		ECHO !DST! not found
	)
)

ECHO THE END
PAUSE
rem exit 0
