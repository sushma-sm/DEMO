pipeline {
    agent any
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
        stage('Deploy') {
            steps {
                sh 'echo "Deploying to server"'
            }
        }
    }
}
