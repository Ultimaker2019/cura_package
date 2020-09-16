echo off
cd win64

set CURRENT_PAN=E:
set BUILD_VERSION=makerpi
set CMAKE_DEFINES=-DCURA_VERSION_MAJOR=4
set CMAKE_DEFINES=%CMAKE_DEFINES% -DCURA_VERSION_MINOR=6
set CMAKE_DEFINES=%CMAKE_DEFINES% -DCURA_VERSION_PATCH=2
set PYTHON_VERSION=3.7.9
set CUR_PATH=%cd%

cd %CUR_PATH%
call 1_compile_sip.bat
cd %CUR_PATH%
call 2_compile_zlib_protobuf_msvc
cd %CUR_PATH%
call 3_compile_zlib_protobuf_mingw
cd %CUR_PATH%
call 4_install_python_third_party_library
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
