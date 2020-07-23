call 0_common.bat mingw32

REM *********************************************************************
REM *********************** build libArcus ******************************
REM *********************************************************************
cd %SRC_PATH%
echo "libArcus clone and build..."
if exist libArcus (
	echo "git clone ==> libArcus already exists"
) else (
	git clone "https://github.com/Ultimaker2019/libArcus"
)
cd libArcus
git pull
git checkout %BUILD_VERSION%
rd/s/q %BUILD_PATH%\libArcus
if not exist %BUILD_PATH%\libArcus (
	mkdir %BUILD_PATH%\libArcus
)
cd %BUILD_PATH%\libArcus
cmake -DCMAKE_INSTALL_PREFIX=%INSTALL_PATH% -G"MinGW Makefiles" -DCMAKE_BUILD_TYPE=Release -DBUILD_STATIC=ON -DBUILD_PYTHON=OFF -DMSVC_STATIC_RUNTIME=OFF %SRC_PATH%/libArcus
mingw32-make
mingw32-make install

pause

