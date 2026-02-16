@echo off
setlocal Enabledelayedexpansion

:: --- ADMIN AUTO-PROMPT ---
fsutil dirty query %systemdrive% >nul 2>&1
if %errorLevel% neq 0 (
    echo [!] Requesting Administrative Privileges...
    powershell -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

:: --- CONFIGURATION ---
:: Using the RAW URL with a cache-busting timestamp
set "url=https://raw.githubusercontent.com/rdmcodingandsillystuff/metheorized/main/metheorized.bat"

:: --- THE UPDATE ENGINE ---
if "%~1"=="--updated" (
    if exist "%~f0.old" del /f /q "%~f0.old"
    goto START_SCRIPT
)

echo [*] Checking for updates on GitHub...
set "TEMP_FILE=%temp%\metheor_next.bat"

:: Force download using a unique request to bypass GitHub's cache
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $web = New-Object Net.WebClient; $web.Headers.Add('Cache-Control','no-cache'); $v = Get-Date -UFormat '%%s'; $web.DownloadFile('%url%?v=$v', '%TEMP_FILE%')" >nul 2>&1

if exist "%TEMP_FILE%" (
    :: Verify the file contains actual code and isn't a 404 error
    findstr /i "@echo" "%TEMP_FILE%" >nul
    if !errorLevel! equ 0 (
        echo [+] New version found. Applying changes...
        :: We rename the current file to .old and move the new one in its place
        ren "%~f0" "%~nx0.old"
        move /y "%TEMP_FILE%" "%~f0" >nul
        start "" "%~f0" --updated
        exit /b
    )
)

echo [!] No update applied (Server lag or no connection).
timeout /t 2 >nul

:START_SCRIPT
title METHEORIZED OMNI-OPTIMIZER 2026 
mode con: cols=100 lines=45 
color 0C 

:MENU
cls
echo.
echo  M E T H E O R I Z E D  -  O M N I  -  O P T I M I Z E R
echo ======================================================================================
echo    1. RUN TOTAL SYSTEM OVERHAUL (CPU, GPU, POWER)
echo    2. DEEP RAM PURGE
echo    3. NETWORK ^& DNS FLUSH
echo    4. REVERT TO WINDOWS DEFAULTS
echo    5. JOIN THE DISCORD
echo    6. EXIT
echo ======================================================================================
set /p "choice=Select (1-6): "

if "%choice%"=="1" goto OVERHAUL
if "%choice%"=="2" goto PURGE 
if "%choice%"=="3" goto NETWORK
if "%choice%"=="4" goto REVERT 
if "%choice%"=="5" goto DISCORD 
if "%choice%"=="6" exit 
goto MENU 

:OVERHAUL
echo.
echo [+] ENABLING ULTIMATE PERFORMANCE...
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 >nul 2>&1
powercfg /setactive e9a42b02-d5df-448d-aa00-03f14749eb61 >nul 2>&1
echo [+] OPTIMIZING CPU ^& GPU PRIORITY...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d 38 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f >nul 2>&1
echo [+] CLEANING CACHE...
del /s /f /q "%temp%\*.*" >nul 2>&1
echo.
echo OMNI-BOOST COMPLETE!
pause 
goto MENU 

:PURGE
echo.
echo [+] PURGING RAM...
powershell -NoProfile -ExecutionPolicy Bypass -Command "[System.GC]::Collect();" >nul 2>&1
echo [OK] RAM is now fresh.
pause 
goto MENU 

:NETWORK
echo.
echo [+] FLUSHING DNS ^& STACK...
ipconfig /flushdns >nul 2>&1
netsh int ip reset >nul 2>&1
echo [OK] Network optimized.
pause
goto MENU

:REVERT
echo.
echo [+] REVERTING...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d 2 /f >nul 2>&1
echo [OK] Defaults restored.
pause 
goto MENU 

:DISCORD
start https://discord.gg/tUCfNwmWhD
goto MENU
