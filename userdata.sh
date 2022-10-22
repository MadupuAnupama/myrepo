#!/bin/sh  
#updating the os image
sudo yum update –y

#installs jenkins on AWS
sudo wget -O /etc/yum.repos.d/jenkins.repo \
  https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum upgrade
sudo amazon-linux-extras install java-openjdk11 -y
sudo yum install jenkins -y
sudo systemctl enable jenkins
sudo systemctl start jenkins

#Docker on AWS
sudo amazon-linux-extras install docker -y
sudo service docker start
sudo systemctl enable docker

#adding docker group(permissions like run as admin) to ec2user
sudo usermod -a -G docker ec2-user
sudo usermod -a -G docker jenkins

#installing git
sudo yum install git -y

#restarting the services as we add permissions
sudo service jenkins restart
sudo service docker restart
