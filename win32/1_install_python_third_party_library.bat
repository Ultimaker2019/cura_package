call 0_common.bat msvc

REM *********************************************************************
REM *********************** build sip ***********************************
REM *********************************************************************
if exist %PYTHONPATH%\sip.exe (del %PYTHONPATH%\sip.exe)
if exist %PYTHONPATH%\include\sip.h (del %PYTHONPATH%\include\sip.h)
if exist %PYTHONPATH%\Lib\site-packages\sip.pyd (del %PYTHONPATH%\Lib\site-packages\sip.pyd)
if exist %PYTHONPATH%\Lib\site-packages\sip.pyi (del %PYTHONPATH%\Lib\site-packages\sip.pyi)
if exist %PYTHONPATH%\Lib\site-packages\sipdistutils.py (del %PYTHONPATH%\Lib\site-packages\sipdistutils.py)
if exist %PYTHONPATH%\Lib\site-packages\sipconfig.py (del %PYTHONPATH%\Lib\site-packages\sipconfig.py)
cd %SRC_PATH%
echo "sip clone and build..."
if exist sip (
	echo "git clone ==> sip already exists"
    cd sip
) else (
	git clone "https://github.com/Ultimaker2019/sip" sip
	cd sip
	git checkout --no-track -b B_4.19.8 4.19.8 --
)
git clean -df
python configure.py --platform win32-msvc2015
nmake
nmake install

REM *********************************************************************
REM *********************** build clipper *******************************
REM *********************************************************************
cd %SRC_PATH%
echo "clipper clone and build..."
if exist clipper (
	echo "git clone ==> clipper already exists"
	cd clipper
) else (
	git clone "https://github.com/MakerPi-3D/clipper"
	cd clipper
	git checkout --no-track -b B_6.4.2 6.4.2 --
)
git clean -df
REM rd/s/q %BUILD_PATH%\clipper
if not exist %BUILD_PATH%\clipper (
	mkdir %BUILD_PATH%\clipper
)
cd %BUILD_PATH%\clipper
cmake -DCMAKE_INSTALL_PREFIX=%INSTALL_PATH% -G"NMake Makefiles" -Wno-dev -DBUILD_SHARED_LIBS=OFF -DCMAKE_BUILD_TYPE=Release %SRC_PATH%/clipper/cpp
nmake
nmake install

REM *********************************************************************
REM *********************** build nlopt *********************************
REM *********************************************************************
cd %SRC_PATH%
echo "nlopt clone and build..."
if exist nlopt (
	echo "git clone ==> nlopt already exists"
	cd nlopt
) else (
	git clone "https://github.com/stevengj/nlopt"
	cd nlopt
	git checkout --no-track -b B_v2.6.2 v2.6.2 --
)
git clean -df
REM rd/s/q %BUILD_PATH%\nlopt
if not exist %BUILD_PATH%\nlopt (
	mkdir %BUILD_PATH%\nlopt
)
cd %BUILD_PATH%\nlopt
cmake -DCMAKE_INSTALL_PREFIX=%INSTALL_PATH% -G"NMake Makefiles" -DBUILD_SHARED_LIBS=OFF -Wno-dev -DCMAKE_BUILD_TYPE=Release %SRC_PATH%/nlopt
nmake
nmake install

REM *********************************************************************
REM *********************** build libnest2d *****************************
REM *********************************************************************
set PATH=E:\compiler_tools\boost\msvc14\include\boost-1_69;%PATH%
set Boost_INCLUDE_DIRS=E:\compiler_tools\boost\msvc14\include\boost-1_69
set CLIPPER_PATH=%INSTALL_PATH%

cd %SRC_PATH%
echo "libnest2d clone and build..."
if exist libnest2d (
	echo "git clone ==> libnest2d already exists"
	cd libnest2d
) else (
	git clone "https://github.com/Ultimaker2019/libnest2d"
	cd libnest2d
)
git clean -df
REM rd/s/q %BUILD_PATH%\libnest2d
if not exist %BUILD_PATH%\libnest2d (
	mkdir %BUILD_PATH%\libnest2d
)
cd %BUILD_PATH%\libnest2d
cmake -DCMAKE_INSTALL_PREFIX=%INSTALL_PATH% -G"NMake Makefiles" -DBUILD_SHARED_LIBS=OFF -DLIBNEST2D_HEADER_ONLY=OFF -Wno-dev -DCMAKE_BUILD_TYPE=Release %SRC_PATH%/libnest2d
nmake
nmake install

if "%PYTHON_VERSION%"=="3.7.9" (
	set CL=/FI"c:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\INCLUDE\\stdint.h" %CL%
	pip3 install pycrypto==2.6.1
	pip3 install cx_Freeze==6.3

	REM *********************************************************************
	REM *********************** install whl files ***************************
	REM *********************************************************************
	cd %CUR_PATH%
	pip3 install --no-cache-dir %COMPILER_PATH%\python\%PYTHON_VERSION%-libs\32bit\PyQt5-5.10-5.10.0-cp35.cp36.cp37-none-win32.whl
	pip3 install --no-cache-dir %COMPILER_PATH%\python\%PYTHON_VERSION%-libs\32bit\Shapely-1.7.1-cp37-cp37m-win32.whl
	pip3 install --no-cache-dir %COMPILER_PATH%\python\%PYTHON_VERSION%-libs\32bit\numpy-1.19.2+mkl-cp37-cp37m-win32.whl
	pip3 install --no-cache-dir %COMPILER_PATH%\python\%PYTHON_VERSION%-libs\32bit\scipy-1.4.1-cp37-cp37m-win32.whl
) else if "%PYTHON_VERSION%"=="3.5.9" (
	echo "This is Python3.5.9"
	pip3 install pycrypto==2.6.1
	pip3 install cx_Freeze==5.0.2

	REM *********************************************************************
	REM *********************** install whl files ***************************
	REM *********************************************************************
	cd %CUR_PATH%
	pip3 install %COMPILER_PATH%\python\%PYTHON_VERSION%-libs\32bit\PyQt5-5.10-5.10.0-cp35.cp36.cp37-none-win32.whl
	pip3 install %COMPILER_PATH%\python\%PYTHON_VERSION%-libs\32bit\Shapely-1.6.4.post2-cp35-cp35m-win32.whl
	pip3 install %COMPILER_PATH%\python\%PYTHON_VERSION%-libs\32bit\numpy-1.16.6+mkl-cp35-cp35m-win32.whl
	pip3 install %COMPILER_PATH%\python\%PYTHON_VERSION%-libs\32bit\scipy-1.4.1-cp35-cp35m-win32.whl
)
pip3 install --no-cache-dir -r ..\python_requirements.txt



