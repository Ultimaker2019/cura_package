echo off
cd win32

set CURRENT_PAN=E:
set BUILD_VERSION=makerpi
set CMAKE_DEFINES=-DCURA_VERSION_MAJOR=4
set CMAKE_DEFINES=%CMAKE_DEFINES% -DCURA_VERSION_MINOR=6
set CMAKE_DEFINES=%CMAKE_DEFINES% -DCURA_VERSION_PATCH=2
set PYTHON_VERSION=python-3.7.9
set CUR_PATH=%cd%


cd %CUR_PATH%
call 7_compile_and_package_cura
cd %CUR_PATH%
call 0_common.bat
move %PACKAGE_PATH%\build_32\*-amd32.exe %CUR_PATH%\..\
pause