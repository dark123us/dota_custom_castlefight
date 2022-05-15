@ECHO OFF
SET res=true
IF NOT EXIST env\namecustom.env SET res=false
IF NOT EXIST env\pathdota.env SET res=false
IF NOT EXIST env\currentmap.env SET res=false

if "%res%"=="false" (
	echo "Environment not foud - fill folder env"
	pause
	exit 0
)


SET /p PATHDOTA=<env\pathdota.env
SET /p NAMECUSTOM=<env\namecustom.env
SET /p MAP=<env\currentmap.env


rem "%PATHGAME%\game\bin\win64\dota2cfg.exe" -addon %NAMECUSTOM% -threads 4 -novid -console

FOR /f "tokens=1* delims=." %%a IN ("%MAP%") do (
rem 	echo %%a&echo %%b&echo %%c&echo %%d
	set f=%%a
)

echo "in console run 'dota_launch_custom_game %NAMECUSTOM% %f% jointeam good'"
"%PATHDOTA%\game\bin\win64\dota2.exe" -addon %NAMECUSTOM% -map %f% -tools -threads 4 -novid -console

pause 