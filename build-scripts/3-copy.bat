@echo off

echo.
echo == Copy for Packaging
echo.

set ZIP="..\build-tools\7zip\7za.exe"
set EXTRACTED_DIR="..\extracted"
set TARGET_DIR="..\repackage\build-tools"

echo.
echo Prepare "build-tools" folder %TARGET_DIR%

pushd extracted

mkdir %TARGET_DIR%

echo CMake 
move "%EXTRACTED_DIR%\cmake" "%TARGET_DIR%"

echo Swig
move "%EXTRACTED_DIR%\swig" "%TARGET_DIR%"

echo Python 
move "%EXTRACTED_DIR%\python-installer" "%TARGET_DIR%"

echo TDM-GCC-MINGW
move "%EXTRACTED_DIR%\mingw" "%TARGET_DIR%"

popd