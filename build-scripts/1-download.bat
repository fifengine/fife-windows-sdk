@echo off

echo Downloading Build-Tools using Aria2c
echo.

build-tools\aria2\aria2c.exe -i download-lists\fifengine-build-tools.txt --conditional-get=true --allow-overwrite=false --auto-file-renaming=false

echo Downloading Dependencies using Aria2c
echo.

rem build-tools\aria2\aria2c.exe -i download-lists\fifengine-dependencies.txt --conditional-get=true --allow-overwrite=false --auto-file-renaming=false
