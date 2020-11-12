call 0_common.bat mingw32

REM *********************************************************************
REM *********************** build cura-build ****************************
REM *********************************************************************
set CURA_BINARY_DATA_DIRECTORY=F:/ultimaker/3_package/build_64/cura-binary-data-prefix/src/cura-binary-data
set GETTEXT_MSGINIT_EXECUTABLE=E:/compiler_tools/mingw32/msys/1.0/bin/msginit.exe

cd %SRC_PATH%
echo "cura-build clone and build..."
if exist cura-build (
	echo "git clone ==> cura-build already exists"
) else (
	git clone "https://github.com/Ultimaker2019/cura-build"
)
cd cura-build
git pull
git checkout %BUILD_VERSION%

cd %CUR_PATH%\..\..

if not exist %PACKAGE_PATH%\build_32 (
	mkdir %PACKAGE_PATH%\build_32
)

if exist %PACKAGE_PATH%\build_32\cura-binary-data-prefix\src\cura-binary-data (
	cd %PACKAGE_PATH%\build_32\cura-binary-data-prefix\src\cura-binary-data
	git pull
	git checkout %BUILD_VERSION%
)

if exist %PACKAGE_PATH%\build_32\CuraEngine-prefix\src\CuraEngine (
	cd %PACKAGE_PATH%\build_32\CuraEngine-prefix\src\CuraEngine
	git pull
	git checkout %BUILD_VERSION%
)

if exist %PACKAGE_PATH%\build_32\Cura-prefix\src\Cura (
	cd %PACKAGE_PATH%\build_32\Cura-prefix\src\Cura
	git pull
	git checkout %BUILD_VERSION%
)

if exist %PACKAGE_PATH%\build_32\fdm_materials-prefix\src\fdm_materials (
	cd %PACKAGE_PATH%\build_32\fdm_materials-prefix\src\fdm_materials
	git pull
	git checkout %BUILD_VERSION%
)

if exist %PACKAGE_PATH%\build_32\libCharon-prefix\src\libCharon (
	cd %PACKAGE_PATH%\build_32\libCharon-prefix\src\libCharon
	git pull
	git checkout %BUILD_VERSION%
)

if exist %PACKAGE_PATH%\build_32\Uranium-prefix\src\Uranium (
	cd %PACKAGE_PATH%\build_32\Uranium-prefix\src\Uranium
	git pull
	git checkout %BUILD_VERSION%
)

cd %PACKAGE_PATH%\build_32
set PYTHONPATH=%cd%\inst\lib\python3.5\site-packages
set PATH=%cd%\inst\bin;%PATH%
set CMAKE_DEFINES=%CMAKE_DEFINES% -DFDMMATERIALS_BRANCH_OR_TAG=%BUILD_VERSION%
set CMAKE_DEFINES=%CMAKE_DEFINES% -DCURABINARYDATA_BRANCH_OR_TAG=%BUILD_VERSION%
set CMAKE_DEFINES=%CMAKE_DEFINES% -DCURAENGINE_BRANCH_OR_TAG=%BUILD_VERSION%
set CMAKE_DEFINES=%CMAKE_DEFINES% -DURANIUM_BRANCH_OR_TAG=%BUILD_VERSION%
set CMAKE_DEFINES=%CMAKE_DEFINES% -DLIBCHARON_BRANCH_OR_TAG=%BUILD_VERSION%
set CMAKE_DEFINES=%CMAKE_DEFINES% -DCURA_BRANCH_OR_TAG=%BUILD_VERSION%
set CMAKE_DEFINES=%CMAKE_DEFINES% -DCMAKE_SH="CMAKE_SH-NOTFOUND"
set CMAKE_DEFINES=%CMAKE_DEFINES% -DCMAKE_PREFIX_PATH="%COMPILER_PATH%/program-files/OpenCTM 1.0.3"
set CMAKE_DEFINES=%CMAKE_DEFINES% -DCMAKE_INSTALL_PREFIX=%CUR_PATH%
set CMAKE_DEFINES=%CMAKE_DEFINES% -DCMAKE_BUILD_TYPE=Release
set CMAKE_DEFINES=%CMAKE_DEFINES% -DSIGN_PACKAGE=OFF
set CMAKE_DEFINES=%CMAKE_DEFINES% -DBUILD_PACKAGE=ON
set CMAKE_DEFINES=%CMAKE_DEFINES% -DCPACK_GENERATOR=NSIS
cmake -G "MinGW Makefiles" %CMAKE_DEFINES% -Wno-dev %SRC_PATH%/cura-build
mingw32-make package

pause

