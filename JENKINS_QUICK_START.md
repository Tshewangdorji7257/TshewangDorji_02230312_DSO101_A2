# Jenkins Pipeline Quick Setup Guide

## 🚀 Quick Start (5 Minutes)

### 1. Prerequisites
- ✅ Java 11+ installed
- ✅ Docker installed (for containerization)
- ✅ GitHub account with your repository
- ✅ Docker Hub account (optional, for pushing images)

### 2. Install Jenkins (Windows)

```powershell
# Download Jenkins from https://jenkins.io/download
# Run the .msi installer
# Jenkins will run at http://localhost:8080
```

### 3. Complete Jenkins Setup (10 Minutes)

```
1. Go to http://localhost:8080
2. Unlock Jenkins with the initial password
3. Install suggested plugins
4. Create admin user
```

### 4. Install Required Plugins (5 Minutes)

**Go to: Manage Jenkins → Manage Plugins → Available**

Search and install:
- NodeJS Plugin
- Pipeline
- GitHub Integration
- Docker Pipeline
- JUnit Plugin (usually pre-installed)

### 5. Configure Node.js (2 Minutes)

**Go to: Manage Jenkins → Tools → NodeJS installations**

Add:
- Name: `NodeJS`
- Version: `20.x LTS`
- ✅ Install automatically

Click Save

### 6. Add GitHub Credentials (5 Minutes)

**Go to: Manage Jenkins → Manage Credentials → System → Global credentials**

Add Credentials:
- Kind: Username and password
- Username: Your GitHub username
- Password: Your GitHub Personal Access Token
- ID: `github-credentials`
- Description: GitHub PAT

### 7. Create Pipeline Job (3 Minutes)

**Go to: Jenkins Home → + New Item**

- Job name: `todo-app-pipeline`
- Type: **Pipeline**
- Definition: **Pipeline script from SCM**
- SCM: **Git**
- Repository URL: `https://github.com/Tshewangdorji7257/TshewangDorji_02230312_DSO101_A2.git`
- Credentials: Select `github-credentials`
- Branch: `*/main`
- Script Path: `Jenkinsfile`

Click Save

### 8. Run Pipeline

**Click: Build Now**

Monitor progress in Console Output

---

## 📊 View Test Results

After successful build:
1. Click on build number (e.g., #1)
2. Click "Test Result" link
3. See all test details with pass/fail status

---

## 🐳 Docker Configuration

### Build and Push to Docker Hub

1. Add Docker Hub credentials:
   - Go to Manage Jenkins → Manage Credentials
   - Add Username and Password
   - ID: `docker-hub-creds`

2. Update Jenkinsfile:
   ```groovy
   DOCKER_HUB_REPO = 'your-dockerhub-username'
   ```

3. Build will automatically push to Docker Hub

### Run Locally with Docker Compose

```bash
# From project root
docker-compose up --build

# Frontend: http://localhost:3000
# Backend: http://localhost:5000
```

---

## ✅ Verification Checklist

- [ ] Jenkins running on http://localhost:8080
- [ ] All plugins installed
- [ ] Node.js v20 configured
- [ ] GitHub credentials added
- [ ] Pipeline job created
- [ ] Build successful (green checkmark)
- [ ] Tests passed and published
- [ ] Docker images built (if Docker enabled)

---

## 🆘 Quick Troubleshooting

### Build fails at npm install
```
Solution: Ensure Node.js is properly configured in Jenkins Tools
```

### Tests not showing in Jenkins
```
Solution: Verify junit directive exists in Jenkinsfile post block
Verify jest-junit is installed in package.json
```

### Docker push fails
```
Solution: Add docker-hub-creds in Jenkins Credentials
Update Jenkinsfile with your Docker Hub username
```

### GitHub webhook not working
```
Solution: Add webhook in GitHub repo settings
Configure Jenkins URL in Jenkins System settings
Enable "GitHub hook trigger" in job
```

---

## 📚 Full Documentation

See `JENKINS_PIPELINE_REPORT.md` for complete setup guide

---

## 🎯 Next Steps

1. ✅ Complete setup above
2. ✅ Run "Build Now" to test pipeline
3. ✅ Check test results
4. ✅ Push Docker images to Docker Hub (optional)
5. ✅ Set up GitHub webhooks for auto-triggering
6. ✅ Configure deployment (Render, Heroku, AWS, etc.)

---

**Pipeline Status**: ✅ Ready for Use
**All configurations**: ✅ Complete
**Tests**: ✅ Enabled with JUnit reporting
