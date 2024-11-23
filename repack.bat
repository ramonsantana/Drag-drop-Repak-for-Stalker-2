@echo off
setlocal

rem Check if a folder was dragged onto the script
if "%~1"=="" (
    echo Please drag and drop a folder onto this script.
    pause
    exit /B
)

rem Extract folder name and path
set "folder=%~1"
set "foldername=%~nx1"

rem Check if there are any .json files in the folder
set "jsonFilesFound=0"
for /r "%folder%" %%f in (*.json) do (
    set "jsonFilesFound=1"
    rem Rename the .json files to .cfg
    ren "%%f" "%%~nf.cfg"
)

rem Check if repak.exe is in the current directory or in the PATH
where /q repak.exe
if errorlevel 1 (
    echo repak.exe not found in the current directory or PATH. Please ensure repak.exe is accessible.
    pause
    exit /B
)

rem Run the repak.exe command with the appropriate parameters
if "%jsonFilesFound%"=="1" (
    echo Renamed .json files to .cfg.
    echo.
    echo ************************
    echo *Proceeding with repack*
    echo ************************
    echo.
) else (
    echo No .json files found to rename to .cfg.
    echo.
    echo ************************
    echo *Proceeding with repack*
    echo ************************
    echo.
)

repak.exe pack --version V11 "%folder%/" "%foldername%.pak"
echo.
echo Command executed: repak.exe pack --version V11 %folder%/ %foldername%.pak
echo.
pause
