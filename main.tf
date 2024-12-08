# Provider Configuration
provider "aws" {
  region = "eu-central-1" # Adjust the region as needed
}

# Security Group for Jenkins
resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins-sg"
  description = "Allow SSH and Jenkins access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["192.116.190.26/32"] # Restrict to your IP for better security
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["192.116.190.26/32"] # Restrict to your IP for better security
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instance for Jenkins
resource "aws_instance" "jenkins_instance" {
  ami           = "ami-0745b7d4092315796" # Ubuntu Server 22.04 LTS AMI (Frankfurt)
  instance_type = "t2.medium"

  key_name = "dev-assign"

  security_groups = [aws_security_group.jenkins_sg.name]

  tags = {
    Name = "Jenkins-Test-with-code"
  }

  # User Data Script to Install and Configure Jenkins
  user_data = <<-EOF
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
    EOF
}
# Output the Public IP Address
output "jenkins_public_ip" {
  value       = aws_instance.jenkins_instance.public_ip
  description = "Public IP address of the Jenkins server"
}
