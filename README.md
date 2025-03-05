# **Sample Maven Java Project with Git Webhook Integration and Docker**

## **Project Overview**
This project is a basic Java application built using Maven. It integrates Git webhook triggers to automatically trigger builds, and Docker is used to package the application into a container for deployment.

## **Features**
- Maven-based Java application.
- Git webhook trigger integration for automatic builds.
- Docker containerization for the application.

## **Technologies Used**
- **Java**: For building the application.
- **Maven**: For project build and dependency management.
- **Docker**: For containerizing the application.
- **GitHub Webhooks**: To trigger Jenkins builds on code push.
- **Jenkins**: For Continuous Integration/Continuous Deployment (CI/CD).

## **Getting Started**

### **Prerequisites**
1. **Java 11 or later**: Required to build and run the application.
2. **Maven**: Used for building the project.
3. **Docker**: Required to build and run Docker containers.
4. **Jenkins**: For automated builds and integration.
5. **GitHub**: For hosting the project and setting up webhooks.

### **Clone the Repository**
Clone this repository to your local machine using Git.

```bash
git clone https://github.com/sushma-sm/DEMO.git
cd DEMO
```

### **Setting up the Webhook Trigger (GitHub)**

1. **Configure a Webhook in GitHub**:
   - Go to your GitHub repository.
   - Navigate to **Settings** > **Webhooks** > **Add webhook**.
   - In the **Payload URL**, use your Jenkins server's webhook URL (e.g., `http://<jenkins-server>/github-webhook/`).
   - Choose `Content type` as `application/json`.
   - Select the events you want to trigger the build on (e.g., `Push`).
   - Save the webhook.

2. **Jenkins Webhook Configuration**:
   - In Jenkins, install the **GitHub plugin**.
   - Configure your Jenkins job to trigger builds on webhook events (by setting the job to trigger on GitHub pushes).
   - Ensure Jenkins is listening for GitHub webhook events.

### **Building the Project**

#### **1. Build with Maven**:

Run the following Maven command to build the project:

```bash
mvn clean package -DskipTests
```

This will clean the project, compile the source code, and package it into a `.jar` file.

#### **2. Build Docker Image**:

To create a Docker image for the project, use the following command:

```bash
docker build -t sushmamounika/my-repo-sm:latest .
```

This command builds the Docker image and tags it as `sushmamounika/my-repo-sm:latest`.

### **Docker Run**

Once the Docker image is built, run it using the following command:

```bash
docker run -d -p 8082:8080 sushmamounika/my-repo-sm:latest
```

This will run the Docker container in detached mode and expose port 8080 of the container to port 8082 on your host machine.

### **CI/CD Pipeline with Jenkins**

1. **Jenkins Pipeline**:
   The pipeline defined in the `Jenkinsfile` automates the following steps:
   - Clone the repository.
   - Build the Maven project.
   - Build the Docker image.
   - Push the Docker image to Docker Hub.
   - Run the Docker container.

#### **Sample Jenkinsfile**

```groovy
pipeline {
    agent any
    environment {
        REPO_URL = 'https://github.com/sushma-sm/DEMO.git'
        DOCKER_IMAGE = 'sushmamounika/my-repo-sm:latest'  // Docker image in Docker Hub
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
        stage('Docker Login') {
            steps {
                script {
                    // Login to Docker Hub using your credentials
                    sh 'docker login -u username -p 'pswd'
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    // Push the image to Docker Hub
                    sh 'docker push ${DOCKER_IMAGE}'
                }
            }
        }
        stage('Run Docker Container') {
            steps {
                sh 'docker run -d -p 8082:8080 ${DOCKER_IMAGE}'
            }
        }
    }
}
```

## **Docker Hub Repository**
The Docker image is pushed to the following Docker Hub repository:
[https://hub.docker.com/r/sushmamounika/my-repo-sm](https://hub.docker.com/r/sushmamounika/my-repo-sm)

### **Accessing the Application**

Once the Docker container is running, you can access the application by navigating to `http://<your-server-ip>:8082` in your web browser.
added k8s in demo

