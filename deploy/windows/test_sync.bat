@Echo off&SetLocal EnableExtensions EnableDelayedExpansion

SET FENV=env.bat

call env.bat 
echo %MAP%
echo %PATHGIT%
echo %PATHDOTA%
echo %NAMECUSTOM%
echo %SOURCE%
pause



call :BackupEnv

rem echo "starting"
rem start cmd /C call "tmp.bat"
rem echo "started"


call env.bat 
echo %MAP%
echo %PATHGIT%
echo %PATHDOTA%
echo %NAMECUSTOM%
echo %SOURCE%
pause

call :RestoreEnv

set tmpfile=test_sync.bat
call :GetFileSize %tmpfile% FileSize
call :GetFileDate %tmpfile% c FileDate1
call :GetFileDate %tmpfile% w FileDate2
call :GetFileDate %tmpfile% a FileDate3
echo %tmpfile% is %FileSize% byte create %FileDate1% %FileDate2% %FileDate3%

call env.bat 
echo %MAP%
echo %PATHGIT%
echo %PATHDOTA%
echo %NAMECUSTOM%
echo %SOURCE%
pause

exit


:BackupEnv
if not exist %FENV%.bak (
  echo PATHGIT = %PATHGIT%
  move %FENV% %FENV%.bak
  echo moving file and create new
  echo SET MAP=test_map.vma > %FENV%
  echo SET PATHGIT=%PATHGIT% >> %FENV%
  echo SET PATHDOTA=%PATHGIT%\test >> %FENV%
  echo SET NAMECUSTOM=cf_test >> %FENV%
  echo SET SOURCE=test >> %FENV%
)
exit /b

:RestoreEnv
if exist %FENV%.bak (
	echo restore env file
	del %FENV%
	move %FENV%.bak %FENV%
)
goto:eof

:GetFileSize
set "%~2=%~z1"
goto:eof

:GetFileDate
for /f "skip=5 tokens=1,2 delims= " %%a in (
 'dir  /a:-d /o:d /t:%2 "%~1"') do set "%~3=%%~a %%~b"&goto:eof
goto:eof