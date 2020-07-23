echo off
set SOFTWARE_PATH=E:\Ultimaker\software
set COMPILER_PATH=E:\Ultimaker\compiler_tools
set PYTHONPATH=E:\Ultimaker\compiler_tools\python-3.5.9\amd64
set CUR_PATH=%cd%
set SRC_PATH=%CUR_PATH%\..\..\sources
set BUILD_VERSION=4.6.2_L-DEVO 
set CMAKE_DEFINES=-DCURA_VERSION_MAJOR=4
set CMAKE_DEFINES=%CMAKE_DEFINES% -DCURA_VERSION_MINOR=6
set CMAKE_DEFINES=%CMAKE_DEFINES% -DCURA_VERSION_PATCH=2

set PATH=C:\Program Files\CMake\bin;
set PATH=C:\Program Files (x86)\NSIS;%PATH%
set PATH=C:\Program Files\Git\cmd;%PATH%
set PATH=%PYTHONPATH%;%PATH%
set PATH=%PYTHONPATH%\Scripts;%PATH%
set PATH=%PYTHONPATH%\Lib\site-packages;%PATH%

set TCL_LIBRARY=%PYTHONPATH%\tcl
set TK_LIBRARY=%PYTHONPATH%\tk

REM cryptography by default links to OpenSSL 1.1.0 which has different library
REM file names, so we need this flag to be able to link to OpenSSL 1.0.2
set CRYPTOGRAPHY_WINDOWS_LINK_LEGACY_OPENSSL=1

if "%1" == "" goto mingw32
if /i %1 == mingw32       goto mingw32
if /i %1 == msvc     goto msvc
goto mingw32

:msvc
set BUILD_PATH=%CUR_PATH%\..\..\build_win64\msvc
set INSTALL_PATH=%CUR_PATH%\..\..\build_win64\msvc\install
set PATH=%INSTALL_PATH%\bin;%PATH%
set PATH=C:\Windows\SysWOW64;%PATH%
set PATH=D:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\bin;%PATH%
call "D:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" amd64
goto end

:mingw32
set BUILD_PATH=%CUR_PATH%\..\..\build_win64\mingw32
set INSTALL_PATH=%CUR_PATH%\..\..\build_win64\mingw32\install
set PATH=%INSTALL_PATH%\bin;%PATH%
set PATH=%COMPILER_PATH%\mingw-w64\x86_64-7.3.0-posix-seh-rt_v5-rev0\mingw64\bin;%PATH%
goto end

:end
if not exist %SRC_PATH% (
	mkdir %SRC_PATH%
)

if not exist %BUILD_PATH% (
	mkdir %BUILD_PATH%
)

if not exist %INSTALL_PATH% (
	mkdir %INSTALL_PATH%
)

