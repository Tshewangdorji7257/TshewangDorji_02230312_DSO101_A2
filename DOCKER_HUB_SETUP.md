# Docker Hub Setup & Integration Guide

## 📦 Docker Hub Account Setup

### Step 1: Create Docker Hub Account
1. Go to https://hub.docker.com
2. Click **Sign Up**
3. Fill in your details:
   - Username: `your-dockerhub-username`
   - Email: your email
   - Password: strong password
4. Verify email
5. **Login to Docker Hub**

### Step 2: Create Personal Access Token

1. **Go to Account Settings**
   - Click profile icon (top right) → **Account Settings**

2. **Create Token**
   - Click **Security** → **New Access Token**
   - Token name: `jenkins-docker-token`
   - Access permissions: **Read & Write**
   - Click **Generate**
   - **Copy and save the token** (won't be shown again)

### Step 3: Add Docker Credentials to Jenkins

1. **Go to Jenkins**
   - Navigate to **Manage Jenkins** → **Manage Credentials** → **System** → **Global credentials**

2. **Add New Credentials**
   - Click **+ Add Credentials**
   - **Kind**: Username and password
   - **Username**: Your Docker Hub username
   - **Password**: Your Docker Hub access token (paste from step 2)
   - **ID**: `docker-hub-creds`
   - **Description**: Docker Hub Personal Access Token
   - Click **Create**

---

## 🐳 Docker Commands Reference

### Local Docker Testing

```bash
# Build backend image
docker build -t your-username/todo-backend:latest -f backend/Dockerfile .

# Build frontend image
docker build -t your-username/todo-frontend:latest -f frontend/Dockerfile .

# Run backend
docker run -p 5000:5000 your-username/todo-backend:latest

# Run frontend
docker run -p 3000:3000 your-username/todo-frontend:latest

# Using Docker Compose
docker-compose up --build
```

### Push to Docker Hub

```bash
# Login to Docker Hub
docker login

# Push backend image
docker push your-username/todo-backend:latest

# Push frontend image
docker push your-username/todo-frontend:latest

# Logout
docker logout
```

---

## 🔄 Automated Docker Push via Jenkins

The Jenkinsfile automatically:

1. **Builds Docker images**
   ```groovy
   sh 'docker build -t ${DOCKER_IMAGE_BACKEND} -f backend/Dockerfile .'
   sh 'docker build -t ${DOCKER_IMAGE_FRONTEND} -f frontend/Dockerfile .'
   ```

2. **Pushes to Docker Hub** (with credentials)
   ```groovy
   withCredentials([usernamePassword(
       credentialsId: 'docker-hub-creds',
       usernameVariable: 'DOCKER_USER',
       passwordVariable: 'DOCKER_PASS'
   )]) {
       sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
       sh 'docker push ${DOCKER_IMAGE_BACKEND}'
       sh 'docker push ${DOCKER_IMAGE_FRONTEND}'
   }
   ```

---

## 📋 Configuration in Jenkinsfile

Update these values in your `Jenkinsfile`:

```groovy
environment {
    DOCKER_HUB_REPO = 'your-dockerhub-username'  // ← Change this
    DOCKER_IMAGE_BACKEND = "${DOCKER_HUB_REPO}/todo-backend:${BUILD_NUMBER}"
    DOCKER_IMAGE_FRONTEND = "${DOCKER_HUB_REPO}/todo-frontend:${BUILD_NUMBER}"
}
```

---

## 🎯 Docker Hub Repository Management

### After First Push

Your Docker Hub images will be available at:
- Backend: `https://hub.docker.com/r/your-username/todo-backend`
- Frontend: `https://hub.docker.com/r/your-username/todo-frontend`

### View Image Details

1. Go to Docker Hub
2. Click on your image
3. View:
   - Image tags (versions)
   - Build history
   - Dockerfile
   - Pull command

### Pull Images

```bash
# Pull backend
docker pull your-username/todo-backend:latest

# Pull frontend
docker pull your-username/todo-frontend:latest

# Run from Docker Hub (no local build needed)
docker run -p 5000:5000 your-username/todo-backend:latest
```

---

## 🔐 Security Best Practices

1. **Token Rotation**
   - Regenerate tokens every 90 days
   - Delete old tokens after creating new ones

2. **Private Repositories** (Optional)
   - Set repository visibility to Private
   - Share only with authorized users
   - Requires authentication to pull

3. **Image Scanning**
   - Docker Hub automatically scans for vulnerabilities
   - Check "Security Scanning" tab in repository
   - Update dependencies if vulnerabilities found

4. **Never Commit Secrets**
   - Don't include credentials in Dockerfiles
   - Use environment variables
   - Use build arguments when needed

---

## 📊 Monitoring Builds

### View Build History in Docker Hub

1. Go to your image on Docker Hub
2. Click **Tags** tab
3. See all builds with timestamps and sizes

### Typical Image Sizes

- Backend (Node.js + Express): ~150-200 MB
- Frontend (React + Build): ~100-150 MB

### Optimize Image Size

```dockerfile
# Use Alpine for smaller base images
FROM node:18-alpine  # ~150 MB vs ~300 MB

# Multi-stage builds to reduce final size
FROM node:18-alpine AS builder
# ... build step ...

FROM node:18-alpine
COPY --from=builder /app/dist ./dist
```

---

## 🚀 Example Docker Hub URLs

After successful push, your images will be at:

**Backend Image:**
```
docker.io/your-username/todo-backend:1
docker.io/your-username/todo-backend:2
docker.io/your-username/todo-backend:latest
```

**Frontend Image:**
```
docker.io/your-username/todo-frontend:1
docker.io/your-username/todo-frontend:2
docker.io/your-username/todo-frontend:latest
```

---

## 📝 Jenkins Log Example

When your pipeline pushes to Docker Hub, you'll see:

```
[Pipeline] stage
[Pipeline] { (Push to Docker Hub)
[Pipeline] script
[Pipeline] withCredentials
Masking supported pattern matches of $DOCKER_PASS
+ echo ****
+ docker login -u your-username --password-stdin
Login Succeeded
+ docker push your-username/todo-backend:1
The push refers to repository [docker.io/your-username/todo-backend]
abc123def456: Pushed
xyz789: Pushed
1: digest: sha256:abcd1234... size: 1234
+ docker push your-username/todo-frontend:1
The push refers to repository [docker.io/your-username/todo-frontend]
...
Pushed successfully!
```

---

## ✅ Verification Steps

1. ✅ Docker Hub account created
2. ✅ Personal Access Token generated
3. ✅ Token added to Jenkins credentials (ID: `docker-hub-creds`)
4. ✅ Jenkinsfile updated with your Docker Hub username
5. ✅ Build executed successfully
6. ✅ Images visible in Docker Hub repository
7. ✅ Can pull images locally: `docker pull your-username/todo-backend`

---

## 🆘 Troubleshooting

### Error: "denied: requested access to the resource is denied"
```
Solution: Check Docker Hub credentials in Jenkins
Verify token hasn't expired
Regenerate token if needed
```

### Error: "docker login" fails
```
Solution: Verify credentials are correctly added
Check Jenkinsfile has correct credentials ID
Clear Jenkins credential cache and re-add
```

### Images not appearing in Docker Hub
```
Solution: Check Jenkins build logs for push errors
Verify credentials are correct
Check Docker Hub repository is not private (or auth is set)
```

### Image size too large
```
Solution: Use Alpine base images
Use multi-stage builds
Remove unnecessary dependencies
```

---

**Setup Complete!** Your Docker Hub integration is ready. ✅
