echo off
cd win64

set CURRENT_PAN=F:
set PYTHON_VERSION=3.7.9
set CUR_PATH=%cd%

cd %CUR_PATH%
call 1_install_python_third_party_library.bat
cd %CUR_PATH%
call 2_compile_zlib_protobuf_msvc
cd %CUR_PATH%
call 3_compile_zlib_protobuf_mingw
pause
