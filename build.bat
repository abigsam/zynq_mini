@ECHO OFF
CLS
ECHO.
ECHO #########################################################
ECHO # Build Vivado project for Zynq Mini 7020
ECHO # Part: XC7Z020CLG400-1
ECHO # Author: abigsam@gmail.com
ECHO # Vivado version: 2022.1
ECHO #########################################################
set vivado_path=C:\Xilinx\Vivado\2022.1
set build_type="create_bd"
set board_name="zynq_mini_7020"
set project_folder_name="vivado"
ECHO.
ECHO Avaliable options:
ECHO [1] Build Block design project
ECHO [2] Build RTL project (PL only)
ECHO [3] Cleanup Git repository
ECHO [4] Exit
ECHO.

CHOICE /C 1234 /N /M "Enter your choice:"
IF ERRORLEVEL 4 GOTO END
IF ERRORLEVEL 3 GOTO RUN_CLEANUP_PRJ
IF ERRORLEVEL 2 GOTO RUN_BUILD_RTL
IF ERRORLEVEL 1 GOTO RUN_BUILD_BD

:RUN_CLEANUP_PRJ
ECHO Cleanup project folder...
rmdir /s /q "%~dp0\vivado"
del "%~dp0\*.log"

:RUN_CLEANUP
ECHO Cleanup Vivado files...
del "%~dp0\*.jou"
del "%~dp0\*.dmp"
rmdir /s /q "%~dp0\.Xil"
goto END

:RUN_BUILD_RTL
set build_type="create_hdl"
:RUN_BUILD_BD
rem Run Vivado batch file with Tcl build script
rem Tcl script has two arguments:
rem - run Vivado GUI
rem - use derictive "exit" at Tcl script
rem After this, batch file changes run directory to the vivado project ("vivado/" by default) and call for Vivado with GUI
ECHO Run Tcl build script...
CALL :RUN_VIVADO_SCRIPT "%~dp0\scripts\build.tcl" %board_name% %build_type%
CALL :OPEN_VIVADO_PROJECT %project_folder_name% %board_name%
goto RUN_CLEANUP

:END
rem pause


:RUN_VIVADO_SCRIPT
    set vivado_bat_path=%vivado_path%\bin\vivado.bat
    if not exist %vivado_bat_path% (
        echo ERROR! Path %vivado_bat_path% did not found
        pause
        exit
    )
    if not exist %~1 (
        echo ERROR! Script file %~1 did not found
        pause
        exit
    )

    rem Cleanup old logs
    del "%~dp0\*.jou"
    del "%~dp0\*.log"

    call %vivado_bat_path% -mode batch -nojournal -notrace -source %~1 -tclargs %~2 %~3 %~4 %~5
EXIT /B 0


:OPEN_VIVADO_PROJECT
    if "%~2"=="" (
        set xpr_name=%~1.xpr
    ) else (
        set xpr_name=%~2.xpr
    )
    set prj_path=%~dp0\%~1\%xpr_name%
    set vivado_bat_path=%vivado_path%\bin\vivado.bat
    set vivado_vvgl_path=%vivado_path%\bin\unwrapped\win64.o\vvgl.exe
    if not exist %vivado_bat_path% (
        echo ERROR! Path %vivado_bat_path% did not found
        pause
        exit
    )
    if not exist %prj_path% (
        echo ERROR! Vivado project file %prj_path% did not found
        pause
        exit
    )
    pushd "%~dp0\%~1"
    call %vivado_vvgl_path% %vivado_bat_path% -project %prj_path%
    popd
EXIT /B 0