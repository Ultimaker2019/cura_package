echo off
cd win64

set CURRENT_PAN=F:
set BUILD_VERSION=l-devo
set CMAKE_DEFINES=-DCURA_VERSION_MAJOR=4
set CMAKE_DEFINES=%CMAKE_DEFINES% -DCURA_VERSION_MINOR=6
set CMAKE_DEFINES=%CMAKE_DEFINES% -DCURA_VERSION_PATCH=4
set PYTHON_VERSION=3.7.9
set CUR_PATH=%cd%

cd %CUR_PATH%
call 5_compile_cura_python_moudles
cd %CUR_PATH%
call 6_compile_cura_dependency
cd %CUR_PATH%
call 7_compile_and_package_cura
cd %CUR_PATH%
call 0_common.bat
move %PACKAGE_PATH%\build_64\*-amd64.exe %CUR_PATH%\..\
pause
