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

curl "https://raw.githubusercontent.com/PvtSec/NginxSetup/main/nginx.conf" -o "C:\Server\nginx\conf\nginx.conf"
curl "https://raw.githubusercontent.com/PvtSec/NginxSetup/main/php.ini" -o "C:\Server\php\php.ini"
curl "https://raw.githubusercontent.com/PvtSec/NginxSetup/main/server.bat" -o "C:\Server\nginx\server.bat"
curl "https://raw.githubusercontent.com/PvtSec/NginxSetup/main/sconsole.exe" -o "C:\Server\nginx\sconsole.exe"
curl "https://raw.githubusercontent.com/PvtSec/NginxSetup/main/check.php" -o "C:\Server\nginx\html\check.php"
curl "https://raw.githubusercontent.com/PvtSec/NginxSetup/main/config.inc.php" -o "C:\Server\pma\config.inc.php"

del nginx.zip
del mysql.zip
del php.zip
del phpmyadmin.zip
cls

runtime.exe
echo Please wait, background process is active
C:\Server\mysql\bin\mysqld --initialize-insecure
start C:\Server\mysql\bin\mysqld --console
echo       ###################################
echo       #                                 #
echo       # Please wait for 30s. Don't exit #
echo       #                                 #
echo       ###################################
TIMEOUT /T 30
C:\Server\mysql\bin\mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY ''; FLUSH PRIVILEGES;"

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
