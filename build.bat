@echo off
REM ============================================
REM Maven Build Script for Microservice Starter
REM ============================================

echo.
echo ==========================================
echo    Building Microservice Starter
echo ==========================================
echo.

REM Set variables
SET PROJECT_NAME=microservice-starter
SET VERSION=1.0.0

REM Clean and build
echo [INFO] Cleaning and building project...
call mvn clean package -DskipTests

IF %ERRORLEVEL% NEQ 0 (
    echo.
    echo [ERROR] Build failed!
    exit /b 1
)

echo.
echo ==========================================
echo    Build completed successfully!
echo ==========================================
echo.
echo JAR file location: target\%PROJECT_NAME%-%VERSION%-SNAPSHOT.jar
echo.

pause
