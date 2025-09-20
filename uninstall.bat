@echo off
setlocal

REM ############################################################################
REM #
REM # Uninstallation script for the Self-hosted AI Package
REM #
REM ############################################################################

echo.
echo  Ahoy, matey! This script will help ye uninstall the Self-hosted AI Package.
echo  It will stop and remove all the Docker containers and volumes.
echo.

REM ############################################################################
REM # Check for Docker
REM ############################################################################

echo  Checking for Docker...
echo.

where /q docker
if %errorlevel% neq 0 (
    echo  ERROR: Docker not found. Please install Docker and make sure it's running.
    echo  You can download it from https://www.docker.com/products/docker-desktop/
    goto :eof
)

echo  Docker found.
echo.

REM ############################################################################
REM # Run the uninstallation
REM ############################################################################

echo  Stopping and removing the local AI services...
echo  This will also remove all data stored in the Docker volumes.
echo.

docker compose -p localai -f docker-compose.yml --profile gpu-nvidia down -v

echo.
echo  Stopping and removing the Supabase services...
echo.

docker compose -p localai -f supabase/docker/docker-compose.yml down -v

if %errorlevel% neq 0 (
    echo.
    echo  ERROR: The uninstallation failed. Please check the output above for errors.
    echo  Blimey! Something went wrong.
) else (
    echo.
    echo  Yo-ho-ho! The uninstallation is complete.
    echo  All containers and volumes have been removed.
)

echo.
pause
