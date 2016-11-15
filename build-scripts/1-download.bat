@echo off

echo.
echo == Download
echo.

echo.
echo === Downloading Build-Tools using Aria2c
echo.

build-tools\aria2\aria2c.exe -i download-lists\fifengine-build-tools.txt --conditional-get=true --allow-overwrite=false --auto-file-renaming=false

echo.
echo === Downloading Fifengine using Aria2c
echo.

build-tools\aria2\aria2c.exe -i download-lists\fifengine.txt --conditional-get=true --allow-overwrite=false --auto-file-renaming=false
