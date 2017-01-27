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

echo.
echo === Copying/Moving Build Tools into the folder %TARGET_DIR%
echo.

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

echo Copy needed dlls vcruntime140.dll msvcp140.dll
mkdir "%TARGET_DIR%\Python27\Lib\site-packages\fife"
copy "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\redist\x86\Microsoft.VC140.CRT\vcruntime140.dll" "%TARGET_DIR%\Python27\Lib\site-packages\fife\vcruntime140.dll"
copy "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\redist\x86\Microsoft.VC140.CRT\msvcp140.dll" "%TARGET_DIR%\Python27\Lib\site-packages\fife\msvcp140.dll"

rem echo Python35
rem include Python from Appveyor
rem xcopy /SIQY C:\Python35 "%TARGET_DIR%\Python35"

rem echo TDM-GCC-MINGW
rem move "%EXTRACTED_DIR%\mingw" "%TARGET_DIR%"

echo.
echo === Copying/Moving Fifengine Dependencies into the folder %TARGET_DIR%
echo.

echo Fifengine Dependencies
move "%EXTRACTED_DIR%\fifengine-includes" "%TARGET_DIR%"

echo Fifengine Python27 Installer 
move "%EXTRACTED_DIR%\libfife.win32-py2.7.msi" "%TARGET_DIR%"

rem echo Fifengine Python34 Installer 
rem move "%EXTRACTED_DIR%\libfife.win32-py3.4.msi" "%TARGET_DIR%"

echo Fifengine Mapeditor
move "%EXTRACTED_DIR%\fifengine-editor-master" "%TARGET_DIR%\mapeditor"

echo Fifengine Python Demos
move "%EXTRACTED_DIR%\fifengine-demos-master" "%TARGET_DIR%\python-demos"

echo Fifengine Python Tutorials
move "%EXTRACTED_DIR%\python-tutorials-master" "%TARGET_DIR%\python-tutorials"

rem echo Fifengine C++ Tutorials
rem move "%EXTRACTED_DIR%\cpp-tutorials-master" "%TARGET_DIR%\cpp-tutorials"

rem echo Fifengine Atlas Creator
rem move "%EXTRACTED_DIR%\fifengine-atlas-creator*" "%TARGET_DIR%\atlascreator"

rem echo Fifengine Documentations
rem move "%EXTRACTED_DIR%\*.pdf" "%TARGET_DIR%\docs"

popd
