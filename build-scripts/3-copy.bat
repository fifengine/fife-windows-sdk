@echo off

echo.
echo == Copy
echo.

set ZIP="..\build-tools\7zip\7z.exe"
set EXTRACTED_DIR="..\extracted"
set TARGET_DIR="..\repackage"
set LIBS="..\libs\"

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
rem include Python 2.7 from Appveyor
xcopy /SIQY C:\Python27 "%TARGET_DIR%\Python27"

echo Python27.dll
rem add the mising python27.dll to the python folder
copy C:\Windows\SysWOW64\python27.dll "%TARGET_DIR%\Python27"

echo Copy needed dlls installer
copy "%LIBS%\vc_redist.x86.exe" "%TARGET_DIR%"

echo Python36
rem include Python 3.6 from Appveyor
xcopy /SIQY C:\Python36 "%TARGET_DIR%\Python36"

rem echo TDM-GCC-MINGW
rem move "%EXTRACTED_DIR%\mingw" "%TARGET_DIR%"

echo.
echo === Copying/Moving Fifengine Dependencies into the folder %TARGET_DIR%
echo.

echo Fifengine Dependencies
move "%EXTRACTED_DIR%\fifengine-includes" "%TARGET_DIR%"

echo Fifengine Python27 Installer
move "%EXTRACTED_DIR%\libfife.win32-py2.7.msi" "%TARGET_DIR%"

echo Fifengine Python36 Installer
move "%EXTRACTED_DIR%\libfife.win32-py3.6.msi" "%TARGET_DIR%"

echo Fifengine Mapeditor
move "%EXTRACTED_DIR%\fife-editor-cegui-master" "%TARGET_DIR%\mapeditor"

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
