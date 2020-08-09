echo off
set SOFTWARE_PATH=C:\\Users\\edwar\\OneDrive\\software
set COMPILER_PATH=C:\Users\edwar\OneDrive\compiler_tools
set PYTHONPATH=%COMPILER_PATH%\python-3.5.9\win32
set CUR_PATH=%cd%
set SRC_PATH=C:\Users\edwar\OneDrive\work\ultimaker\sources
set BUILD_ROOT_PATH=C:\Users\edwar\OneDrive\work\ultimaker
set BUILD_VERSION=4.6.2_L-DEVO
set PACKAGE_PATH=%cd%\..\..\package
set CMAKE_DEFINES=-DCURA_VERSION_MAJOR=4
set CMAKE_DEFINES=%CMAKE_DEFINES% -DCURA_VERSION_MINOR=6
set CMAKE_DEFINES=%CMAKE_DEFINES% -DCURA_VERSION_PATCH=2

set PATH=C:\Program Files\CMake\bin;
set PATH=C:\Program Files (x86)\NSIS3;%PATH%
set PATH=C:\Program Files\Git\cmd;%PATH%
set PATH=%COMPILER_PATH%\cygwin64\bin;%PATH%
set PATH=%COMPILER_PATH%\mingw32\msys\1.0\bin;%PATH%
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
set BUILD_PATH=%BUILD_ROOT_PATH%\build_win32\msvc
set INSTALL_PATH=%BUILD_ROOT_PATH%\build_win32\msvc\install
set PATH=%INSTALL_PATH%\bin;%PATH%
set PATH=C:\Windows\System32;%PATH%
set PATH=C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\bin;%PATH%
call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" x86
goto end

:mingw32
set BUILD_PATH=%BUILD_ROOT_PATH%\build_win32\mingw32
set INSTALL_PATH=%BUILD_ROOT_PATH%\build_win32\mingw32\install
set PATH=%INSTALL_PATH%\bin;%PATH%
set PATH=%COMPILER_PATH%\mingw-w64\i686-7.3.0-posix-dwarf-rt_v5-rev0\mingw32\bin;%PATH%
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

