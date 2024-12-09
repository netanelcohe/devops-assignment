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
    cidr_blocks = ["192.116.190.26/32", "199.203.203.177/32"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["192.116.190.26/32", "199.203.203.177/32"]
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
  user_data = file("dock-jenk-install.sh")
}
# Output the Public IP Address
output "jenkins_public_ip" {
  value       = aws_instance.jenkins_instance.public_ip
  description = "Public IP address of the Jenkins server"
}
