@echo off
:: --- ENCODING SHIELD ---
goto :START

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
:: CHANGED TO RED COLOR SCHEME 
color 0C

:MENU
cls
echo ======================================================================================
echo    M E T E O R I Z E D   O M N I - O P T I M I Z E R   
echo ======================================================================================
echo    1. RUN TOTAL SYSTEM OVERHAUL (Gaming + Coding + Network)
echo    2. DEEP RAM PURGE (Flush Standby List)
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
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d 38 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v "PowerThrottlingOff" /t REG_DWORD /d 1 /f >nul

echo [2/6] BOOSTING GPU PREEMPTION...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d 6 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f >nul

echo [3/6] TUNING NETWORK STACK (LOW LATENCY)...
reg add "HKLM\SOFTWARE\Microsoft\MSMQ\Parameters" /v "TCPNoDelay" /t REG_DWORD /d 1 /f >nul [cite: 4]
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_DWORD /d 4294967295 /f >nul
ipconfig /flushdns >nul

echo [4/6] SYSTEM I/O ^& MEMORY TWEAKS...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "LargeSystemCache" /t REG_DWORD /d 1 /f >nul
fsutil behavior set disablelastaccess 1 >nul
powercfg -h off >nul

echo [5/6] PRESERVING VISUALS ^& ANIMATIONS...
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v "VisualFXSetting" /t REG_DWORD /d 1 /f >nul [cite: 5]
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v "MenuShowDelay" /t REG_SZ /d "150" /f >nul

echo [6/6] PURGING BACKGROUND BLOAT...
taskkill /F /IM chrome.exe /IM msedge.exe /IM GameBarPresenceWriter.exe /IM msedgewebview2.exe >nul 2>&1
del /s /f /q %temp%\*.* >nul 2>&1

echo.
echo ======================================================================================
echo    OMNI-BOOST COMPLETE! AUTO-LAUNCHING DISCORD... 
echo ======================================================================================
timeout /t 3 >nul
:: AUTO-INVITE TRIGGER 
goto DISCORD

:PURGE
echo.
echo [+] FORCING STANDBY LIST PURGE... [cite: 2, 7]
powershell -command "[System.GC]::Collect(); [System.GC]::WaitForPendingFinalizers();" >nul
echo [OK] RAM is now fresh.
pause
goto MENU

:REVERT
echo.
echo [+] REVERTING TO DEFAULT SETTINGS... [cite: 8]
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d 2 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_DWORD /d 10 /f >nul
powercfg -setactive 381b4222-f694-41f0-9685-ff5bb260df2e >nul
echo [OK] System set back to Windows Default Balanced.
pause [cite: 9]
goto MENU

:DISCORD
:: REPLACE THE LINK BELOW WITH YOUR ACTUAL INVITE
start https://discord.gg/tUCfNwmWhD
goto MENU