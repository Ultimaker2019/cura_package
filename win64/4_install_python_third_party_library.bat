call 0_common.bat msvc

set CL=-FI"C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\INCLUDE\stdint.h"
cd %SOFTWARE_PATH%\python\pycrypto
python setup.py install
cd %SOFTWARE_PATH%\python\cx_Freeze
python setup.py install
cd %CUR_PATH%

pip3 install %SOFTWARE_PATH%\python\%PYTHON_VERSION%\64bit\PyQt5-5.10-5.10.0-cp35.cp36.cp37-none-win_amd64.whl
pip3 install %SOFTWARE_PATH%\python\%PYTHON_VERSION%\64bit\Shapely-1.7.1-cp37-cp37m-win_amd64.whl
pip3 install %SOFTWARE_PATH%\python\%PYTHON_VERSION%\64bit\numpy-1.19.2+mkl-cp37-cp37m-win_amd64.whl
pip3 install %SOFTWARE_PATH%\python\%PYTHON_VERSION%\64bit\scipy-1.4.1-cp37-cp37m-win_amd64.whl

pip3 install -r ..\python_requirements.txt


