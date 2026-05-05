@echo off
REM Jenkins Pipeline Setup Assistant - Windows Batch Script
REM This script helps you get started with the Jenkins CI/CD pipeline

setlocal enabledelayedexpansion

echo.
echo ========================================
echo Jenkins Pipeline Setup Assistant
echo ========================================
echo.

REM Check if Node.js is installed
where node >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Node.js is not installed or not in PATH
    echo Please install Node.js from https://nodejs.org
    echo.
    pause
    exit /b 1
)

echo [OK] Node.js found: 
node --version
npm --version
echo.

REM Check if Docker is installed
where docker >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [WARNING] Docker is not installed or not in PATH
    echo Docker is optional but recommended
    echo Install from: https://www.docker.com/products/docker-desktop
    echo.
) else (
    echo [OK] Docker found:
    docker --version
    echo.
)

REM Check if Git is installed
where git >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [WARNING] Git is not installed or not in PATH
    echo Install from: https://git-scm.com
    echo.
) else (
    echo [OK] Git found:
    git --version
    echo.
)

echo.
echo ========================================
echo Next Steps:
echo ========================================
echo.
echo 1. INSTALL JENKINS
echo    - Download from https://jenkins.io/download
echo    - Run the Windows installer (.msi)
echo    - Jenkins will be available at http://localhost:8080
echo.
echo 2. JENKINS INITIAL SETUP
echo    - Go to http://localhost:8080
echo    - Find initial admin password in Jenkins console
echo    - Install suggested plugins
echo    - Create admin user
echo.
echo 3. INSTALL REQUIRED PLUGINS
echo    - Go to: Manage Jenkins > Manage Plugins
echo    - Search and install:
echo      * NodeJS Plugin
echo      * Pipeline
echo      * GitHub Integration
echo      * Docker Pipeline
echo.
echo 4. CONFIGURE NODE.JS IN JENKINS
echo    - Go to: Manage Jenkins > Tools > NodeJS installations
echo    - Add NodeJS v20.x LTS
echo    - Name it: NodeJS
echo.
echo 5. ADD GITHUB CREDENTIALS
echo    - Create Personal Access Token on GitHub
echo    - Go to: Manage Jenkins > Credentials
echo    - Add Username/Password credentials
echo    - Use token as password
echo.
echo 6. CREATE PIPELINE JOB
echo    - New Item > Pipeline
echo    - Configure with:
echo      - Definition: Pipeline script from SCM
echo      - SCM: Git
echo      - Repository: Your GitHub repo URL
echo      - Credentials: Select GitHub credentials
echo      - Script Path: Jenkinsfile
echo.
echo 7. BUILD AND TEST
echo    - Click "Build Now"
echo    - Monitor Console Output
echo    - View Test Results
echo.
echo ========================================
echo Documentation Files:
echo ========================================
echo.
echo - JENKINS_QUICK_START.md ............ Quick setup guide (5 min)
echo - JENKINS_PIPELINE_REPORT.md ....... Complete documentation
echo - DOCKER_HUB_SETUP.md .............. Docker integration guide
echo - docker-compose.yml ............... Local testing with Docker
echo - Jenkinsfile ...................... CI/CD pipeline definition
echo.
echo ========================================
echo Verification:
echo ========================================
echo.
echo Install dependencies locally:
echo   cd backend
echo   npm install
echo   cd ..
echo   cd frontend
echo   npm install
echo   cd ..
echo.
echo Run tests locally:
echo   cd backend
echo   npm test
echo   cd ..
echo   cd frontend
echo   npm test
echo.
echo Build frontend:
echo   cd frontend
echo   npm run build
echo.
echo Test Docker Compose:
echo   docker-compose up --build
echo   Then access:
echo   - Frontend: http://localhost:3000
echo   - Backend: http://localhost:5000
echo.
echo ========================================
echo.
pause
endlocal
