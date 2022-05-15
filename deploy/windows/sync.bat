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

SET GAME=%PATHDOTA%\game\dota_addons\%NAMECUSTOM%
SET CONTENT=%PATHDOTA%\content\dota_addons\%NAMECUSTOM%

SET FROM[0]=%PATHGIT%\%SOURCE%\game
SET FROM[1]=%PATHGIT%\%SOURCE%\content

SET TO[0]=%GAME%
SET TO[1]=%CONTENT%

set APP=inotifywait.exe 
set PARAM=-r %PATHGIT%\%SOURCE% -e modify 

set EXEC=%APP% %PARAM%

rem SYNCRONIZE GIT AND DOTA
rem if need in DOTA create folders

IF NOT EXIST "%PATHDOTA%" (
	echo not found dota folder in path %PATHDOTA%
	pause
	exit 0
)

IF NOT EXIST "%GAME%" (
	md "%GAME%"
)

IF NOT EXIST "%CONTENT%" (
	md "%CONTENT%"
)

robocopy "%FROM[0]%" "%TO[0]%" *.lua *.txt *.png *.gameevents /e
robocopy "%FROM[1]%" "%TO[1]%" *.vmap *.png *.xml *.js *.css *.tif *.vmat *.vtex *.psd *.tga /e

echo "%FROM[0]%"
echo "%FROM[1]%"

echo "%TO[0]%"
echo "%TO[1]%"


echo %EXEC%

rem :loop
	for /F "tokens=1,2,3 delims= " %%a in ('%EXEC%') do (
		set mypath=%%a & set event=%%b & set myfile=%%c
	)
	echo "myvar=%mypath%"
	echo "myvar=%myfile%"

rem goto loop

pause