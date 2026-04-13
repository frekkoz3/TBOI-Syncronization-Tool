@echo off
setlocal

REM ====== CONFIGURATION ======
set REPO_DIR=C:\Users\39346\Documents\My Games\Binding of Isaac Repentance
set DEFAULT_MSG=quick save

REM ====== CHECK IF REPO EXISTS ======
if not exist "%REPO_DIR%\.git" (
    echo [ERROR] The specified directory is not a Git repository:
    echo %REPO_DIR%
    exit /b 1
)

REM ====== COMMAND HANDLING ======
set COMMAND=%1
shift

if "%COMMAND%"=="" goto :help

if "%COMMAND%"=="push" goto :push
if "%COMMAND%"=="pull" goto :pull
if "%COMMAND%"=="save" goto :save
if "%COMMAND%"=="discard" goto :discard
if "%COMMAND%"=="help" goto :help

echo [ERROR] Unknown command: %COMMAND%
goto :help

:push
if "%~1"=="" (
    set MESSAGE=%DEFAULT_MSG%
) else (
    set MESSAGE=%*
)
echo [INFO] Adding, committing, and pushing...
git -C "%REPO_DIR%" add --all
git -C "%REPO_DIR%" commit -m "%MESSAGE%"
git -C "%REPO_DIR%" push
goto :eof

:pull
echo [INFO] Pulling latest changes...
git -C "%REPO_DIR%" pull
goto :eof

:save
if "%~1"=="" (
    set MESSAGE=%DEFAULT_MSG%
) else (
    set MESSAGE=%*
)
echo [INFO] Saving local changes...
git -C "%REPO_DIR%" add --all
git -C "%REPO_DIR%" commit -m "%MESSAGE%"
goto :eof

:discard
echo WARNING: This will permanently delete all local changes.
set /p CONFIRM=Are you sure? (y/N):
if /I "%CONFIRM%"=="Y" (
    git -C "%REPO_DIR%" reset --hard
    git -C "%REPO_DIR%" clean -fd
    echo [INFO] Local changes discarded.
) else (
    echo [INFO] Operation cancelled.
)
goto :eof

:help
echo.
echo Usage: gitquick ^<command^> [message]
echo.
echo Commands:
echo   push [msg]     Add, commit, and push changes
echo   pull           Pull latest changes
echo   save [msg]     Add and commit locally
echo   discard        Discard all local changes
echo   help           Show this help message
echo.
