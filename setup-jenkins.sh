#!/bin/bash

# Jenkins Pipeline Setup Assistant - Linux/Mac Script
# This script helps you get started with the Jenkins CI/CD pipeline

echo ""
echo "========================================"
echo "Jenkins Pipeline Setup Assistant"
echo "========================================"
echo ""

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "[ERROR] Node.js is not installed"
    echo "Install from: https://nodejs.org"
    echo ""
    exit 1
fi

echo "[OK] Node.js found:"
node --version
npm --version
echo ""

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "[WARNING] Docker is not installed"
    echo "Docker is optional but recommended"
    echo "Install from: https://www.docker.com/products/docker-desktop"
    echo ""
else
    echo "[OK] Docker found:"
    docker --version
    echo ""
fi

# Check if Git is installed
if ! command -v git &> /dev/null; then
    echo "[WARNING] Git is not installed"
    echo "Install from: https://git-scm.com"
    echo ""
else
    echo "[OK] Git found:"
    git --version
    echo ""
fi

echo ""
echo "========================================"
echo "Next Steps:"
echo "========================================"
echo ""
echo "1. INSTALL JENKINS"
echo "   - Download from https://jenkins.io/download"
echo "   - For Linux: sudo apt-get install jenkins"
echo "   - Jenkins will be available at http://localhost:8080"
echo ""
echo "2. JENKINS INITIAL SETUP"
echo "   - Go to http://localhost:8080"
echo "   - Find initial admin password in Jenkins console"
echo "   - Install suggested plugins"
echo "   - Create admin user"
echo ""
echo "3. INSTALL REQUIRED PLUGINS"
echo "   - Go to: Manage Jenkins > Manage Plugins"
echo "   - Search and install:"
echo "     * NodeJS Plugin"
echo "     * Pipeline"
echo "     * GitHub Integration"
echo "     * Docker Pipeline"
echo ""
echo "4. CONFIGURE NODE.JS IN JENKINS"
echo "   - Go to: Manage Jenkins > Tools > NodeJS installations"
echo "   - Add NodeJS v20.x LTS"
echo "   - Name it: NodeJS"
echo ""
echo "5. ADD GITHUB CREDENTIALS"
echo "   - Create Personal Access Token on GitHub"
echo "   - Go to: Manage Jenkins > Credentials"
echo "   - Add Username/Password credentials"
echo "   - Use token as password"
echo ""
echo "6. CREATE PIPELINE JOB"
echo "   - New Item > Pipeline"
echo "   - Configure with:"
echo "     - Definition: Pipeline script from SCM"
echo "     - SCM: Git"
echo "     - Repository: Your GitHub repo URL"
echo "     - Credentials: Select GitHub credentials"
echo "     - Script Path: Jenkinsfile"
echo ""
echo "7. BUILD AND TEST"
echo "   - Click 'Build Now'"
echo "   - Monitor Console Output"
echo "   - View Test Results"
echo ""
echo "========================================"
echo "Documentation Files:"
echo "========================================"
echo ""
echo "- JENKINS_QUICK_START.md ............ Quick setup guide (5 min)"
echo "- JENKINS_PIPELINE_REPORT.md ....... Complete documentation"
echo "- DOCKER_HUB_SETUP.md .............. Docker integration guide"
echo "- docker-compose.yml ............... Local testing with Docker"
echo "- Jenkinsfile ...................... CI/CD pipeline definition"
echo ""
echo "========================================"
echo "Verification:"
echo "========================================"
echo ""
echo "Install dependencies locally:"
echo "  cd backend && npm install && cd .."
echo "  cd frontend && npm install && cd .."
echo ""
echo "Run tests locally:"
echo "  cd backend && npm test && cd .."
echo "  cd frontend && npm test"
echo ""
echo "Build frontend:"
echo "  cd frontend && npm run build"
echo ""
echo "Test Docker Compose:"
echo "  docker-compose up --build"
echo "  Then access:"
echo "  - Frontend: http://localhost:3000"
echo "  - Backend: http://localhost:5000"
echo ""
echo "========================================"
echo ""
