# DevOps Home Assignment - Netanel
__________________________________

## Creating a Jenkins Server with Terraform
1. **On your local machine**, make sure you've configured AWS CLI with your credentials.
2. **Download the Terraform script** and apply it to provision the infrastructure.
3. **As output**, you'll get the EC2 instance’s public IP address. Use this IP to access the Jenkins server on port 8080: `IP_Address:8080`.
4. **To get the initial password**
     * SSH into the EC2 instance using the provided `dev-assign.pem` key (user: `ubuntu`): 
       `ssh -i /path/to/dev-assign.pem ubuntu@IP_Address`
     * Extract the password:
       `sudo cat /var/lib/jenkins/secrets/initialAdminPassword`
7. Now you can run through the initial setup, create user and pipelines

## Creating the pipeline in Jenkins
1. In the Dashboard, click on "New Item"
2. Provide a name and choode the "Pipeline" option
3. Under Pipeline - from the drop-down list, choose "Pipelile script from SCM"
     * **As SCM** - choose Git
     * **Repository URL** - `https://github.com/netanelcohe/devops-assignment.git`
     * **Branch Specifier** - `*/main`
     * **Script path** - `Jenkinsfile`
     * Click "Save"
4. Now you can build the pipeline.
5. Check the build logs for failures to diagnose any issues.

## Testing the app
1. SSH into the EC2 with the provided dev-assign.pem key (user - `ubuntu`)
   `ssh -i dev-assign.pem ubuntu@IP_Address`
2. Verify that the netcalc docker is running
   `docker ps`
4. Then, run the client script
   `python3 /var/lib/jenkins/client.py`

