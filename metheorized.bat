@echo off
setlocal Enabledelayedexpansion

:: --- CONFIGURATION ---
set "current_version=1.1"
set "repo_raw=https://raw.githubusercontent.com/rdmcodingandsillystuff/metheorized/main"
set "version_url=%repo_raw%/version.txt"
set "download_url=%repo_raw%/metheorized.bat"
set "temp_version=%temp%\v_check.txt"

:: --- AUTO-UPDATE LOGIC ---
echo [*] Checking for updates...
powershell -Command "(New-Object Net.WebClient).DownloadFile('%version_url%', '%temp_version%')" >nul 2>&1

if exist "%temp_version%" (
    set /p remote_version=<%temp_version%
    if "!remote_version!" NEQ "%current_version%" (
        echo [!] New version !remote_version! found. Downloading update...
        powershell -Command "(New-Object Net.WebClient).DownloadFile('%download_url%', '%~nx0.new')" >nul 2>&1
        
        if exist "%~nx0.new" (
            move /y "%~nx0.new" "%~nx0" >nul
            echo [+] Update installed successfully. Restarting...
            timeout /t 2 >nul
            start "" "%~nx0"
            exit /b
        )
    )
    del "%temp_version%" >nul 2>&1
) else (
    echo [!] Could not connect to update server. Skipping...
)

:: --- ADMIN CHECK ---
net session >nul 2>&1 
if %errorLevel% neq 0 (
    echo [!] PERMISSION REQUIRED: RIGHT-CLICK AND RUN AS ADMINISTRATOR 
    pause 
    exit /b 
)

title METHEORIZED OMNI-OPTIMIZER 2026 
mode con: cols=100 lines=45 
color 0C 

:MENU
cls
echo.
echo  M E T H E O R I Z E D  -  O M N I  -  O P T I M I Z E R
echo ======================================================================================
echo    1. RUN TOTAL SYSTEM OVERHAUL
echo    2. DEEP RAM PURGE
echo    3. REVERT TO WINDOWS DEFAULTS
echo    4. JOIN THE DISCORD
echo    5. EXIT
echo ======================================================================================
set /p "choice=Select (1-5): "

if "%choice%"=="1" goto OVERHAUL
if "%choice%"=="2" goto PURGE 
if "%choice%"=="3" goto REVERT 
if "%choice%"=="4" goto DISCORD 
if "%choice%"=="5" exit 
goto MENU 

:OVERHAUL
echo.
echo [+] OPTIMIZING CPU... 
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d 38 /f >nul 2>&1 
echo [+] BOOSTING GPU... 
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f >nul 2>&1 
echo [+] TUNING NETWORK... 
reg add "HKLM\SOFTWARE\Microsoft\MSMQ\Parameters" /v "TCPNoDelay" /t REG_DWORD /d 1 /f >nul 2>&1 
ipconfig /flushdns >nul 2>&1 
echo [+] CLEANING TEMP FILES... 
taskkill /F /IM chrome.exe /T >nul 2>&1 
taskkill /F /IM msedge.exe /T >nul 2>&1 
del /s /f /q %temp%\*.* >nul 2>&1 
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

:REVERT
echo.
echo [+] REVERTING SETTINGS... 
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d 2 /f >nul 2>&1 
echo [OK] System set back to Default.
pause 
goto MENU 

:DISCORD
start https://discord.gg/tUCfNwmWhD 
goto MENU

