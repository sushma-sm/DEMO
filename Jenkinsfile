pipeline {
    agent any
    environment {
        REPO_URL = 'https://github.com/sushma-sm/DEMO.git'
        DOCKER_IMAGE = 'sushmamounika/my-repo-sm:build-001'
    }
    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: "${REPO_URL}"
            }
        }
        stage('Build Maven Project') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t ${DOCKER_IMAGE} .'
            }
        }
        stage('Push Docker Image') {
            steps {
                withDockerRegistry([credentialsId: 'dockerhub-credentials', url: 'https://registry.hub.docker.com']) {
                    sh 'docker push ${DOCKER_IMAGE}'
                }
            }
        }
        stage('Terraform Init') {
            steps {
                script {
                    sh """
                        export GOOGLE_APPLICATION_CREDENTIALS=\$GOOGLE_CREDENTIALS
                        terraform init
                    """
                }
            }
        }
        stage('Terraform Plan') {
            steps {
                script {
                    sh """
                        export GOOGLE_APPLICATION_CREDENTIALS=\$GOOGLE_CREDENTIALS
                        terraform plan
                    """
                }
            }
        }
        stage('Terraform Apply') {
            steps {
                script {
                    sh """
                        export GOOGLE_APPLICATION_CREDENTIALS=\$GOOGLE_CREDENTIALS
                        terraform apply -auto-approve
                    """
                }
            }
        }
        stage('Run Docker Container') {
            steps {
                sh 'docker run -d -p 8082:8080 ${DOCKER_IMAGE}'
            }
        }
        stage('Run Ansible Playbook') {
            steps {
                script {
                    sh """
                        ansible-playbook deploy_docker.yml -e "docker_image=${DOCKER_IMAGE}"
                    """
                }
            }
    }
}
