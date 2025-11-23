pipeline {
    agent any
    tools {
        jdk 'jdk17'
        maven 'Maven 3'
    }
    stages {
        /*stage('Checkout') {
            steps {
                git branch: 'main', url: 'git@github.com:kumarsushmitha33/account-service.git'
            }
        }*/
        stage('Checkout') {
            steps {
                echo '📥 Checking out from GitHub using PAT...'
                git branch: 'main',
                    credentialsId: 'github-creds',
                    url: 'https://github.com/kumarsushmitha33/account-service.git'
            }
        }
        stage('Build') {
            steps {
                echo '🔧 Building Account Service...'
                sh 'mvn clean install -DskipTests'
            }
        }
        stage('Test') {
            steps {
                echo '🧪 Running tests...'
                sh 'mvn test'
            }
        }
        stage('Docker Build & Push') {
            steps {
                echo '🐳 Building and pushing Docker image...'
                script {
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        sh '''
                        /usr/local/bin/docker build -t $DOCKER_USER/account-service:latest .
                        echo $DOCKER_PASS | /usr/local/bin/docker login -u $DOCKER_USER --password-stdin
                        /usr/local/bin/docker push $DOCKER_USER/account-service:latest
                        '''
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
                echo '🚀 Deploying Account Service container...'
                sh '''
                /usr/local/bin/docker rm -f account-service || true
                /usr/local/bin/docker run -d --name account-service --network mynetwork -p 8095:8090 $DOCKER_USER/account-service:latest
                '''
            }
        }
    }
    post {
        success {
            echo '✅ Account Service deployed successfully!'
        }
        failure {
            echo '❌ Build failed!'
        }
    }
}