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
echo Python37
rd /s /q "..\repackage\Python37\Doc"
rd /s /q "..\repackage\Python37\tcl"

popd
