@echo off

curl http://nginx.org/download/nginx-1.18.0.zip -o nginx.zip
curl https://windows.php.net/downloads/releases/php-8.0.0-nts-Win32-vs16-x64.zip -o php.zip
curl https://cdn.mysql.com//Downloads/MySQL-8.0/mysql-8.0.21-winx64.zip -o mysql.zip
curl https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-all-languages.zip -o phpmyadmin.zip
curl -L https://aka.ms/vs/16/release/VC_redist.x64.exe -o runtime.exe

setx path "%path%;C:\Server\nginx;C:\Server\php;C:\Server\mysql\bin"

setlocal
cd /d %~dp0
Call :UnZipFile "C:\Server\" "C:\Users\Administrator\Desktop\nginx.zip"
ren "C:\Server\nginx-1.18.0" nginx

Call :UnZipFile "C:\Server\" "C:\Users\Administrator\Desktop\mysql.zip"
ren "C:\Server\mysql-8.0.21-winx64" mysql

Call :UnZipFile "C:\Server\php" "C:\Users\Administrator\Desktop\php.zip"

Call :UnZipFile "C:\Server\" "C:\Users\Administrator\Desktop\phpmyadmin.zip"
ren "C:\Server\phpMyAdmin-5.0.2-all-languages" pma

curl "https://gist.githubusercontent.com/PvtSec/1bcef291de0a4b380fec782933fb4aee/raw/d4cf5fd4225973bba47699ba6ce5398cf96aa448/nginx_configuration.conf" -o "C:\Server\nginx\conf\nginx.conf"
curl "https://gist.githubusercontent.com/PvtSec/1c7f969723f4a344cd9c05125a3807fa/raw/e7dcfa8c6cea48dfb3be25d2d3130159b054ea95/php_config.ini" -o "C:\Server\php\php.ini"
curl "https://gist.githubusercontent.com/PvtSec/675b006192b37656c0a4385bbb228a7b/raw/326edf3e687284251729619351f894340a44041d/server.bat" -o "C:\Server\nginx\server.bat"

mysqld --initialize-insecure
mysqld --console

exit /b

:UnZipFile <ExtractTo> <newzipfile>
set vbs="%temp%\_.vbs"
if exist %vbs% del /f /q %vbs%
>%vbs%  echo Set fso = CreateObject("Scripting.FileSystemObject")
>>%vbs% echo If NOT fso.FolderExists(%1) Then
>>%vbs% echo fso.CreateFolder(%1)
>>%vbs% echo End If
>>%vbs% echo set objShell = CreateObject("Shell.Application")
>>%vbs% echo set FilesInZip=objShell.NameSpace(%2).items
>>%vbs% echo objShell.NameSpace(%1).CopyHere(FilesInZip)
>>%vbs% echo Set fso = Nothing
>>%vbs% echo Set objShell = Nothing
cscript //nologo %vbs%
if exist %vbs% del /f /q %vbs%