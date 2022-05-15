@Echo off&SetLocal EnableExtensions EnableDelayedExpansion

call env.bat

SET tmpfile=index.html

rem "%PATHGAME%\game\bin\win64\dota2.exe" -addon %NAMECUSTOM% -tools -threads 3 -console
rem "%PATHGAME%\game\bin\win64\dota2cfg.exe" -addon %NAMECUSTOM% -threads 3 -console

"%PATHDOTA%\game\bin\win64\resourcecompiler.exe" -fshallow -maxtextureres 256 -dxlevel 110 -quiet -html -unbufferedio -noassert -i "%PATHDOTA%\content\dota_addons\%NAMECUSTOM%\maps\%MAP%"  -world -phys -vis -gridnav -breakpad  -nompi  -nop4 -outroot "%tmp%\valve\hammermapbuild\game" > %tmpfile%
pause