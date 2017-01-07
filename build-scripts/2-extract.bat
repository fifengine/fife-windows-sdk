@echo off

echo.
echo == Extract
echo.

set ZIP="..\build-tools\7zip\x64\7za.exe"
set TARGET_DIR="..\extracted"

pushd downloads

if not exist %TARGET_DIR% (mkdir %TARGET_DIR%)

echo.
echo === Extracting Build Tools into the folder %TARGET_DIR%
echo.

echo.
echo CMake
%ZIP% x cmake.zip -o%TARGET_DIR% > nul
move "%TARGET_DIR%\cmake-*" "%TARGET_DIR%\cmake"
rd /s /q "%TARGET_DIR%\cmake\doc"
rd /s /q "%TARGET_DIR%\cmake\man"

echo.
echo Swig
%ZIP% x swig.zip -o%TARGET_DIR% > nul
move "%TARGET_DIR%\swig*" "%TARGET_DIR%\swig"
rd /s /q "%TARGET_DIR%\swig\Doc"
rd /s /q "%TARGET_DIR%\swig\Examples"

echo.
echo Strip Python 2.7
rd /s /q "C:\Python27\Doc"
rd /s /q "C:\Python27\tcl"

echo.
echo Strip Python 3.5
rd /s /q "C:\Python35\Doc"
rd /s /q "C:\Python35\tcl"

rem echo.
rem echo Python 
rem %ZIP% x ActivePython.zip -o%TARGET_DIR% > nul
rem move "%TARGET_DIR%\ActivePython-*" "%TARGET_DIR%\python-installer"

rem echo.
rem echo TDM-GCC-MINGW
rem %ZIP% x tdm-gcc.7z -o%TARGET_DIR% > nul
rem move "%TARGET_DIR%\tdm-gcc-*" "%TARGET_DIR%\mingw"

echo.
echo === Extracting Fifengine Dependencies into the folder %TARGET_DIR%
echo.

echo.
echo Fifengine Dependencies
%ZIP% x libfife-dependencies.zip -o..\extracted\fifengine-includes > nul

echo.
echo Fifengine Python27 Installer
copy libfife.win32-py2.7.msi "%TARGET_DIR%\libfife.win32-py2.7.msi"

dir "%TARGET_DIR%"

popd
