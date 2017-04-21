@echo off

echo.
echo == Stripdown
echo.

echo.
echo === Stripping packages in ..\repackage
echo.

pushd repackage

echo.
echo CMake
rd /s /q "..\repackage\cmake\doc"
rd /s /q "..\repackage\cmake\man"

echo.
echo Swig
rd /s /q "..\repackage\swig\Doc"
rd /s /q "..\repackage\swig\Examples"

echo.
echo Python27
rd /s /q "..\repackage\Python27\Doc"
rd /s /q "..\repackage\Python27\tcl"
rd /s /q "..\repackage\Python27\Scripts"
rd /s /q "..\repackage\Python27\Tools"
rm       "..\repackage\Python27\NEWS.txt"
rm       "..\repackage\Python27\w9xpopen.exe"

echo.
echo Python34
rd /s /q "..\repackage\Python34\Doc"
rd /s /q "..\repackage\Python34\tcl"

popd
