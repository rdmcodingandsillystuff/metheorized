@echo off
setlocal EnableDelayedExpansion
title METHEORIZED - Secure Edition
color 0B

:: ==========================
:: VERSION
:: ==========================
set VERSION=3.0.0
set UPDATE_URL=https://raw.githubusercontent.com/rdmcodingandsillystuff/metheorized/main/metheorized.bat

:: ==========================
:: ADMIN CHECK
:: ==========================
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Requesting Administrator privileges...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit
)

:: ==========================
:: AUTO UPDATE CHECK
:: ==========================
echo Checking for updates...

set TEMP_FILE=%temp%\metheorized_update.bat
powershell -Command "try { Invoke-WebRequest '%UPDATE_URL%' -OutFile '%TEMP_FILE%' -UseBasicParsing } catch {}"

if not exist "%TEMP_FILE%" goto menu

for /f "tokens=2 delims==" %%A in ('findstr /b "set VERSION=" "%TEMP_FILE%"') do set NEWVER=%%A

if "%NEWVER%"=="" goto menu

if "%NEWVER%"=="%VERSION%" (
    del "%TEMP_FILE%"
    goto menu
)

echo.
echo Update found: %NEWVER%
echo Backing up current version...

copy "%~f0" "%~f0.bak" >nul

echo Installing update...

move /y "%TEMP_FILE%" "%~f0" >nul

if exist "%~f0" (
    echo Update successful. Restarting...
    timeout /t 2 >nul
    start "" "%~f0"
    exit
) else (
    echo Update failed. Restoring backup...
    copy "%~f0.bak" "%~f0"
    del "%TEMP_FILE%"
)

:: ==========================
:: MAIN MENU
:: ==========================
:menu
cls
echo ==========================================
echo        METHEORIZED v%VERSION%
echo ==========================================
echo.
echo 1. Balanced Visual Performance
echo 2. Gaming Performance Mode
echo 3. Network Optimization
echo 4. Storage Optimization
echo 5. Disable Background Apps
echo 6. Enable Memory Compression
echo 7. Restore Defaults
echo 8. Exit
echo.
set /p choice=Select Option:

if "%choice%"=="1" goto balanced
if "%choice%"=="2" goto gaming
if "%choice%"=="3" goto network
if "%choice%"=="4" goto storage
if "%choice%"=="5" goto background
if "%choice%"=="6" goto memory
if "%choice%"=="7" goto restore
if "%choice%"=="8" exit

goto menu

:: ==========================
:: BALANCED MODE
:: ==========================
:balanced
echo Applying Balanced Visual Performance...

powercfg -setacvalueindex scheme_current sub_processor PROCTHROTTLEMIN 100
powercfg -setacvalueindex scheme_current sub_processor PROCTHROTTLEMAX 100
powercfg -setactive scheme_current

reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v HwSchMode /t REG_DWORD /d 2 /f

powershell -Command "Enable-MMAgent -MemoryCompression"

echo Done.
pause
goto menu

:: ==========================
:: GAMING MODE
:: ==========================
:gaming
echo Applying Gaming Mode...

sc stop XblGameSave >nul 2>&1
sc config XblGameSave start= disabled >nul 2>&1

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v GlobalUserDisabled /t REG_DWORD /d 1 /f

echo Gaming Mode Applied.
pause
goto menu

:: ==========================
:: NETWORK
:: ==========================
:network
echo Optimizing Network...

netsh int tcp set global autotuninglevel=normal
netsh int tcp set global rss=enabled
netsh int tcp set global chimney=enabled
ipconfig /flushdns

echo Done.
pause
goto menu

:: ==========================
:: STORAGE
:: ==========================
:storage
echo Running TRIM/Defrag...
defrag C: /O
echo Done.
pause
goto menu

:: ==========================
:: BACKGROUND
:: ==========================
:background
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v GlobalUserDisabled /t REG_DWORD /d 1 /f
echo Background apps disabled.
pause
goto menu

:: ==========================
:: MEMORY
:: ==========================
:memory
powershell -Command "Enable-MMAgent -MemoryCompression"
echo Done.
pause
goto menu

:: ==========================
:: RESTORE
:: ==========================
:restore
echo Restoring Defaults...

sc config XblGameSave start= demand >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v GlobalUserDisabled /f
powercfg -restoredefaultschemes

echo Defaults Restored.
pause
goto menu

