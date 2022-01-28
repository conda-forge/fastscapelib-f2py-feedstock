@echo on

dir %RECIPE_DIR%

echo %LIB%

mkdir "%SRC_DIR%\dist"

"%PYTHON%" setup.py bdist_wheel ^
           --dist-dir="%SRC_DIR%\dist" ^
           -G "NMake Makefiles" ^

"%PYTHON%" -m pip install ^
           --no-index ^
           --find-links="%SRC_DIR%\dist" ^
           fastscapelib_fortran ^
           -vvv

if errorlevel 1 exit 1
