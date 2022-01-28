@echo on

dir %RECIPE_DIR%

echo %LIB%

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
