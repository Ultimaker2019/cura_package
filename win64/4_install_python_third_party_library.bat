call 0_common.bat msvc

set CL=-FI"C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\INCLUDE\stdint.h"
cd %COMPILER_PATH%\python\libs\pycrypto
python setup.py install
cd %COMPILER_PATH%\python\libs\cx_Freeze
python setup.py install
cd %CUR_PATH%

pip3 install %COMPILER_PATH%\python\%PYTHON_VERSION%-libs\64bit\PyQt5-5.10-5.10.0-cp35.cp36.cp37-none-win_amd64.whl
pip3 install %COMPILER_PATH%\python\%PYTHON_VERSION%-libs\64bit\Shapely-1.7.1-cp37-cp37m-win_amd64.whl
pip3 install %COMPILER_PATH%\python\%PYTHON_VERSION%-libs\64bit\numpy-1.19.2+mkl-cp37-cp37m-win_amd64.whl
pip3 install %COMPILER_PATH%\python\%PYTHON_VERSION%-libs\64bit\scipy-1.4.1-cp37-cp37m-win_amd64.whl

pip3 install -r ..\python_requirements.txt

pip3 uninstall -y importlib_metadata
pip3 uninstall -y zipp
pip3 install importlib_metadata==1.7.0
pip3 install zipp==3.1.0

