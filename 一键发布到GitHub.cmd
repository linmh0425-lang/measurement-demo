@echo off
setlocal

set "GIT=D:\Git\cmd\git.exe"
cd /d "%~dp0"

title 发布 measurement-demo 到 GitHub

echo.
echo ========================================
echo   发布 measurement-demo 到 GitHub
echo ========================================
echo.

if not exist "%GIT%" (
  echo 未找到 Git: %GIT%
  echo 请确认 Git 安装路径是否正确。
  echo.
  pause
  exit /b 1
)

echo 当前仓库状态：
"%GIT%" status --short --branch
echo.

echo 正在暂存全部改动...
"%GIT%" add .
if errorlevel 1 (
  echo.
  echo 暂存失败，请检查文件是否被占用。
  pause
  exit /b 1
)

"%GIT%" diff --cached --quiet
if errorlevel 1 (
  echo.
  echo 正在创建提交...
  "%GIT%" commit -m "update measurement demo"
  if errorlevel 1 (
    echo.
    echo 提交失败，请查看上方错误信息。
    pause
    exit /b 1
  )
) else (
  echo 没有新的文件改动需要提交。
)

echo.
echo 正在推送到 GitHub...
"%GIT%" push
if errorlevel 1 (
  echo.
  echo 推送失败。常见原因：网络连接失败、GitHub 登录过期、远端权限不足。
  echo 你可以把上方错误截图发给我，我继续帮你看。
  pause
  exit /b 1
)

echo.
echo 发布成功。
echo GitHub Pages 地址：
echo https://linmh0425-lang.github.io/measurement-demo/
echo.
echo 如果页面还没更新，请等待 1-3 分钟后刷新。
echo.
pause
