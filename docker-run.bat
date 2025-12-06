@echo off
REM ============================================
REM Docker Run Script for Microservice Starter
REM ============================================

echo.
echo ==========================================
echo    Running Docker Container
echo ==========================================
echo.

REM Set variables
SET IMAGE_NAME=microservice-starter
SET IMAGE_TAG=latest
SET CONTAINER_NAME=microservice-starter
SET HOST_PORT=8080
SET CONTAINER_PORT=8080
SET PROFILE=dev

REM Check if custom tag was provided
IF NOT "%1"=="" SET IMAGE_TAG=%1

REM Check if custom profile was provided
IF NOT "%2"=="" SET PROFILE=%2

echo [INFO] Starting container: %CONTAINER_NAME%
echo [INFO] Image: %IMAGE_NAME%:%IMAGE_TAG%
echo [INFO] Profile: %PROFILE%
echo [INFO] Port: %HOST_PORT%:%CONTAINER_PORT%
echo.

REM Stop and remove existing container if exists
docker stop %CONTAINER_NAME% 2>nul
docker rm %CONTAINER_NAME% 2>nul

REM Run the container
docker run -d ^
    --name %CONTAINER_NAME% ^
    -p %HOST_PORT%:%CONTAINER_PORT% ^
    -e SPRING_PROFILES_ACTIVE=%PROFILE% ^
    -e JAVA_OPTS="-Xms256m -Xmx512m" ^
    %IMAGE_NAME%:%IMAGE_TAG%

IF %ERRORLEVEL% NEQ 0 (
    echo.
    echo [ERROR] Failed to start container!
    exit /b 1
)

echo.
echo ==========================================
echo    Container started successfully!
echo ==========================================
echo.
echo Container: %CONTAINER_NAME%
echo.
echo Endpoints:
echo   API:     http://localhost:%HOST_PORT%/api
echo   Swagger: http://localhost:%HOST_PORT%/api/swagger-ui.html
echo   Health:  http://localhost:%HOST_PORT%/api/actuator/health
echo.
echo Commands:
echo   View logs:    docker logs -f %CONTAINER_NAME%
echo   Stop:         docker stop %CONTAINER_NAME%
echo   Remove:       docker rm %CONTAINER_NAME%
echo.

pause
