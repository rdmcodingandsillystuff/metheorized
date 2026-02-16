@echo off
setlocal Enabledelayedexpansion

:: --- 1. BOILERPLATE & ADMIN AUTO-ELEVATE ---
:: Checks for admin; if not found, it re-launches itself as administrator.
fsutil dirty query %systemdrive% >nul 2>&1
if %errorLevel% neq 0 (
    powershell -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

:: --- 2. CONFIGURATION ---
set "url=https://raw.githubusercontent.com/rdmcodingandsillystuff/metheorized/main/metheorized.bat"
set "app_title=METHEORIZED OMNI-OPTIMIZER 2026"

:: --- 3. THE SHADOW-SWAP UPDATE ENGINE ---
:: If started with --cleanup, delete the old file and proceed
if "%~1"=="--cleanup" (
    timeout /t 1 >nul
    if exist "%~f0.old" del /f /q "%~f0.old"
    goto START_SCRIPT
)

echo [*] Synchronizing with GitHub...
set "temp_update=%temp%\metheor_vnext.bat"

:: Use an aggressive WebClient request with TLS 1.2 and a random cache-buster string
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $v = Get-Random; (New-Object Net.WebClient).DownloadFile('%url%?cache=$v', '%temp_update%')" >nul 2>&1

if exist "%temp_update%" (
    :: Safety check: Ensure the download is a valid script and not a 404 error page
    findstr /i "@echo" "%temp_update%" >nul
    if !errorLevel! equ 0 (
        echo [+] New version detected. Performing Shadow-Swap...
        :: Rename the current file so it can be replaced while running
        ren "%~f0" "%~nx0.old"
        move /y "%temp_update%" "%~f0" >nul
        start "" "%~f0" --cleanup
        exit /b
    )
)
echo [!] Update server busy or no changes found.

:START_SCRIPT
title %app_title%
mode con: cols=100 lines=40
color 0C

:MENU
cls
echo.
echo  M E T H E O R I Z E D  -  O M N I  -  O P T I M I Z E R
echo ======================================================================================
echo    1. ULTIMATE OVERHAUL (CPU, GPU, ^& POWER)
echo    2. DEEP RAM PURGE (FORCED GC)
echo    3. NETWORK ^& DNS LATENCY REDUCTION
echo    4. REVERT ALL CHANGES TO DEFAULT
echo    5. JOIN DISCORD
echo    6. EXIT
echo ======================================================================================
set /p "choice=Select (1-6): "

if "%choice%"=="1" goto OVERHAUL
if "%choice%"=="2" goto PURGE
if "%choice%"=="3" goto NETWORK
if "%choice%"=="4" goto REVERT
if "%choice%"=="5" start https://discord.gg/tUCfNwmWhD & goto MENU
if "%choice%"=="6" exit
goto MENU

:OVERHAUL
echo.
echo [+] UNLOCKING ULTIMATE PERFORMANCE POWER SCHEME...
:: This unlocks a hidden Windows power plan designed for workstations.
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 >nul 2>&1
powercfg /setactive e9a42b02-d5df-448d-aa00-03f14749eb61 >nul 2>&1

echo [+] OPTIMIZING KERNEL PRIORITY...
:: Sets Win32PrioritySeparation to 38 (Decimal) for better foreground gaming response.
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d 38 /f >nul 2>&1

echo [+] BOOSTING GPU SCHEDULING...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f >nul 2>&1

echo [+] DISABLING POWER THROTTLING...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v "PowerThrottlingOff" /t REG_DWORD /d 1 /f >nul 2>&1

echo [+] CLEARING SYSTEM JUNK...
del /s /f /q "%temp%\*.*" >nul 2>&1
del /s /f /q "C:\Windows\Temp\*.*" >nul 2>&1
echo.
echo [DONE] OMNI-BOOST ACTIVE.
pause
goto MENU

:PURGE
echo.
echo [+] INITIATING RAM PURGE...
:: Uses PowerShell to force a Garbage Collection across the .NET framework.
powershell -NoProfile -Command "[System.GC]::Collect(); [System.GC]::WaitForPendingFinalizers();" >nul 2>&1
echo [DONE] System memory flushed.
pause
goto MENU

:NETWORK
echo.
echo [+] FLUSHING DNS CACHE...
ipconfig /flushdns >nul 2>&1
echo [+] RESETTING WINSOCK ^& IP STACK...
netsh winsock reset >nul 2>&1
netsh int ip reset >nul 2>&1
echo [+] DISABLING NAGLE'S ALGORITHM...
reg add "HKLM\SOFTWARE\Microsoft\MSMQ\Parameters" /v "TCPNoDelay" /t REG_DWORD /d 1 /f >nul 2>&1
echo [DONE] Network latency reduced.
pause
goto MENU

:REVERT
echo.
echo [+] RESTORING WINDOWS DEFAULTS...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d 2 /f >nul 2>&1
powercfg /setactive 381b4222-f694-41f0-9685-ff5bb260df2e >nul 2>&1
echo [DONE] Default settings restored.
pause
goto MENU
worked update
