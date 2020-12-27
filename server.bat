@echo off
cd C:\Server\nginx

if "%1" == "start" GOTO STARTSERVER
if "%1" == "stop" GOTO STOPSERVER
echo Incorrect Command
echo To start : server start
echo To stop  : server stop
GOTO END

:STARTSERVER
tasklist /fi "imagename eq mysqld.exe" |find ":" > nul
if errorlevel 1 echo MySql Already Running && GOTO END
if errorlevel 0 sconsole.exe mysqld --console && echo MySql started

tasklist /fi "imagename eq nginx.exe" |find ":" > nul
if errorlevel 1 echo Nginx Already Running
if errorlevel 0 sconsole.exe nginx && echo Nginx started

tasklist /fi "imagename eq php-cgi.exe" |find ":" > nul
if errorlevel 1 echo PHP Already Running
if errorlevel 0 sconsole.exe php-cgi -b 127.0.0.1:9000 && echo PHP started

GOTO END



:STOPSERVER
tasklist /fi "imagename eq mysqld.exe" |find ":" > nul
if errorlevel 1 taskkill /F /IM mysqld.exe>NUL && echo MySql Stopped

tasklist /fi "imagename eq nginx.exe" |find ":" > nul
if errorlevel 1 taskkill /F /IM nginx.exe>NUL && echo Nginx Stopped

tasklist /fi "imagename eq php-cgi.exe" |find ":" > nul
if errorlevel 1 taskkill /F /IM php-cgi.exe>NUL && echo PHP Stopped

GOTO END

:END