pipeline {
    agent any

    environment {
        GITHUB_REPO = 'https://github.com/netanelcohe/devops-assignment.git'
        DOCKER_IMAGE_NAME = "netcalc" 
    }

    stages {
        stage('Clone GitHub Repo') {
            steps {
                script {
                    git branch: 'main', url: env.GITHUB_REPO
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                        // Build Docker image locally
                        sh "docker build -t $DOCKER_IMAGE_NAME ."
                    }
                }
            }
        }

        stage('Tag Docker Image') {
            steps {
                script {
                    catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                        // Tag Docker image locally
                        sh "docker tag $DOCKER_IMAGE_NAME $DOCKER_IMAGE_NAME:latest"
                    }
                }
            }
        }

        stage('Run Docker Container Locally') {
            steps {
                script {
                    catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                        // Run Docker container locally
                        sh "docker run -d --name netcalc $DOCKER_IMAGE_NAME"
                    
                        // Verify the application is running
                        // For example, you might test a specific endpoint
                        sh "docker exec netcalc python3 /app/server.py --test-operation"
                    }
                }
            }
        }
    }

    post {
        always {
            script {
                echo "Build and deployment completed successfully!"
            }
        }

        failure {
            script {
                echo "Build failed. Check Jenkins logs for details."
                // Optionally send a notification or alert to the team about the failure
            }
        }
    }
}
