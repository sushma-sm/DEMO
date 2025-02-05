pipeline {
    agent any
    environment {
        DOCKER_IMAGE = 'sushmamounika/my-repo-sm:latest'  // Define the Docker image name
    }
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/sushma-sm/DEMO.git'  // Ensure the URL is inside quotes
            }
        }
        stage('Build') {
            steps {
                sh 'mvn clean install'
            }
        }
        stage('Docker Build') {
            steps {
                script {
                    // Build the Docker image
                    sh 'docker build -t ${DOCKER_IMAGE} .'
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                withDockerRegistry([credentialsId: 'dockerhub-credentials', url: 'https://index.docker.io/v1/']) {
                    sh 'docker push ${DOCKER_IMAGE}'
                }
            }
        }
        stage('Deploy') {
            steps {
                sh 'echo "Deploying to server"'
            }
        }
    }
}
