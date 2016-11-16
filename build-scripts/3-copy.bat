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

rem echo Python 
rem move "%EXTRACTED_DIR%\python-installer" "%TARGET_DIR%"

rem echo TDM-GCC-MINGW
rem move "%EXTRACTED_DIR%\mingw" "%TARGET_DIR%"

popd