call 0_common.bat msvc

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
git clean -df
git pull
git checkout %BUILD_VERSION%
rd/s/q %BUILD_PATH%\libArcus
if not exist %BUILD_PATH%\libArcus (
	mkdir %BUILD_PATH%\libArcus
)
cd %BUILD_PATH%\libArcus
cmake -DCMAKE_INSTALL_PREFIX=%INSTALL_PATH% -G"NMake Makefiles" -DCMAKE_BUILD_TYPE=Release -DBUILD_STATIC=ON -DBUILD_PYTHON=ON -DMSVC_STATIC_RUNTIME=ON %SRC_PATH%/libArcus
nmake
nmake install

REM *********************************************************************
REM *********************** build libSavitar ****************************
REM *********************************************************************
cd %SRC_PATH%
echo "libSavitar clone and build..."
if exist libSavitar (
	echo "git clone ==> libSavitar already exists"
) else (
	git clone "https://github.com/Ultimaker2019/libSavitar"
)
cd libSavitar
git clean -df
git pull
git checkout %BUILD_VERSION%
rd/s/q %BUILD_PATH%\libSavitar
if not exist %BUILD_PATH%\libSavitar (
	mkdir %BUILD_PATH%\libSavitar
)
cd %BUILD_PATH%\libSavitar
cmake -DCMAKE_INSTALL_PREFIX=%INSTALL_PATH% -G"NMake Makefiles" -DCMAKE_BUILD_TYPE=Release -DBUILD_STATIC=ON -DBUILD_PYTHON=ON %SRC_PATH%/libSavitar
nmake 
nmake install

REM *********************************************************************
REM *********************** build pynest2d ******************************
REM *********************************************************************
set PATH=E:\compiler_tools\boost\msvc14\include\boost-1_69;%PATH%
set Boost_INCLUDE_DIRS=E:\compiler_tools\boost\msvc14\include\boost-1_69
set CLIPPER_PATH=%INSTALL_PATH%
cd %SRC_PATH%
echo "pynest2d clone and build..."
if exist pynest2d (
	echo "git clone ==> pynest2d already exists"
) else (
	git clone "https://github.com/Ultimaker2019/pynest2d"
)
cd pynest2d
git clean -df
git pull
git checkout %BUILD_VERSION%
REM rd/s/q %BUILD_PATH%\pynest2d
if not exist %BUILD_PATH%\pynest2d (
	mkdir %BUILD_PATH%\pynest2d
)
cd %BUILD_PATH%\pynest2d
cmake -DCMAKE_INSTALL_PREFIX=%INSTALL_PATH% -G"NMake Makefiles" -Wno-dev -DCMAKE_BUILD_TYPE=Release %SRC_PATH%/pynest2d
nmake
nmake install

