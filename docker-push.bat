@echo off
REM ============================================
REM Docker Push Script for Microservice Starter
REM ============================================

echo.
echo ==========================================
echo    Pushing Docker Image to Registry
echo ==========================================
echo.

REM Set variables
SET IMAGE_NAME=microservice-starter
SET IMAGE_TAG=1.0.0
SET REGISTRY=

REM Check if registry was provided
IF "%1"=="" (
    echo [ERROR] Registry is required!
    echo Usage: docker-push.bat ^<registry^> [tag]
    echo Example: docker-push.bat myregistry.azurecr.io 1.0.0
    exit /b 1
)
SET REGISTRY=%1

REM Check if custom tag was provided
IF NOT "%2"=="" SET IMAGE_TAG=%2

echo [INFO] Tagging image for registry: %REGISTRY%
echo.

REM Tag the image
docker tag %IMAGE_NAME%:%IMAGE_TAG% %REGISTRY%/%IMAGE_NAME%:%IMAGE_TAG%
docker tag %IMAGE_NAME%:latest %REGISTRY%/%IMAGE_NAME%:latest

IF %ERRORLEVEL% NEQ 0 (
    echo.
    echo [ERROR] Failed to tag image!
    exit /b 1
)

echo [INFO] Pushing image to registry...
echo.

REM Push the image
docker push %REGISTRY%/%IMAGE_NAME%:%IMAGE_TAG%
docker push %REGISTRY%/%IMAGE_NAME%:latest

IF %ERRORLEVEL% NEQ 0 (
    echo.
    echo [ERROR] Failed to push image!
    exit /b 1
)

echo.
echo ==========================================
echo    Push completed successfully!
echo ==========================================
echo.
echo Pushed: %REGISTRY%/%IMAGE_NAME%:%IMAGE_TAG%
echo Pushed: %REGISTRY%/%IMAGE_NAME%:latest
echo.

pause
