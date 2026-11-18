
@echo off
setlocal EnableDelayedExpansion
chcp 65001 >nul 


:: Terminal colors (ANSI)
for /f %%a in ('echo prompt $E^| cmd') do set "ESC=%%a"

set "CYAN=%ESC%[96m"
set "GREEN=%ESC%[92m"
set "YELLOW=%ESC%[93m"
set "RED=%ESC%[91m"
set "WHITE=%ESC%[97m"
set "GRAY=%ESC%[90m"
set "RESET=%ESC%[0m"
set "BOLD=%ESC%[1m"

:: Clear terminal
cls

echo %CYAN%%BOLD%
                                 
echo        ███████╗██╗██╗     ███████╗███████╗
echo        ██╔════╝██║██║     ██╔════╝██╔════╝
echo        █████╗  ██║██║     █████╗  ███████╗
echo        ██╔══╝  ██║██║     ██╔══╝  ╚════██║
echo        ██║     ██║███████╗███████╗███████║
echo        ╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝  
echo %RESET%

echo %CYAN%=======================================================%RESET%
echo %WHITE%%BOLD%         FILE ORGANIZER         by: k.virakboth%RESET%
echo %CYAN%=======================================================%RESET%

echo %GRAY%       Organize your files automatically%RESET%
echo.
echo %WHITE%  [-] Photos             JPG, PNG, JPEG
echo %WHITE%  [-] Documents          DOC, PDF, XLSX
echo %WHITE%  [-] Applications       EXE, MSI, APK
echo %WHITE%  [-] Others             Other file types
echo %CYAN%-------------------------------------------------------%RESET%

:: Input instructions
echo.
echo %GRAY%  [INPUT INSTRUCTIONS]%RESET%
echo %GRAY%  Enter the full path of the folder to organize.%RESET%
echo %GRAY%  Example: C:\Users\YourName\Downloads%RESET%
echo.
set /p "folder=%CYAN%  Enter folder path => %WHITE%"

:: Remove surrounding quotes
set "folder=%folder:"=%"

:: Validate folder
if not exist "%folder%\" (
    echo.
    echo %RED%  [ERROR] Folder does not exist!%RESET%
    goto end
)

:: Counters
set /a count=0

echo.
echo %YELLOW%  Organizing files...%RESET%
echo.

:: Loop through files only
for /f "delims=" %%i in ('dir /b /a-d "%folder%" 2^>nul') do (

    set "extension=%%~xi"
    set "folder_name=Others"

    :: Determine destination folder
    if /i "!extension!"==".jpg" set "folder_name=Photos"
    if /i "!extension!"==".png" set "folder_name=Photos"
    if /i "!extension!"==".jpeg" set "folder_name=Photos"

    if /i "!extension!"==".doc" set "folder_name=Documents"
    if /i "!extension!"==".pdf" set "folder_name=Documents"
    if /i "!extension!"==".xlsx" set "folder_name=Documents"

    if /i "!extension!"==".exe" set "folder_name=Applications"
    if /i "!extension!"==".msi" set "folder_name=Applications"
    if /i "!extension!"==".apk" set "folder_name=Applications"

    :: Create destination folder
    if not exist "%folder%\!folder_name!" (
        mkdir "%folder%\!folder_name!" 2>nul
    )

    move "%folder%\%%i" "%folder%\!folder_name!\" >nul 2>&1

    if not errorlevel 1 (
        set /a count+=1
        echo %GREEN%  [+] %%i -^> !folder_name!%RESET%
    ) else (
        echo %RED%  [FAILED] %%i%RESET%
    )
)

:: Summary
echo.
echo %CYAN%=======================================================%RESET%
echo %GREEN%%BOLD%  SUCCESS! %count% files organized.%RESET%
echo %CYAN%=======================================================%RESET%

:end
echo.
echo %GRAY%  Thank you for using File Organizer!%RESET%
echo.
pause
