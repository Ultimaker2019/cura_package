call 0_common.bat mingw32

REM *********************************************************************
REM *********************** build zlib **********************************
REM *********************************************************************
cd %SRC_PATH%
echo "zlib clone and build..."
if exist zlib (
	echo "git clone ==> zlib already exists"
	cd zlib
) else (
	git clone "https://github.com/madler/zlib"
	cd zlib
	git checkout --no-track -b Branch_v1.2.11 v1.2.11 --
)
REM rd/s/q %BUILD_PATH%\zlib
if not exist %BUILD_PATH%\zlib (
	mkdir %BUILD_PATH%\zlib
)
cd %BUILD_PATH%\zlib
cmake -DCMAKE_INSTALL_PREFIX=%INSTALL_PATH% -G"MinGW Makefiles" -DCMAKE_BUILD_TYPE=Release %SRC_PATH%/zlib
mingw32-make
mingw32-make install

REM *********************************************************************
REM *********************** build protobuf ******************************
REM *********************************************************************
cd %SRC_PATH%
echo "protobuf clone and build..."
if exist protobuf (
	echo "git clone ==> protobuf already exists"
	cd protobuf
) else (
	git clone "https://github.com/google/protobuf"
	cd protobuf
	git checkout --no-track -b B_v3.11.0-rc2 v3.11.0-rc2 --
)
cd cmake
REM rd/s/q %BUILD_PATH%\protobuf
if not exist %BUILD_PATH%\protobuf (
	mkdir %BUILD_PATH%\protobuf
)
cd %BUILD_PATH%\protobuf
cmake -DCMAKE_INSTALL_PREFIX=%INSTALL_PATH% -G"MinGW Makefiles" -DCMAKE_BUILD_TYPE=Release -Wno-dev -Dprotobuf_BUILD_TESTS=OFF %SRC_PATH%/protobuf/cmake
mingw32-make
mingw32-make install

pause
