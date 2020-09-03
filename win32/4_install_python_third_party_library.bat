call 0_common.bat msvc

pip3 install %SOFTWARE_PATH%\python\%PYTHON_VERSION%\32bit\PyQt5-5.10-5.10.0-cp35.cp36.cp37-none-win32.whl
pip3 install %SOFTWARE_PATH%\python\%PYTHON_VERSION%\32bit\Shapely-1.6.4.post2-cp35-cp35m-win32.whl
pip3 install %SOFTWARE_PATH%\python\%PYTHON_VERSION%\32bit\numpy-1.16.6+mkl-cp35-cp35m-win32.whl
pip3 install %SOFTWARE_PATH%\python\%PYTHON_VERSION%\32bit\scipy-1.4.1-cp35-cp35m-win32.whl

pip3 install -r ..\python_requirements.txt


