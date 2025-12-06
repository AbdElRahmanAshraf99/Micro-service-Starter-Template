@echo off
REM ============================================
REM Docker Build Script for Microservice Starter
REM ============================================

echo.
echo ==========================================
echo    Building Docker Image
echo ==========================================
echo.

REM Set variables
SET IMAGE_NAME=microservice-starter
SET IMAGE_TAG=1.0.0
SET REGISTRY=

REM Check if custom tag was provided
IF NOT "%1"=="" SET IMAGE_TAG=%1

REM Check if registry was provided
IF NOT "%2"=="" SET REGISTRY=%2/

echo [INFO] Building Docker image: %REGISTRY%%IMAGE_NAME%:%IMAGE_TAG%
echo.

REM Build Docker image
docker build -t %REGISTRY%%IMAGE_NAME%:%IMAGE_TAG% .

IF %ERRORLEVEL% NEQ 0 (
    echo.
    echo [ERROR] Docker build failed!
    exit /b 1
)

REM Also tag as latest
docker tag %REGISTRY%%IMAGE_NAME%:%IMAGE_TAG% %REGISTRY%%IMAGE_NAME%:latest

echo.
echo ==========================================
echo    Docker build completed successfully!
echo ==========================================
echo.
echo Image: %REGISTRY%%IMAGE_NAME%:%IMAGE_TAG%
echo Image: %REGISTRY%%IMAGE_NAME%:latest
echo.
echo To run the container:
echo   docker run -p 8080:8080 %IMAGE_NAME%:%IMAGE_TAG%
echo.
echo To run with environment variables:
echo   docker run -p 8080:8080 -e SPRING_PROFILES_ACTIVE=prod %IMAGE_NAME%:%IMAGE_TAG%
echo.

pause
