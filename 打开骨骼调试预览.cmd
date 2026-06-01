@echo off
cd /d "%~dp0"
echo 正在启动骨骼调试预览...
echo 地址：http://127.0.0.1:8787/bone-debug-preview.html
start "" "http://127.0.0.1:8787/bone-debug-preview.html"
"D:\node\node.exe" preview-server.js
pause
