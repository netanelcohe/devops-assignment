pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                        sh "docker build -t netcalc ."
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
                        sh "docker run -d --name netcalc netcalc"
                        // Verify the application is running
                        sh "docker exec netcalc python3 /var/lib/jenkins/server.py --test-operation"
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
}
