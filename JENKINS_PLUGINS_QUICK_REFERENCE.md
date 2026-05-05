# Jenkins Plugins Quick Reference Guide

## Which Plugins to Select - Visual Guide

When searching for "pipeline" in Jenkins Plugin Manager, you'll see several options. Here's which ones to select:

### ✅ SELECT THESE:

| Plugin Name | What It Does | Priority |
|------------|-------------|----------|
| **Pipeline** | Core declarative pipeline support | ⭐⭐⭐ **REQUIRED** |
| **NodeJS Plugin** | Provides Node.js and npm support | ⭐⭐⭐ **REQUIRED** |
| **GitHub Integration** | GitHub webhook and credential support | ⭐⭐⭐ **REQUIRED** |
| **Docker Pipeline** | Docker build/push commands in pipeline | ⭐⭐⭐ **REQUIRED** |
| **Pipeline: Stage View** | Visual pipeline stage display | ⭐⭐ Optional but nice |
| **Timestamper** | Timestamp in build logs | ⭐ Nice to have |

### ❌ DO NOT SELECT THESE (They're just helpers/libraries):

| Plugin Name | Why Skip It |
|------------|-----------|
| Pipeline Graph Analysis | Helper for other plugins only |
| Pipeline: REST API | API access (not needed for basic setup) |
| Pipeline: Declarative | Already included in Pipeline |
| Pipeline: Shared Groovy Libraries | Advanced feature (not needed now) |

---

## Step-by-Step: Finding "Pipeline" Plugin

### Search Results You'll See:

```
Search Results for "pipeline":

1. Pipeline Graph Analysis (254.v0f63a)
   ↓
2. Pipeline: REST API (2.41)
   ↓
3. Pipeline: Stage View (2.41)  ← Nice visual display
   ↓
4. Docker Pipeline (634.vedc7242b)
   ↓
5. ⭐ LOOK FOR: Pipeline (Core or just "Pipeline")
   ← THIS IS THE ONE YOU NEED!
```

---

## Visual Identification

### Correct "Pipeline" Plugin Looks Like:

- **Name**: Just "Pipeline" (not "Pipeline: ...")
- **Icon**: Usually a blue/navy icon with pipeline symbol
- **Description**: "Standard declarative pipeline support"
- **Released**: Usually recent
- **Health**: Shows good/green health score

### Example (from Jenkins docs):

```
Pipeline
Version: 2.41 or higher
Type: Pipeline, plugin
Description: Provides declarative pipeline syntax support
Health Score: 100 (Good)
Last updated: Recently
```

---

## What Each Plugin Does

### Plugin 1: NodeJS Plugin
```
Purpose: Installs Node.js and npm
Used For: Running npm commands
In Pipeline: tools { nodejs 'NodeJS' }
Why Needed: Can't run npm without it
```

### Plugin 2: Pipeline (CORE)
```
Purpose: Enables declarative pipeline syntax
Used For: Creating Jenkinsfile
In Pipeline: pipeline { stages { ... } }
Why Needed: Foundation of CI/CD pipeline
🔴 IF YOU SKIP THIS: PIPELINE WON'T WORK
```

### Plugin 3: GitHub Integration
```
Purpose: Connects Jenkins to GitHub
Used For: Cloning repo, webhooks
In Pipeline: git branch: 'main', url: 'https://github.com/...'
Why Needed: Can't access GitHub without it
```

### Plugin 4: Docker Pipeline
```
Purpose: Docker commands in pipeline
Used For: Building and pushing Docker images
In Pipeline: docker.build(...), docker.push(...)
Why Needed: Without it, docker commands fail
```

### Plugin 5: Pipeline: Stage View (Optional)
```
Purpose: Visual display of pipeline stages
Used For: Better visualization in Jenkins UI
Why Optional: Doesn't affect pipeline execution
Nice To Have: Makes it easier to see progress
```

---

## Common Mistakes to Avoid

### ❌ Mistake 1: Selecting "Pipeline Graph Analysis"
- This is a **helper plugin** for developers
- It doesn't provide pipeline functionality
- Skip it

### ❌ Mistake 2: Selecting "Pipeline: REST API"
- This is for **API access** to pipeline data
- Not needed for basic CI/CD
- Skip it

### ❌ Mistake 3: Not selecting "Pipeline" at all
- **CRITICAL**: Without this, your Jenkinsfile won't work
- Must have for declarative pipelines
- Don't skip!

### ❌ Mistake 4: Missing "Docker Pipeline"
- If you want to push Docker images, you need this
- Without it, docker.push() commands fail
- Include if using Docker

---

## Exact Search Instructions

1. **Go to**: Manage Jenkins → Manage Plugins → Available tab

2. **Search for**: `pipeline`
   - Type exactly: `pipeline`
   - Press Enter

3. **In Results, Select These Checkboxes**:

   ```
   ☑️ NodeJS Plugin
   ☑️ Pipeline
   ☑️ GitHub Integration
   ☑️ Docker Pipeline
   ☑️ Pipeline: Stage View (optional)
   ☑️ Timestamper (optional)
   ```

4. **Scroll Down**
   - Find **Install without restart** button
   - Click it

5. **Wait for Installation**
   - All plugins should show ✅ green checkmark
   - Then click **Restart Jenkins**

---

## If You Can't Find the Right Plugin

### Solution 1: Clear Search and Try Again
- Delete your search
- Wait 2 seconds
- Type `pipeline` again
- Look for the main one

### Solution 2: Install "Pipeline" First
- Search for `pipeline`
- Select the core "Pipeline" plugin ONLY
- Click Install without restart
- Then search for others

### Solution 3: Check Already Installed
- Click **Installed** tab
- Search for `pipeline`
- See if "Pipeline" is already there
- If yes, you don't need to install it again

---

## Summary: The 4 MUST-HAVE Plugins

| # | Plugin | Search Term | Select? |
|---|--------|-------------|---------|
| 1 | NodeJS Plugin | `nodejs` | ✅ YES |
| 2 | Pipeline | `pipeline` (just "Pipeline") | ✅ YES |
| 3 | GitHub Integration | `github` | ✅ YES |
| 4 | Docker Pipeline | `docker` | ✅ YES |

**If you have these 4, your pipeline will work!**

---

## After Installation

### Verify Plugins Installed:

1. Go to: **Manage Jenkins** → **Manage Plugins**
2. Click **Installed** tab
3. Search for: `pipeline`
4. You should see all of them listed with version numbers

### Example of Successful Installation:

```
✅ Pipeline                    2.41
✅ NodeJS Plugin               1.6.1
✅ GitHub Integration          1.38.1
✅ Docker Pipeline             634.vedc7242b
```

All showing ✅ = Ready to use!

---

## Troubleshooting: Pipeline Plugin Issues

### Issue: "Pipeline plugin not found"
**Solution**: 
- Check Installed tab
- If not there, search and install manually
- Restart Jenkins after install

### Issue: "Jenkinsfile syntax error"
**Solution**:
- Verify Pipeline plugin is installed
- Restart Jenkins
- Check Jenkinsfile syntax

### Issue: "Cannot find nodejs tool"
**Solution**:
- Install NodeJS Plugin
- Go to Manage Jenkins → Tools
- Add NodeJS v20.x

---

## Quick Verification Checklist

After installing plugins:

- ✅ Manage Jenkins page loads without errors
- ✅ Can see "Tools" option in Manage Jenkins
- ✅ Can create a new "Pipeline" job type
- ✅ Jenkinsfile syntax highlighting works
- ✅ Can see GitHub integration options

If all ✅, you're ready to proceed!

---

**You're all set! The Pipeline core plugin is the one you need.** 🎉
