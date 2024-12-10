pipeline {
    agent any
    // define environment variable to handle dockerhub credentials
    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-crd')
    }
    stages {
        // build the docker image locally on the Jenkins server
        stage('Build Docker Image') {
            steps {
                script {
                    catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                        sh "docker build -t $DOCKERHUB_CREDENTIALS_USR/netcalc:latest ."
                    }
                }
            }
        }
        
        stage('Login') {
            steps {
                script {
                    catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                        sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'                      
                }      
            }
        }
        
        stage('Push') {
            steps {
                script {
                    catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                        sh 'docker push $DOCKERHUB_CREDENTIALS_USR/netcalc:latest'                       
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
                        sh "docker run -d -p 5000:5000 --name netcalc $DOCKERHUB_CREDENTIALS_USR/netcalc:latest"
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
