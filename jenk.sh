    #!/bin/bash
    
    sudo apt update && sudo apt upgrade -y
    
    # Add Jenkins repository key 
    sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
    
    # Add Jenkins repository to sources list
    echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
    
    sudo apt-get update
    sudo apt-get install -y fontconfig openjdk-17-jre
    sudo apt-get install -y jenkins
    
    sudo systemctl enable jenkins
    sudo systemctl restart jenkins
    
    public_ip=$(curl -s https://api.ipify.org)
    
    echo "A new Jenkins server is running on: $public_ip:8080"
    echo "Please use the following initial password to unlock Jenkins:"
    sudo cat /var/lib/jenkins/secrets/initialAdminPassword
