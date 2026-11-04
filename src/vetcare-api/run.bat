@echo off
title VetCare Pro - Spring Boot API
cd /d "%~dp0"

echo ===================================================
echo           KHOI DONG VETCARE PRO API
echo ===================================================
echo Thu muc hien tai: %CD%
echo.

call mvn spring-boot:run
if %ERRORLEVEL% NEQ 0 (
    echo.
    echo [ERROR] Co loi xay ra khi chay ung dung!
)

pause

