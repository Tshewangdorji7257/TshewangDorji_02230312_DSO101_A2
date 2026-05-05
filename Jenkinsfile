pipeline {
    agent any

    environment {
        DOCKER_HUB_REPO = 'your-dockerhub-username'  // Replace with your Docker Hub username
        DOCKER_IMAGE_BACKEND = "${DOCKER_HUB_REPO}/todo-backend:${BUILD_NUMBER}"
        DOCKER_IMAGE_FRONTEND = "${DOCKER_HUB_REPO}/todo-frontend:${BUILD_NUMBER}"
        GITHUB_REPO = 'https://github.com/Tshewangdorji7257/TshewangDorji_02230312_DSO101_A2.git'
    }

    tools {
        nodejs 'NodeJS'
    }

    stages {
        stage('Checkout') {
            steps {
                echo '📦 Checking out code from GitHub...'
                git branch: 'main',
                    url: "${GITHUB_REPO}"
            }
        }

        stage('Install Dependencies - Backend') {
            steps {
                echo '🔧 Installing backend dependencies...'
                dir('backend') {
                    bat 'npm install'
                }
            }
        }

        stage('Install Dependencies - Frontend') {
            steps {
                echo '🔧 Installing frontend dependencies...'
                dir('frontend') {
                    bat 'npm install'
                }
            }
        }

        stage('Build - Frontend') {
            steps {
                echo '🏗️ Building frontend application...'
                dir('frontend') {
                    bat 'npm run build'
                }
            }
        }

        stage('Test - Backend') {
            steps {
                echo '✅ Running backend tests...'
                dir('backend') {
                    bat 'npm test'
                }
            }
            post {
                always {
                    junit 'backend/junit.xml'
                    echo '📊 Backend test results published'
                }
            }
        }

        stage('Test - Frontend') {
            steps {
                echo '✅ Running frontend tests...'
                dir('frontend') {
                    bat 'npm test'
                }
            }
            post {
                always {
                    junit 'frontend/junit.xml'
                    echo '📊 Frontend test results published'
                }
            }
        }

        stage('Build Docker Images') {
            steps {
                echo '🐳 Building Docker images...'
                script {
                    bat 'docker build -t %DOCKER_IMAGE_BACKEND% -f backend/Dockerfile .'
                    bat 'docker build -t %DOCKER_IMAGE_FRONTEND% -f frontend/Dockerfile .'
                    echo '✅ Docker images built successfully'
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                echo '📤 Pushing images to Docker Hub...'
                script {
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        bat 'echo %DOCKER_PASS% | docker login -u %DOCKER_USER% --password-stdin'
                        bat 'docker push %DOCKER_IMAGE_BACKEND%'
                        bat 'docker push %DOCKER_IMAGE_FRONTEND%'
                        echo '✅ Images pushed to Docker Hub'
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                echo '🚀 Deploying application...'
                script {
                    echo "Backend image: ${DOCKER_IMAGE_BACKEND}"
                    echo "Frontend image: ${DOCKER_IMAGE_FRONTEND}"
                    echo '✅ Ready for deployment (Configure with your deployment platform)'
                }
            }
        }
    }

    post {
        always {
            echo '🧹 Cleaning up...'
            cleanWs()
        }
        success {
            echo '✅ Pipeline executed successfully!'
        }
        failure {
            echo '❌ Pipeline failed! Check the logs above.'
        }
    }
}
