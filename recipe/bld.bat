@echo on

dir %RECIPE_DIR%

echo %LIB%

:: Explicitly Set path to f2py and Fortran compiler
if exist %PREFIX%\Scripts\f2py.exe (
  set F2PY=%PREFIX%\Scripts\f2py.exe
) else (
  set F2PY=%PREFIX%\Scripts\f2py.bat
)

set FC=%BUILD_PREFIX%\Library\bin\flang.exe

:: remove chocolatey gfortran
if "%CI%" == "azure" (
  rm "C:\ProgramData\Chocolatey\bin\gfortran.exe"
)

mkdir "%SRC_DIR%\dist"

"%PYTHON%" setup.py bdist_wheel ^
           --dist-dir="%SRC_DIR%\dist" ^
           -G "NMake Makefiles" ^
           -- ^
           -DCMAKE_Fortran_COMPILER:FILEPATH="%FC%" ^
           -DF2PY_EXECUTABLE:FILEPATH="%F2PY%"

"%PYTHON%" -m pip install ^
           --no-index ^
           --find-links="%SRC_DIR%\dist" ^
           fastscapelib_fortran ^
           -vvv

if errorlevel 1 exit 1
