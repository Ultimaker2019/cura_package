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
if exist sip_64 (
	echo "git clone ==> sip already exists"
    cd sip_64
) else (
	git clone "https://github.com/Ultimaker2019/sip" sip_64
	cd sip_64
	git checkout --no-track -b B_4.19.8 4.19.8 --
)
python configure.py --platform win32-msvc2015
nmake
nmake install

pause
