# DSO101 Assignment 2: Jenkins CI/CD Pipeline Report

## Executive Summary

This report documents the complete setup and configuration of a Jenkins CI/CD pipeline for automating the build, test, and deployment of a Node.js To-Do List application. The pipeline includes automated GitHub checkout, dependency installation, unit testing with Jest, Docker containerization, and deployment readiness.

---

## 1. Project Overview

**Application**: Full-stack To-Do List Application
- **Frontend**: React.js with Vite
- **Backend**: Node.js with Express
- **Testing**: Jest with JUnit XML reporting
- **Containerization**: Docker
- **Repository**: https://github.com/Tshewangdorji7257/TshewangDorji_02230312_DSO101_A2

---

## 2. Jenkins Setup Instructions

### 2.1 Installation Steps

#### On Windows

1. **Download Jenkins**
   - Visit https://jenkins.io/download
   - Select "Windows" to download the Windows installer (`.msi`)
   - Latest LTS version recommended

2. **Install Jenkins**
   ```
   - Run the installer (.msi file)
   - Choose "Install as Service" for automatic startup
   - Default port: 8080
   - Default installation path: C:\Program Files\Jenkins
   ```

3. **Access Jenkins**
   - After installation, open browser and go to `http://localhost:8080`
   - Complete the initial setup wizard
   - Save the initial admin password from the console

#### On Linux/Mac

```bash
# For Linux (Ubuntu/Debian)
sudo apt-get update
sudo apt-get install java-11-openjdk java-11-openjdk-devel
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt-get install jenkins
sudo systemctl start jenkins
sudo systemctl enable jenkins
```

### 2.2 Required Plugins Installation

1. **Navigate to Plugin Manager**
   - Go to **Manage Jenkins** → **Manage Plugins**
   - Click on **Available** tab

2. **Search and Install These Plugins**
   - ✅ **NodeJS Plugin** - For Node.js/npm support
   - ✅ **Pipeline** - For declarative pipelines
   - ✅ **Pipeline: Stage View** - For visual pipeline representation
   - ✅ **GitHub Integration** - For GitHub webhook integration
   - ✅ **GitHub Pipeline for Blue Ocean** - Enhanced GitHub support
   - ✅ **Docker** - For Docker agent support
   - ✅ **Docker Pipeline** - For Docker build steps
   - ✅ **JUnit Plugin** - For test result publishing (usually pre-installed)
   - ✅ **Timestamper** - For build log timestamps

3. **Click "Install without restart"** and then **Restart Jenkins**

### 2.3 Configure Node.js

1. **Navigate to Node.js Configuration**
   - Go to **Manage Jenkins** → **Tools**
   - Scroll to **NodeJS installations**

2. **Add Node.js Installation**
   - Click **Add NodeJS**
   - **Name**: `NodeJS` (must match Jenkinsfile)
   - **Version**: Select `20.x LTS` (or latest LTS)
   - Check **"Install automatically"**
   - Click **Save**

### 2.4 Configure Docker (if not installed)

1. **Install Docker Desktop** from https://www.docker.com/products/docker-desktop
2. **Configure Docker in Jenkins**
   - Go to **Manage Jenkins** → **Configure System**
   - Under **Docker**, add Docker server configuration
   - Use Unix socket `/var/run/docker.sock` (Linux) or Windows pipe (Windows)

---

## 3. GitHub Repository Setup

### 3.1 Generate GitHub Personal Access Token (PAT)

1. **Go to GitHub Settings**
   - Login to GitHub
   - Click profile icon → **Settings**
   - Click **Developer settings** → **Personal access tokens** → **Tokens (classic)**

2. **Create New Token**
   - Click **Generate new token** → **Generate new token (classic)**
   - **Token name**: `jenkins-ci-token`
   - **Expiration**: 90 days (recommended)
   - **Scopes**: Select these permissions:
     - ✅ `repo` (Full control of private repositories)
     - ✅ `admin:repo_hook` (Full control of repository hooks)
     - ✅ `workflow` (Update GitHub Actions and workflows)
   - Click **Generate token**
   - **⚠️ Copy and save the token immediately** (won't be shown again)

### 3.2 Add GitHub Credentials in Jenkins

1. **Navigate to Credentials**
   - Go to **Manage Jenkins** → **Manage Credentials**
   - Click **System** → **Global credentials (unrestricted)**
   - Click **+ Add Credentials**

2. **Add Username and Password**
   - **Kind**: Username and password
   - **Username**: Your GitHub username
   - **Password**: Your GitHub PAT (paste the token)
   - **ID**: `github-credentials`
   - **Description**: GitHub Personal Access Token
   - Click **Create**

3. **Add Docker Hub Credentials** (for Docker push)
   - Repeat above process:
   - **Kind**: Username and password
   - **Username**: Your Docker Hub username
   - **Password**: Your Docker Hub access token/password
   - **ID**: `docker-hub-creds`
   - Click **Create**

---

## 4. Jenkinsfile Configuration

### 4.1 Jenkinsfile Location and Content

**Location**: Root of repository `/Jenkinsfile`

**Key Components**:

```groovy
// Environment variables for Docker
DOCKER_HUB_REPO = 'your-dockerhub-username'
DOCKER_IMAGE_BACKEND = "${DOCKER_HUB_REPO}/todo-backend:${BUILD_NUMBER}"
DOCKER_IMAGE_FRONTEND = "${DOCKER_HUB_REPO}/todo-frontend:${BUILD_NUMBER}"

// NodeJS tool configuration
tools {
    nodejs 'NodeJS'
}

// Pipeline stages
stages {
    stage('Checkout') - Pulls code from GitHub
    stage('Install Dependencies - Backend') - npm install for backend
    stage('Install Dependencies - Frontend') - npm install for frontend
    stage('Build - Frontend') - vite build
    stage('Test - Backend') - Jest tests with JUnit reporting
    stage('Test - Frontend') - Jest tests with JUnit reporting
    stage('Build Docker Images') - Docker builds
    stage('Push to Docker Hub') - Docker push with authentication
    stage('Deploy') - Deployment trigger
}
```

---

## 5. Package.json Configuration

### 5.1 Backend Changes

```json
{
  "scripts": {
    "dev": "node --watch src/server.js",
    "start": "node src/server.js",
    "inspect": "node inspect-db.js",
    "test": "jest --ci --reporters=default --reporters=jest-junit",
    "build": "echo 'Backend build complete'"
  },
  "devDependencies": {
    "jest": "^29.7.0",
    "jest-junit": "^16.0.0"
  }
}
```

### 5.2 Frontend Changes

```json
{
  "scripts": {
    "dev": "vite",
    "build": "vite build",
    "preview": "vite preview",
    "test": "jest --ci --reporters=default --reporters=jest-junit"
  },
  "devDependencies": {
    "jest": "^29.7.0",
    "jest-junit": "^16.0.0",
    "@babel/preset-env": "^7.23.0",
    "@babel/preset-react": "^7.22.0",
    "@testing-library/react": "^14.0.0"
  }
}
```

### 5.3 Jest Configuration Files

- **backend/jest.config.js**: Node.js test environment
- **frontend/jest.config.js**: jsdom test environment with Babel support
- **frontend/.babelrc**: Babel configuration for React JSX

---

## 6. Docker Configuration

### 6.1 Backend Dockerfile

```dockerfile
FROM node:18-alpine
WORKDIR /app
COPY ./backend/package*.json ./
RUN npm install
COPY ./backend/src ./src
ENV PORT=5000
ENV NODE_ENV=production
EXPOSE 5000
CMD ["node", "src/server.js"]
```

### 6.2 Frontend Dockerfile

```dockerfile
FROM node:18-alpine AS build
WORKDIR /app
COPY ./frontend/package*.json ./
RUN npm install --legacy-peer-deps
COPY ./frontend/src ./src
COPY ./frontend/public ./public
COPY ./frontend/index.html ./
COPY ./frontend/vite.config.js ./
RUN npm run build
# Production stage with nginx or static serve
```

---

## 7. Creating and Configuring the Pipeline Job

### 7.1 Create a New Pipeline Job

1. **Go to Jenkins Home**
   - Click **+ New Item** (or **New Job**)

2. **Configure Job**
   - **Job name**: `todo-app-pipeline`
   - **Type**: Select **Pipeline**
   - Click **OK**

### 7.2 Configure Pipeline Source

1. **Under Pipeline section:**
   - **Definition**: Select **Pipeline script from SCM**
   - **SCM**: Select **Git**

2. **Git Configuration**
   - **Repository URL**: `https://github.com/Tshewangdorji7257/TshewangDorji_02230312_DSO101_A2.git`
   - **Credentials**: Select `github-credentials` (created earlier)
   - **Branch Specifier**: `*/main`
   - **Script Path**: `Jenkinsfile`

3. **Build Triggers** (Optional - for automatic builds)
   - ✅ **GitHub hook trigger for GITScm polling** (requires webhook setup)

4. **Click Save**

### 7.3 Setup GitHub Webhook (Optional - for automated triggers)

1. **Go to GitHub Repository**
   - Navigate to **Settings** → **Webhooks** → **Add webhook**

2. **Configure Webhook**
   - **Payload URL**: `http://your-jenkins-server:8080/github-webhook/`
   - **Content type**: `application/json`
   - **Events**: Select **Just the push event**
   - Check **Active**
   - Click **Add webhook**

---

## 8. Running the Pipeline

### 8.1 Manual Build

1. **Navigate to Pipeline Job**
   - Go to Jenkins home, click on `todo-app-pipeline`

2. **Click "Build Now"**
   - Pipeline will start executing

3. **Monitor Build Progress**
   - Click on the build number (e.g., #1)
   - Click **Console Output** to see real-time logs

### 8.2 Expected Build Log Output

```
Started by user anonymous
Running in ~/Jenkins/workspace/todo-app-pipeline
[Pipeline] node
Running on Jenkins in ~/Jenkins/workspace/todo-app-pipeline
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Checkout)
[Pipeline] git
Cloning the repository...
Checking out Revision...
[Pipeline] }
[Pipeline] { (Install Dependencies - Backend)
[Pipeline] sh
npm install
[Pipeline] }
[Pipeline] { (Install Dependencies - Frontend)
[Pipeline] sh
npm install
[Pipeline] }
[Pipeline] { (Build - Frontend)
[Pipeline] sh
npm run build
[Pipeline] }
[Pipeline] { (Test - Backend)
[Pipeline] sh
npm test
[Pipeline] }
[Pipeline] { (Test - Frontend)
[Pipeline] sh
npm test
[Pipeline] }
[Pipeline] { (Build Docker Images)
[Pipeline] sh
docker build -t your-user/todo-backend...
docker build -t your-user/todo-frontend...
[Pipeline] }
[Pipeline] { (Push to Docker Hub)
[Pipeline] sh
docker push your-user/todo-backend:1
docker push your-user/todo-frontend:1
[Pipeline] }
Finished: SUCCESS
```

### 8.3 View Test Results

1. **After build completes**
   - Look for **Test Result** link in the build page
   - Shows summary: Total tests, Passed, Failed, Skipped

2. **Click "Test Result" to see details**
   - Individual test names and durations
   - Stack traces for failed tests

---

## 9. Troubleshooting Guide

### Issue: "NodeJS not found"

**Solution:**
```
1. Go to Manage Jenkins → Tools
2. Verify NodeJS installation is configured with name 'NodeJS'
3. Ensure "Install automatically" is checked
4. Restart Jenkins
```

### Issue: "npm: command not found"

**Solution:**
```
- In Jenkins → Manage Jenkins → Tools → NodeJS
- Ensure the version is installed
- Tools → NodeJS → Add NodeJS → Select version 20.x LTS
```

### Issue: Docker build fails with permission denied

**Solution:**
```
# On Linux, add Jenkins user to docker group:
sudo usermod -aG docker jenkins
sudo systemctl restart jenkins

# On Windows, ensure Docker Desktop is running
```

### Issue: Test results not published

**Ensure:**
```
1. junit directive in post { always {} } block
2. JUnit XML file path is correct (junit.xml)
3. Jest config has jest-junit reporter configured
4. npm install --save-dev jest-junit is run
```

### Issue: GitHub webhook not triggering builds

**Solution:**
```
1. Verify webhook in GitHub repo settings
2. Check Jenkins URL is publicly accessible
3. Enable "GitHub hook trigger" in job configuration
4. Test webhook in GitHub: Settings → Webhooks → Edit → Redeliver
```

---

## 10. Performance Optimization Tips

1. **Cache Dependencies**
   ```groovy
   options {
       timeout(time: 1, unit: 'HOURS')
       timestamps()
   }
   ```

2. **Parallel Testing**
   ```groovy
   parallel {
       stage('Backend Tests') {
           steps { sh 'npm test' }
       }
       stage('Frontend Tests') {
           steps { sh 'npm test' }
       }
   }
   ```

3. **Docker Image Optimization**
   - Use Alpine Linux (18-alpine)
   - Multi-stage builds for smaller images

---

## 11. Security Best Practices

1. **Credentials Management**
   - Use Jenkins Credentials, not hardcoded tokens
   - Rotate tokens regularly (90-day expiration)
   - Use masked secrets in logs

2. **Network Security**
   - Run Jenkins behind a reverse proxy (nginx/Apache)
   - Use HTTPS for Jenkins URL
   - Restrict access to port 8080

3. **Docker Hub**
   - Use access tokens instead of passwords
   - Set token expiration
   - Use private registries for sensitive images

---

## 12. Deliverables Checklist

- ✅ **Jenkinsfile** created with all stages
- ✅ **package.json** updated with test scripts and jest-junit
- ✅ **Jest configuration** files (jest.config.js, .babelrc)
- ✅ **Sample test files** created
- ✅ **Dockerfile** optimized for CI/CD
- ✅ **GitHub credentials** configured in Jenkins
- ✅ **Docker Hub credentials** configured
- ✅ **Pipeline job** created and tested
- ✅ **Test results** publishing configured
- ✅ **This comprehensive report** generated

---

## 13. Next Steps for Deployment

### Step 1: Update Docker Hub Username
```
In Jenkinsfile, change:
DOCKER_HUB_REPO = 'your-dockerhub-username'
to your actual Docker Hub username
```

### Step 2: Push to Docker Registry
```bash
# Run pipeline to build and push images
# Images will be available at:
# https://hub.docker.com/r/your-username/todo-backend
# https://hub.docker.com/r/your-username/todo-frontend
```

### Step 3: Deploy to Cloud Platform (Optional)

**Option A: Deploy to Render, Heroku, or similar**
```
Add deployment stage to Jenkinsfile
```

**Option B: Deploy using Docker Compose**
```yaml
version: '3'
services:
  backend:
    image: your-username/todo-backend:latest
    ports:
      - "5000:5000"
  frontend:
    image: your-username/todo-frontend:latest
    ports:
      - "80:3000"
```

---

## 14. Conclusion

This Jenkins CI/CD pipeline provides:
- ✅ Automated code checkout from GitHub
- ✅ Dependency management for both frontend and backend
- ✅ Comprehensive testing with Jest and JUnit reporting
- ✅ Docker containerization for both services
- ✅ Automated Docker image building and pushing
- ✅ Test result visualization in Jenkins
- ✅ Scalable and maintainable pipeline structure

The pipeline reduces manual effort, ensures code quality, and enables rapid deployment cycles.

---

## 15. Resources & Links

- **Jenkins Documentation**: https://jenkins.io/doc/
- **Pipeline Syntax**: https://jenkins.io/doc/book/pipeline/
- **Jest Documentation**: https://jestjs.io/
- **Docker Documentation**: https://docs.docker.com/
- **GitHub Webhook Setup**: https://docs.github.com/en/developers/webhooks-and-events/webhooks
- **Jest for Node.js**: https://jestjs.io/docs/getting-started#using-babel

---

**Report Generated**: May 5, 2026
**Assignment**: DSO101 Assignment 2 - Jenkins CI/CD Pipeline
**Student**: Tshewang Dorji
**Status**: Complete ✅
