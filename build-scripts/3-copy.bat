@echo off

echo.
echo == Copy
echo.

set ZIP="..\build-tools\7zip\7za.exe"
set EXTRACTED_DIR="..\extracted"
set TARGET_DIR="..\repackage"

echo.
echo === Prepare repackaging folder %TARGET_DIR%
echo.

pushd extracted

if not exist %TARGET_DIR% (mkdir %TARGET_DIR%)

echo CMake 
move "%EXTRACTED_DIR%\cmake" "%TARGET_DIR%"

echo Swig
move "%EXTRACTED_DIR%\swig" "%TARGET_DIR%"

echo Python27
rem include Python from Appveyor
xcopy /SIQY C:\Python27 "%TARGET_DIR%\Python27"

echo Python27.dll
rem add the mising python27.dll to the python folder
copy C:\Windows\SysWOW64\python27.dll "%TARGET_DIR%\Python27"

echo Python35
rem include Python from Appveyor
xcopy /SIQY C:\Python35 "%TARGET_DIR%\Python35"

rem echo TDM-GCC-MINGW
rem move "%EXTRACTED_DIR%\mingw" "%TARGET_DIR%"

echo Fifengine Dependencies
move "%EXTRACTED_DIR%\fifengine-includes" "%TARGET_DIR%"

echo Fifengine Python27 Installer 
move "%EXTRACTED_DIR%\libfife.win32-py2.7.msi" "%TARGET_DIR%"

popd
