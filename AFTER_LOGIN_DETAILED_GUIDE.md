# Jenkins Setup - After Login Complete Guide

**Status**: ✅ Jenkins Installed & Logged In  
**Next**: Configure plugins, credentials, and create pipeline

---

## 📋 Complete Next Steps Overview

```
Current Status: Logged into Jenkins ✅
     ↓
Step 1: Install Required Plugins
     ↓
Step 2: Configure Node.js Tool
     ↓
Step 3: Add GitHub Credentials
     ↓
Step 4: Add Docker Hub Credentials (Optional)
     ↓
Step 5: Create Pipeline Job
     ↓
Step 6: Run Pipeline
     ↓
✅ COMPLETE: Working CI/CD Pipeline!
```

---

# STEP 1: Install Required Plugins

## 1.1 Go to Plugin Manager

1. Click **Manage Jenkins** (on left sidebar)
2. Click **Manage Plugins**
3. Click **Available** tab (at the top)
4. Wait for plugins to load (2-3 seconds)

## 1.2 Search and Install Plugin #1: NodeJS Plugin

1. **In the search box**, type: `nodejs`
2. **Find**: NodeJS Plugin (version 1.6.x or higher)
3. **Check the checkbox** next to it
4. **Click**: Install without restart

## 1.3 Search and Install Plugin #2: Pipeline

1. **Clear search box** (delete "nodejs")
2. **Type**: `pipeline`
3. **Find**: "Pipeline" (just "Pipeline", not "Pipeline: REST API" or others)
4. **Check the checkbox**
5. **Click**: Install without restart

## 1.4 Search and Install Plugin #3: GitHub Integration

1. **Clear search box**
2. **Type**: `github`
3. **Find**: "GitHub Integration"
4. **Check the checkbox**
5. **Click**: Install without restart

## 1.5 Search and Install Plugin #4: Docker Pipeline

1. **Clear search box**
2. **Type**: `docker`
3. **Find**: "Docker Pipeline"
4. **Check the checkbox**
5. **Click**: Install without restart

## 1.6 Restart Jenkins

After all 4 plugins show ✅ green checkmarks:

1. **Scroll to bottom** of page
2. **Find**: "Restart Jenkins" link or button
3. **Click it**
4. **Wait 2-3 minutes** for Jenkins to restart
5. **Refresh your browser** (F5 or Ctrl+R)
6. **Log back in** with your credentials

---

# STEP 2: Configure Node.js Tool

After Jenkins restarts and you're logged back in:

## 2.1 Go to Tools Configuration

1. Click **Manage Jenkins** (left sidebar)
2. Click **Tools** (look for it in the list)
3. **Scroll down** until you find **NodeJS installations**

## 2.2 Add Node.js Installation

1. **Click**: Add NodeJS
2. **Fill in the form**:

```
Name: NodeJS
(This MUST be exactly "NodeJS" - case sensitive!)

Version: 20.x
(Select from dropdown)

Check: ✓ Install automatically
(This will auto-download Node.js)
```

3. **Click**: Save (at bottom of page)

### Screenshot Example of What You Should See:
```
Manage Jenkins > Tools > NodeJS installations

☑ NodeJS
  Name: [NodeJS           ]
  Version: [20.x LTS      ▼]
  ☑ Install automatically

  [+ Add NodeJS] [Delete]
```

---

# STEP 3: Add GitHub Credentials

This lets Jenkins access your GitHub repository.

## 3.1 Go to Credentials Manager

1. Click **Manage Jenkins** (left sidebar)
2. Click **Manage Credentials**
3. Click **System** (in the left sidebar)
4. Click **Global credentials (unrestricted)**

## 3.2 Add New Credentials

1. **Click**: + Add Credentials (left sidebar)
2. **Fill in the form**:

```
Kind: Username and password
(Select from dropdown)

Username: [Your GitHub username]
(Example: Tshewangdorji7257)

Password: [Your GitHub PAT]
(The Personal Access Token you created earlier)

ID: github-credentials
(This is important - must be exactly this)

Description: GitHub Personal Access Token
(Optional)
```

3. **Click**: Create

### What You Should See After:
```
Credentials List
├─ github-credentials ✅
│  Type: Username and password
│  Username: your-github-username
```

---

# STEP 4: Add Docker Hub Credentials (Optional)

**Only do this if you want to push Docker images to Docker Hub**

## 4.1 Go to Credentials Manager (Again)

1. Click **Manage Jenkins**
2. Click **Manage Credentials**
3. Click **System**
4. Click **Global credentials (unrestricted)**

## 4.2 Add Docker Hub Credentials

1. **Click**: + Add Credentials
2. **Fill in the form**:

```
Kind: Username and password

Username: [Your Docker Hub username]

Password: [Your Docker Hub access token or password]

ID: docker-hub-creds
(Must be exactly this for Jenkinsfile to work)

Description: Docker Hub Personal Access Token
(Optional)
```

3. **Click**: Create

### After Creating Both Credentials:
```
Credentials List
├─ github-credentials ✅
│  Type: Username and password
├─ docker-hub-creds ✅
│  Type: Username and password
```

---

# STEP 5: Create Pipeline Job

## 5.1 Go to Jenkins Home

1. Click **Jenkins** logo (top left) to go to home page
2. Or go to: http://localhost:8080

## 5.2 Create New Item

1. Click **+ New Item** (or "New Job")
2. You'll see a form

## 5.3 Fill in Job Details

```
Enter an item name:
[todo-app-pipeline]
(This is the job name - you'll see this in Jenkins)

Select an item type:
☑ Pipeline
(Click the Pipeline option)
```

3. **Click**: OK

## 5.4 Configure Pipeline

Now you're on the job configuration page.

### Section 1: General (Top of page)
```
☑ This project is parameterized
(Leave unchecked for now)

☑ GitHub project
(Optional - you can check this)
Project url: https://github.com/Tshewangdorji7257/TshewangDorji_02230312_DSO101_A2/
```

### Section 2: Build Triggers (Middle of page)
```
☑ GitHub hook trigger for GITScm polling
(Optional - for automatic builds when you push)
```

### Section 3: Pipeline (Bottom of page)

**IMPORTANT**: Scroll all the way to the bottom!

```
Definition: Pipeline script from SCM
(Select from dropdown)

SCM: Git
(Select from dropdown)

Repository URL:
https://github.com/Tshewangdorji7257/TshewangDorji_02230312_DSO101_A2.git

Credentials:
[github-credentials ▼]
(Select your GitHub credentials)

Branch Specifier:
*/main

Script Path:
Jenkinsfile
(This tells Jenkins where to find the pipeline instructions)
```

## 5.5 Save Configuration

1. **Scroll to bottom**
2. **Click**: Save

You're now back on the job page. You should see:
```
todo-app-pipeline
Build Now
Schedule Build
...
```

---

# STEP 6: Run the Pipeline (First Build)

## 6.1 Click Build Now

1. **Click**: Build Now (left sidebar)
2. You'll see **Build #1** start

## 6.2 Monitor the Build

1. **Click** on the build number (e.g., "#1")
2. **Click**: Console Output
3. **Watch the logs** as the build runs

### What You Should See:

```
Started by user (your username)
[Pipeline] node
Running in ~/Jenkins/workspace/todo-app-pipeline

[Pipeline] stage
[Pipeline] { (Checkout)
Cloning the repository...
...

[Pipeline] stage
[Pipeline] { (Install Dependencies - Backend)
npm install
...

[Pipeline] stage
[Pipeline] { (Install Dependencies - Frontend)
npm install
...

[Pipeline] stage
[Pipeline] { (Build - Frontend)
npm run build
...

[Pipeline] stage
[Pipeline] { (Test - Backend)
npm test
...

[Pipeline] stage
[Pipeline] { (Test - Frontend)
npm test
...

[Pipeline] stage
[Pipeline] { (Build Docker Images)
docker build...
...

[Pipeline] stage
[Pipeline] { (Push to Docker Hub)
docker push...
...

Finished: SUCCESS ✅
```

## 6.3 Check Results

### If Build is SUCCESS (Green ✅):
1. Go back to job page
2. Look for **Test Result** link
3. Click to see test details
4. Go to Docker Hub to see pushed images

### If Build is FAILURE (Red ❌):
1. Click on the build number
2. Click **Console Output**
3. Find the error message
4. Check troubleshooting section

---

# Quick Summary of All Steps

## ✅ Checklist After Logging In

### Phase 1: Plugins (15 minutes)
- [ ] Go to Manage Jenkins → Manage Plugins
- [ ] Install: NodeJS Plugin
- [ ] Install: Pipeline
- [ ] Install: GitHub Integration
- [ ] Install: Docker Pipeline
- [ ] Restart Jenkins
- [ ] Log back in

### Phase 2: Configuration (10 minutes)
- [ ] Go to Manage Jenkins → Tools
- [ ] Configure NodeJS (name: NodeJS, version: 20.x)
- [ ] Go to Manage Jenkins → Credentials
- [ ] Add GitHub credentials (ID: github-credentials)
- [ ] Add Docker Hub credentials (ID: docker-hub-creds)

### Phase 3: Pipeline Job (5 minutes)
- [ ] Go to Jenkins Home
- [ ] Click "New Item"
- [ ] Name: todo-app-pipeline
- [ ] Type: Pipeline
- [ ] Definition: Pipeline script from SCM
- [ ] SCM: Git
- [ ] Repository URL: Your GitHub repo
- [ ] Credentials: github-credentials
- [ ] Branch: */main
- [ ] Script Path: Jenkinsfile
- [ ] Click Save

### Phase 4: First Build (10 minutes)
- [ ] Click "Build Now"
- [ ] Monitor Console Output
- [ ] Wait for "Finished: SUCCESS"
- [ ] Check Test Results
- [ ] Verify Docker images in Docker Hub

**Total Time: ~40 minutes**

---

# Troubleshooting During Setup

## Issue 1: Plugin Installation Fails

**Error**: "Cannot install plugin"

**Solution**:
1. Go back to Available plugins
2. Search again
3. Try installing one at a time
4. Restart Jenkins between installs

## Issue 2: NodeJS Tool Not Found

**Error**: "NodeJS not configured"

**Solution**:
1. Go to Manage Jenkins → Tools
2. Verify NodeJS is there
3. Name must be exactly: `NodeJS`
4. Save and restart Jenkins

## Issue 3: GitHub Credentials Not Working

**Error**: "fatal: Authentication failed"

**Solution**:
1. Check GitHub PAT is correct
2. Verify it hasn't expired
3. Check credentials ID is: `github-credentials`
4. Delete and recreate credentials

## Issue 4: Build Fails Immediately

**Error**: "Cannot find npm"

**Solution**:
1. Verify NodeJS plugin installed
2. Verify NodeJS tool configured
3. Restart Jenkins
4. Try building again

---

# What Happens Next After First Successful Build

1. ✅ Pipeline runs automatically
2. ✅ Tests are executed
3. ✅ Docker images are built and pushed
4. ✅ Test results appear in Jenkins
5. ✅ Everything is logged

**You can then**:
- Push code to GitHub → Pipeline runs automatically
- Monitor builds in Jenkins dashboard
- View test results
- Manage Docker images

---

# Navigation Tips

### Quick Access Links

- **Jenkins Home**: http://localhost:8080
- **Your Pipeline Job**: http://localhost:8080/job/todo-app-pipeline
- **Build Console**: http://localhost:8080/job/todo-app-pipeline/1/console
- **Test Results**: http://localhost:8080/job/todo-app-pipeline/1/testReport
- **Manage Jenkins**: http://localhost:8080/manage
- **Manage Plugins**: http://localhost:8080/manage/pluginManager
- **Manage Credentials**: http://localhost:8080/manage/credentials

---

# Important Reminders

1. **GitHub Credentials ID**: Must be `github-credentials`
2. **Docker Credentials ID**: Must be `docker-hub-creds`
3. **NodeJS Tool Name**: Must be `NodeJS` (case sensitive)
4. **Branch**: Must be `*/main` (unless your branch is different)
5. **Script Path**: Must be `Jenkinsfile`

---

# You're All Set! 🎉

Follow these steps in order:
1. Install 4 plugins
2. Configure Node.js
3. Add credentials
4. Create pipeline job
5. Run first build

**Everything should work smoothly!**

---

**Questions about any step? Let me know!**
