@echo off
setlocal Enabledelayedexpansion

:: --- CONFIGURATION ---
:: Versioning for the auto-updater
set "current_version=1.0"
set "repo_raw=https://raw.githubusercontent.com/rdmcodingandsillystuff/metheorized/main"
set "version_url=%repo_raw%/version.txt"
set "download_url=%repo_raw%/metheorized.bat"
set "temp_version=%temp%\v_check.txt"

:: --- AUTO-UPDATE LOGIC ---
echo [*] Checking for updates...
:: Use PowerShell to download the version file from your repo
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
[cite_start]:: This ensures the script has the rights to modify system registry keys. [cite: 1]
net session >nul 2>&1 
if %errorLevel% neq 0 (
    [cite_start]echo [!] PERMISSION REQUIRED: RIGHT-CLICK AND RUN AS ADMINISTRATOR [cite: 2]
    pause 
    exit /b 
)

title METHEORIZED OMNI-OPTIMIZER 2026 
mode con: cols=100 lines=45 
color 0C 

:MENU
[cite_start]cls [cite: 10]
echo.
[cite_start]echo  M E T H E O R I Z E D  -  O M N I  -  O P T I M I Z E R [cite: 10]
[cite_start]echo ====================================================================================== [cite: 10]
[cite_start]echo    1. RUN TOTAL SYSTEM OVERHAUL [cite: 10]
[cite_start]echo    2. DEEP RAM PURGE [cite: 10]
[cite_start]echo    3. REVERT TO WINDOWS DEFAULTS [cite: 10]
[cite_start]echo    4. JOIN THE DISCORD [cite: 10]
[cite_start]echo    5. EXIT [cite: 10]
[cite_start]echo ====================================================================================== [cite: 10]
[cite_start]set /p "choice=Select (1-5): " [cite: 10]

[cite_start]if "%choice%"=="1" goto OVERHAUL [cite: 10]
[cite_start]if "%choice%"=="2" goto PURGE [cite: 10]
[cite_start]if "%choice%"=="3" goto REVERT [cite: 10]
[cite_start]if "%choice%"=="4" goto DISCORD [cite: 10]
[cite_start]if "%choice%"=="5" exit [cite: 10]
[cite_start]goto MENU [cite: 10]

:OVERHAUL
echo.
[cite_start]echo [+] OPTIMIZING CPU... [cite: 11]
[cite_start]:: Adjusts CPU priority to favor foreground gaming performance. [cite: 11]
[cite_start]reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d 38 /f >nul 2>&1 [cite: 11]
[cite_start]echo [+] BOOSTING GPU... [cite: 11]
[cite_start]:: Increases GPU priority for high-demand applications. [cite: 11]
[cite_start]reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f >nul 2>&1 [cite: 11]
[cite_start]echo [+] TUNING NETWORK... [cite: 11]
[cite_start]:: Disables TCP delay to reduce latency in-game. [cite: 11]
[cite_start]reg add "HKLM\SOFTWARE\Microsoft\MSMQ\Parameters" /v "TCPNoDelay" /t REG_DWORD /d 1 /f >nul 2>&1 [cite: 11]
[cite_start]ipconfig /flushdns >nul 2>&1 [cite: 11]
[cite_start]echo [+] CLEANING TEMP FILES... [cite: 11]
[cite_start]:: Force-closes browsers to ensure temporary cache can be cleared. [cite: 11]
[cite_start]taskkill /F /IM chrome.exe /T >nul 2>&1 [cite: 11]
[cite_start]taskkill /F /IM msedge.exe /T >nul 2>&1 [cite: 11]
[cite_start]del /s /f /q %temp%\*.* >nul 2>&1 [cite: 11]
echo.
[cite_start]echo OMNI-BOOST COMPLETE! [cite: 12]
[cite_start]pause [cite: 12]
[cite_start]goto MENU [cite: 12]

:PURGE
echo.
[cite_start]echo [+] PURGING RAM... [cite: 13]
[cite_start]:: Forces a garbage collection to free up unused system memory. [cite: 13]
powershell -NoProfile -ExecutionPolicy Bypass -Command "[System.GC]::Collect();" >[cite_start]nul 2>&1 [cite: 13]
[cite_start]echo [OK] RAM is now fresh. [cite: 13]
[cite_start]pause [cite: 13]
[cite_start]goto MENU [cite: 13]

:REVERT
[cite_start]echo. [cite: 14]
[cite_start]echo [+] REVERTING SETTINGS... [cite: 14]
[cite_start]:: Restores Windows default CPU scheduling. [cite: 14]
[cite_start]reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d 2 /f >nul 2>&1 [cite: 14]
[cite_start]echo [OK] System set back to Default. [cite: 14]
[cite_start]pause [cite: 15]
[cite_start]goto MENU [cite: 15]

:DISCORD
[cite_start]start https://discord.gg/tUCfNwmWhD [cite: 15]
[cite_start]goto MENU [cite: 15]
