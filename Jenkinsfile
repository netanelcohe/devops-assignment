pipeline {
    agent any
    environment {
        DOCKER_CREDENTIALS = credentials('47767690-23d8-4f5e-b384-7c3bf19e82c7')
    }
    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                        sh "docker build -t netcalc ."
                        sh "whoami"
                    }
                }
            }
        }

        stage('Tag Docker Image') {
            steps {
                script {
                    catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                        sh "docker tag netcalc netcalc:latest"
                    }
                }
            }
        }

        stage('Push Docker Image to Docker Hub') {
            steps {
                script {
                    catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                        docker.withRegistry('https://index.docker.io/v1/', DOCKER_CREDENTIALS) {
                            docker.image('netcalc:latest').push()
                        }
                    }
                }
            }
        }
        
        stage('Copy client.py to Machine') {
            steps {
                script {
                    catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                        sh "cp client.py /var/lib/jenkins/"
                        sh "cp server.py /var/lib/jenkins/"                        
                    }
                }
            }
        }
        
        stage('Run Docker Container Locally') {
            steps {
                script {
                    catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                        sh "docker run -d -p 5000:5000 --name netcalc netcalc"
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
            }
        }
    }
}
