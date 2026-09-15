@echo off
chcp 65001 > nul
title Sincronizador Automatico - Segundo Cerebro GitHub
echo ========================================================
echo   SINCRONIZANDO SEGUNDO CEREBRO CON GITHUB (3 RAMAS)
echo ========================================================
powershell -ExecutionPolicy Bypass -File "%~dp0auto_sync.ps1"
echo.
echo Presiona cualquier tecla para cerrar esta ventana...
pause > nul
