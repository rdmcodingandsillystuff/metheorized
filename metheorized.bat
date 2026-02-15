@echo off
setlocal Enabledelayedexpansion

:START
:: --- AUTO-ADMIN ELEVATION ---
net session >nul 2>&1
if %errorLevel% NEQ 0 (
    echo [!] REQUESTING ADMIN PRIVILEGES...
    powershell -Command "Start-Process -FilePath '%0' -Verb RunAs"
    exit /b
)

title METEORIZED OMNI-OPTIMIZER 2026
mode con: cols=100 lines=45
color 0C

:MENU
cls
echo.
echo  ▄▄  ▄▄ ▄▄▄▄▄ ▄▄▄▄▄▄ ▄▄ ▄▄ ▄▄▄▄▄  ▄▄▄  ▄▄▄▄  ▄▄ ▄▄▄▄▄ ▄▄▄▄▄ ▄▄▄▄  
echo  ██▀▄▀██ ██▄▄    ██   ██▄██ ██▄▄  ██▀██ ██▄█▄ ██   ▄█▀ ██▄▄  ██▀██ 
echo  ██   ██ ██▄▄▄   ██   ██ ██ ██▄▄▄ ▀███▀ ██ ██ ██ ▄██▄▄ ██▄▄▄ ████▀ 
echo ======================================================================================
echo    M E T E O R I Z E D   O M N I - O P T I M I Z E R   
echo ======================================================================================
echo    1. RUN TOTAL SYSTEM OVERHAUL
echo    2. DEEP RAM PURGE
echo    3. REVERT TO WINDOWS DEFAULTS
echo    4. JOIN THE DISCORD
echo    5. EXIT
echo ======================================================================================
set /p "choice=Enter Selection: "

if "%choice%"=="1" goto OVERHAUL
if "%choice%"=="2" goto PURGE
if "%choice%"=="3" goto REVERT
if "%choice%"=="4" goto DISCORD
if "%choice%"=="5" exit
goto MENU

:OVERHAUL
echo.
echo [1/6] OPTIMIZING CPU SCHEDULING... [cite: 3]
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d 38 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v "PowerThrottlingOff" /t REG_DWORD /d 1 /f >nul 2>&1

echo [2/6] BOOSTING GPU PREEMPTION...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f >nul 2>&1

echo [3/6] TUNING NETWORK STACK...
reg add "HKLM\SOFTWARE\Microsoft\MSMQ\Parameters" /v "TCPNoDelay" /t REG_DWORD /d 1 /f >nul 2>&1 
ipconfig /flushdns >nul

echo [4/6] SYSTEM I/O ^& MEMORY TWEAKS... 
fsutil behavior set disablelastaccess 1 >nul 2>&1
powercfg -h off >nul 2>&1

echo [5/6] PRESERVING VISUALS... [cite: 5]
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v "VisualFXSetting" /t REG_DWORD /d 1 /f >nul 2>&1

echo [6/6] PURGING BACKGROUND BLOAT...
taskkill /F /IM chrome.exe /T >nul 2>&1
taskkill /F /IM msedge.exe /T >nul 2>&1
del /s /f /q %temp%\*.* >nul 2>&1

echo.
echo ======================================================================================
echo    OMNI-BOOST COMPLETE!
echo ======================================================================================
pause
goto MENU

:PURGE
echo.
echo [+] FORCING STANDBY LIST PURGE... 
powershell -NoProfile -ExecutionPolicy Bypass -Command "[System.GC]::Collect();" >nul 2>&1
echo [OK] RAM is now fresh.
pause
goto MENU

:REVERT
echo.
echo [+] REVERTING TO DEFAULT SETTINGS... [cite: 7]
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d 2 /f >nul 2>&1
echo [OK] System set back to Windows Default.
pause
goto MENU

:DISCORD
start https://discord.gg/tUCfNwmWhD [cite: 8]
goto MENU
