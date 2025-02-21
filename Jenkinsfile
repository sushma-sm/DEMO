pipeline {
    agent any
    environment {
        REPO_URL = 'https://github.com/sushma-sm/DEMO.git'
        DOCKER_IMAGE = 'sushmamounika/my-repo-sm:build-001'
        MAVEN_SETTINGS = '/var/jenkins_home/.m2/settings.xml' // Adjust based on your Jenkins setup
        FLUX_REPO = '/home/gurajasushmamounika/DEMO/clusters/demo-cluster/'  // Path where FluxCD watches changes
        GIT_BRANCH = 'main'
    }
    stages {
        stage('Clone Repository') {
            steps {
                script {
                    dir('workspace') {
                        git branch: "${env.GIT_BRANCH}", url: "${env.REPO_URL}"
                    }
                }
            }
        }
        stage('Build') {
            steps {
                script {
                    dir('workspace') {
                        sh "mvn clean package -s ${env.MAVEN_SETTINGS} -DskipTests"
                    }
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${env.DOCKER_IMAGE} ."
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                withDockerRegistry([credentialsId: 'dockerhub-credentials', url: 'https://registry.hub.docker.com']) {
                    sh "docker push ${env.DOCKER_IMAGE}"
                }
            }
        }
        stage('Terraform Init, Plan, and Apply') {
            steps {
                script {
                    withCredentials([file(credentialsId: 'gcloud-json', variable: 'GCLOUD_KEY')]) {
                        sh '''
                            export GOOGLE_APPLICATION_CREDENTIALS=$GCLOUD_KEY
                            terraform init
                            terraform validate
                            terraform plan -out=tfplan
                            terraform apply -auto-approve tfplan
                        '''
                    }
                }
            }
        }
        stage('Run Docker Container') {
            steps {
                script {
                    sh "docker run -d -p 8082:8080 ${env.DOCKER_IMAGE}"
                }
            }
        }
        stage('Run Ansible Playbook') {
            steps {
                script {
                    sh """
                        ansible-playbook deploy_docker.yml -e "docker_image=${env.DOCKER_IMAGE}"
                    """
                }
            }
        }
        stage('Update FluxCD Git Repository') {
            steps {
                script {
                    sh """
                        echo "Updating FluxCD manifests..."
                        cd ${env.FLUX_REPO}/helm
                        git pull origin ${env.GIT_BRANCH}
                        yq e '.spec.values.image.tag = "build-001"' -i helm-release.yaml  # Updating HelmRelease image version
                        git config --global user.email "gurajasushmamounika@gmail.com"
                        git config --global user.name "sushma-sm"
                        git add helm-release.yaml
                        git commit -m "Automated update: New Docker image version for FluxCD deployment" || echo "No changes to commit"
                        git push origin ${env.GIT_BRANCH}
                    """
                }
            }
        }
        stage('FluxCD Sync') {
            steps {
                script {
                    sh '''
                        echo "Reconciling FluxCD HelmRelease..."
                        flux reconcile source git flux-system
                        flux reconcile helmrelease my-app -n demo-cluster
                    '''
                }
            }
        }
    }
    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed. Please check the logs for details.'
        }
    }
}
