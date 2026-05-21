@echo off
setlocal

set "GIT=D:\Git\cmd\git.exe"
cd /d "%~dp0"

echo.
echo === Measurement Demo Publish ===
echo.

if not exist "%GIT%" (
  echo Git not found: %GIT%
  pause
  exit /b 1
)

"%GIT%" status --short --branch
echo.

echo Staging changes...
"%GIT%" add .
if errorlevel 1 (
  echo Failed to stage changes.
  pause
  exit /b 1
)

"%GIT%" diff --cached --quiet
if errorlevel 1 (
  echo Creating commit...
  "%GIT%" commit -m "update measurement demo"
  if errorlevel 1 (
    echo Failed to create commit.
    pause
    exit /b 1
  )
) else (
  echo No new local file changes to commit.
)

echo.
echo Pushing to GitHub...
"%GIT%" push
if errorlevel 1 (
  echo Push failed. Check network connection or GitHub login.
  pause
  exit /b 1
)

echo.
echo Published successfully.
echo GitHub Pages:
echo https://linmh0425-lang.github.io/measurement-demo/
echo.
pause
