call 0_common.bat msvc

pip3 install %SOFTWARE_PATH%python\%PYTHON_VERSION%\64bit\PyQt5-5.10-5.10.0-cp35.cp36.cp37-none-win_amd64.whl
pip3 install %SOFTWARE_PATH%python\%PYTHON_VERSION%\64bit\Shapely-1.6.4.post2-cp35-cp35m-win_amd64.whl
pip3 install %SOFTWARE_PATH%python\%PYTHON_VERSION%\64bit\numpy-1.16.6+mkl-cp35-cp35m-win_amd64.whl
pip3 install %SOFTWARE_PATH%python\%PYTHON_VERSION%\64bit\scipy-1.4.1-cp35-cp35m-win_amd64.whl

pip3 install -r ..\python_requirements.txt


