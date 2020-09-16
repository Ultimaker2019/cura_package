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
REM *********************** build pycrypto ******************************
REM *********************************************************************
set CL=-FI"C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\INCLUDE\stdint.h"
cd %SRC_PATH%
echo "pycrypto clone and build..."
if exist pycrypto (
	echo "git clone ==> pycrypto already exists"
    cd pycrypto
) else (
	git clone "https://github.com/pycrypto/pycrypto" pycrypto
	cd pycrypto
	git checkout --no-track -b B_v2.6.1 v2.6.1 --
)
git clean -df
python setup.py install

REM *********************************************************************
REM *********************** build cx_Freeze *****************************
REM *********************************************************************
cd %SRC_PATH%
echo "cx_Freeze clone and build..."
if exist cx_Freeze (
	echo "git clone ==> cx_Freeze already exists"
    cd cx_Freeze
) else (
	git clone "https://github.com/marcelotduarte/cx_Freeze" cx_Freeze
	cd cx_Freeze
REM	git checkout --no-track -b B_v2.6.1 v2.6.1 --
)
git clean -df
python setup.py install
pip3 uninstall -y cx-Logging
pip3 uninstall -y importlib_metadata
pip3 uninstall -y zipp
pip3 install cx-Logging==2.2
pip3 install importlib_metadata==1.7.0
pip3 install zipp==3.1.0

REM *********************************************************************
REM *********************** install whl files ***************************
REM *********************************************************************
cd %CUR_PATH%
pip3 install %COMPILER_PATH%\python\%PYTHON_VERSION%-libs\64bit\PyQt5-5.10-5.10.0-cp35.cp36.cp37-none-win_amd64.whl
pip3 install %COMPILER_PATH%\python\%PYTHON_VERSION%-libs\64bit\Shapely-1.7.1-cp37-cp37m-win_amd64.whl
pip3 install %COMPILER_PATH%\python\%PYTHON_VERSION%-libs\64bit\numpy-1.19.2+mkl-cp37-cp37m-win_amd64.whl
pip3 install %COMPILER_PATH%\python\%PYTHON_VERSION%-libs\64bit\scipy-1.4.1-cp37-cp37m-win_amd64.whl

pip3 install -r ..\python_requirements.txt



