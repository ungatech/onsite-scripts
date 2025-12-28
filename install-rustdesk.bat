@echo off
setlocal enabledelayedexpansion

:: --- Configuration with Argument Support ---
set "relay_host=%~1"
if "!relay_host!"=="" set "relay_host=relay.unga.tech"
set "relay_key=%~2"
if "!relay_key!"=="" set "relay_key=bjAtiOq+3krNi+mQCcbS0FNQvoOGqaSStUKkOCk911M="

:: Check for Admin rights
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Requesting Administrator privileges...
    powershell -Command "Start-Process '%0' -Verb RunAs"
    exit /b
)

echo ------------------------------------------
echo Ungatech Windows Deployment for RustDesk
echo Relay: !relay_host!
echo ------------------------------------------

:: --- WinGet Health Check ---
where winget >nul 2>&1
if %errorLevel% neq 0 (
    echo [!] WinGet not found. Attempting to bootstrap Windows Package Manager...
    powershell -Command "Add-AppxPackage -RegisterByFamilyName -MainPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe"
    timeout /t 5 >nul
)

:: Re-check after repair
where winget >nul 2>&1
if %errorLevel% neq 0 (
    echo [!] WinGet is still missing. Please ensure 'App Installer' is updated in the MS Store.
    pause
    exit /b
)

echo Installing/Updating RustDesk...
winget install --id RustDesk.RustDesk --silent --force --accept-source-agreements --accept-package-agreements

set "RD_EXE=%ProgramFiles%\RustDesk\rustdesk.exe"

echo Applying Server Configuration...
"!RD_EXE!" --config "host=!relay_host!,key=!relay_key!"

:passloop
echo.
echo Set the Permanent Password (Input is MASKED):
for /f "usebackq delims=" %%i in (`powershell -Command "$p = read-host 'Enter Password' -AsSecureString; [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($p))"`) do set "pass1=%%i"
for /f "usebackq delims=" %%i in (`powershell -Command "$p = read-host 'Confirm Password' -AsSecureString; [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($p))"`) do set "pass2=%%i"

if "!pass1!"=="!pass2!" (
    if not "!pass1!"=="" (
        echo.
        echo Passwords match. Applying...
        "!RD_EXE!" --password "!pass1!"
        set "pass1=" & set "pass2="
        goto :success
    )
)
echo.
echo Error: Passwords do not match or are empty. Try again.
goto :passloop

:success
echo ------------------------------------------
echo Installation Complete!
echo Your Ungatech Support ID is:
"!RD_EXE!" --get-id
echo ------------------------------------------
pause