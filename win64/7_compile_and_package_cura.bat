call 0_common.bat mingw32

REM *********************************************************************
REM *********************** build cura-build ****************************
REM *********************************************************************
cd %SRC_PATH%
echo "cura-build clone and build..."
if exist cura-build (
	echo "git clone ==> cura-build already exists"
) else (
	git clone "https://github.com/Ultimaker2019/cura-build"
)
cd cura-build
git checkout origin/%BUILD_VERSION%
pause
cd %CUR_PATH%\..\..
mkdir package\build64
cd package\build64
set PYTHONPATH=%cd%\inst\lib\python3.5\site-packages
set PATH=%cd%\inst\bin;%PATH%
set CFLAGS=-m64
set CXXFLAGS=-m64
set LDFLAGS=-m64
set CMAKE_DEFINES=-DCURA_VERSION_MAJOR=4
set CMAKE_DEFINES=%CMAKE_DEFINES% -DCURA_VERSION_MINOR=4
set CMAKE_DEFINES=%CMAKE_DEFINES% -DCURA_VERSION_PATCH=0
set CMAKE_DEFINES=%CMAKE_DEFINES% -DFDMMATERIALS_BRANCH_OR_TAG=4.4
set CMAKE_DEFINES=%CMAKE_DEFINES% -DCURABINARYDATA_BRANCH_OR_TAG=4.4
set CMAKE_DEFINES=%CMAKE_DEFINES% -DCURAENGINE_BRANCH_OR_TAG=4.4
set CMAKE_DEFINES=%CMAKE_DEFINES% -DURANIUM_BRANCH_OR_TAG=4.4
set CMAKE_DEFINES=%CMAKE_DEFINES% -DLIBCHARON_BRANCH_OR_TAG=4.4
set CMAKE_DEFINES=%CMAKE_DEFINES% -DCURA_BRANCH_OR_TAG=4.4
set CMAKE_DEFINES=%CMAKE_DEFINES% -DCMAKE_SH="CMAKE_SH-NOTFOUND"
set CMAKE_DEFINES=%CMAKE_DEFINES% -DCMAKE_PREFIX_PATH="E:\Ultimaker\software\OpenCTM 1.0.3"
set CMAKE_DEFINES=%CMAKE_DEFINES% -DCMAKE_INSTALL_PREFIX=E:\Ultimaker
set CMAKE_DEFINES=%CMAKE_DEFINES% -DCMAKE_BUILD_TYPE=Release
set CMAKE_DEFINES=%CMAKE_DEFINES% -DSIGN_PACKAGE=OFF
set CMAKE_DEFINES=%CMAKE_DEFINES% -DBUILD_PACKAGE=ON
set CMAKE_DEFINES=%CMAKE_DEFINES% -DCPACK_GENERATOR=NSIS64
cmake -G "MinGW Makefiles" %CMAKE_DEFINES% -Wno-dev %SRC_PATH%/cura-build
mingw32-make package

pause

