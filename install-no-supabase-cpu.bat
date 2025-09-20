@echo off
setlocal

REM ############################################################################
REM #
REM # Installation script for the Self-hosted AI Package without Supabase (CPU)
REM #
REM ############################################################################

echo.
echo  Ahoy, matey! This script will help ye install the Self-hosted AI Package without Supabase.
echo  It will check for prerequisites and then start all the services.
echo.

REM ############################################################################
REM # Check for prerequisites
REM ############################################################################

echo  Checking for prerequisites...
echo.

where /q git
if %errorlevel% neq 0 (
    echo  ERROR: Git not found. Please install Git and make sure it's in your PATH.
    echo  You can download it from https://git-scm.com/
    goto :eof
)

where /q docker
if %errorlevel% neq 0 (
    echo  ERROR: Docker not found. Please install Docker and make sure it's running.
    echo  You can download it from https://www.docker.com/products/docker-desktop/
    goto :eof
)

where /q python
if %errorlevel% neq 0 (
    where /q python3
    if %errorlevel% neq 0 (
        echo  ERROR: Python not found. Please install Python and make sure it's in your PATH.
        echo  You can download it from https://www.python.org/downloads/
        goto :eof
    ) else (
        set PYTHON_CMD=python3
    )
) else (
    set PYTHON_CMD=python
)

echo  All prerequisites found.
echo.

REM ############################################################################
REM # Check for .env file
REM ############################################################################

echo  Checking for the .env file...
echo.

if not exist .env (
    echo  WARNING: .env file not found.
    echo  Please create a .env file by copying the .env.example file.
    echo  You will need to fill in the required secrets in the .env file before proceeding.
    echo  Instructions can be found in the README.md file.
    pause
    goto :eof
)

echo  .env file found.
echo.

REM ############################################################################
REM # Run the installation
REM ############################################################################

echo  Starting the installation...
echo  This may take a while, especially on the first run, as it will download Docker images.
echo.

%PYTHON_CMD% start_services.py --profile cpu --no-supabase

if %errorlevel% neq 0 (
    echo.
    echo  ERROR: The installation failed. Please check the output above for errors.
    echo  Shiver me timbers! Something went wrong.
) else (
    echo.
    echo  Yo-ho-ho! The installation is complete.
    echo  The services are now running in the background.
    echo  You can access the services at the URLs listed in the README.md file.
)

echo.
pause
