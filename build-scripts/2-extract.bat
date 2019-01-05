@echo off

echo.
echo == Extract
echo.

set ZIP="..\build-tools\7zip\x64\7z.exe"
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

echo.
echo Swig
%ZIP% x swig.zip -o%TARGET_DIR% > nul
move "%TARGET_DIR%\swig*" "%TARGET_DIR%\swig"

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

echo.
echo Fifengine Python36 Installer
copy libfife.win32-py3.6.msi "%TARGET_DIR%\libfife.win32-py3.6.msi"

echo.
echo Fifengine Mapeditor
rem extracts folder "fifengine-editor-master"
%ZIP% x fifengine-editor.zip -o..\extracted > nul

echo.
echo Fifengine Python Demos
rem extracts folder "fifengine-demos-master"
%ZIP% x fifengine-demos.zip -o..\extracted > nul

echo.
echo Fifengine Python Tutorials
rem extracts folder "python-tutorials-master"
%ZIP% x python-tutorials.zip -o..\extracted > nul

rem echo.
rem echo Fifengine C++ Tutorials
rem %ZIP% x cpp-tutorials.zip -o..\extracted > nul

rem echo.
rem echo Fifengine Atlas Creator
rem %ZIP% x ?.zip -o..\extracted\fifengine-atlas-creator > nul

rem echo.
rem echo Fifengine Documentations
rem %ZIP% x ?.zip -o..\extracted\.pdf > nul

popd
