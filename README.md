# DevOps Home Assignment - Netanel
__________________________________

## Creating a Jenkins server with TF
1. On your local machine, make sure you've configure AWS CLI with creds
2. Download the Terraform script and apply it for the infrastructure to be provisioned.
3. As output, you'll get the EC2 instance public IP address which you can use to access the Jenkins server on port 8080 - IP_Address:8080
4. To get the initial password, ssh into the EC2 with the provided dev-assign.pem key (user - ubuntu) and run the command:
5. sudo cat /var/lib/jenkins/secrets/initialAdminPassword
6. Now you can run through the initial setup, create user and pipelines

## Creating the pipeline in Jenkins
1. In the Dashboard, click on "New Item"
2. Provide a name and choode the "Pipeline" option
3. Under Pipeline - from the drop-down list, choose "Pipelile script from SCM"
     * As SCM - choose Git
     * Repository URL - https://github.com/netanelcohe/devops-assignment.git
     * Branch Specifier - */main
     * Script path - Jenkinsfile
     * Click "Save"
4. Now you can build the pipeline.
5. Check the build logs for failures

## Testing the app
1. ssh into the EC2 with the provided dev-assign.pem key (user - ubuntu) 
2. verify that the docker is running using "docker ps"
3. Then, run the client script with: python3 /var/lib/jenkins/client.py

