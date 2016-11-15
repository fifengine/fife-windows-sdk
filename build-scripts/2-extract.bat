@echo off

echo.
echo == Extract
echo.

set ZIP="..\build-tools\7zip\x64\7za.exe"
set TARGET_DIR="..\extracted"

pushd downloads

rem dir

if not exist %TARGET_DIR% (mkdir %TARGET_DIR%)

echo.
echo ### Extracting Build Tools into the folder %TARGET_DIR%
echo.

echo.
echo CMake
%ZIP% x cmake.zip -o%TARGET_DIR% > nul
move "%TARGET_DIR%\cmake-*" "%TARGET_DIR%\cmake"

echo.
echo Swig
%ZIP% x swig.zip -o%TARGET_DIR% > nul
move "%TARGET_DIR%\swig*" "%TARGET_DIR%\swig"

rem echo.
rem echo Python 
rem %ZIP% x ActivePython.zip -o%TARGET_DIR% > nul
rem move "%TARGET_DIR%\ActivePython-*" "%TARGET_DIR%\python-installer"

rem echo.
rem echo TDM-GCC-MINGW
rem %ZIP% x tdm-gcc.7z -o%TARGET_DIR% > nul
rem move "%TARGET_DIR%\tdm-gcc-*" "%TARGET_DIR%\mingw"

echo.
echo ### Extracting Dependencies of Fifengine into the folder %TARGET_DIR%
echo.

popd