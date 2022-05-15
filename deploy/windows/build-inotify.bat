@ECHO off
setlocal EnableDelayedExpansion

set APP=inotifywait.exe 
set TMP=inotify

git clone https://github.com/thekid/inotify-win %TMP%
%WINDIR%\Microsoft.NET\Framework\v4.0.30319\csc.exe /t:exe /out:%APP% %TMP%\src\*.cs
rmdir /S /Q %TMP%
