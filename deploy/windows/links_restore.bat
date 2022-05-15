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

SET FROM[0]=%PATHGIT%\%SOURCE%\game
SET FROM[1]=%PATHGIT%\%SOURCE%\content
SET TO[0]=%GAME%
SET TO[1]=%CONTENT%
set SUFFIX[0]=game
set SUFFIX[1]=content

SET MODULE=debug-dota

SET FROM[2]=%GITSUBMODULES%\%MODULE%\game
SET FROM[3]=%GITSUBMODULES%\%MODULE%\content
SET TO[2]=%GAMEMODULE%\%MODULE%
SET TO[3]=%CONTENTMODULE%\%MODULE%
set SUFFIX[2]=game
set SUFFIX[3]=content

SET MODULE=ecs-dota

SET FROM[4]=%GITSUBMODULES%\%MODULE%\game
SET FROM[5]=%GITSUBMODULES%\%MODULE%\content
SET TO[4]=%GAMEMODULE%\%MODULE%
SET TO[5]=%CONTENTMODULE%\%MODULE%
set SUFFIX[4]=game
set SUFFIX[5]=content


for /L %%I in (0,1,5) do (
	set SRC="!FROM[%%I]!"
	set DST="!TO[%%I]!"
	IF EXIST !DST! (
		ECHO Restoring links
		IF EXIST !SRC! (
			ECHO "  FOUND !SRC! - check if symlink"
			ECHO "    CHECK IF FOLDER IS SYMLINK: dir %PATHGIT%\%SOURCE%\ /AL /B | find \"!SUFFIX[%%I]!\" > %tmpfile%"
			dir "!SRC!\.." /AL /B | find "!SUFFIX[%%I]!" > %tmpfile%
			if errorlevel 1 (
				echo "      This is a directory"
			) else (
				ECHO "      This is a symlink/junction, removing"
				rmdir "!SRC!"
			) 
			IF EXIST %tmpfile% del %tmpfile%
		) ELSE (
			ECHO "Directory !SRC! not found"
		)
		IF EXIST !SRC! (
			ECHO "    Directory !SRC! is not deleting, link is not creating"
		) else (
			ECHO "    CREATE HARD LINKS: mklink /J !SRC! !DST!"
			mklink /J !SRC! !DST!
		)
	) ELSE (
		ECHO "MOVING FOLDERS: "
		echo "   md !DST!"
                md !DST!
		echo "   xcopy /Y /E /H !SRC! !DST!"
                xcopy /Y /E /H !SRC! !DST! > nul
 		echo "   rmdir /S /Q !SRC!"
                rmdir /S /Q !SRC!
		ECHO "AND CREATE HARD LINKS: mklink /J !SRC! !DST!"
		mklink /J !SRC! !DST!
	)
	echo: 
)
ECHO "THE END"
rem exit 0
pause
