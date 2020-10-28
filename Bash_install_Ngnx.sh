#!/bin/bash
sudo yum -y update 
sudo amazon-linux-extras install docker
sudo yum install docker
sudo service docker start
sudo usermod -a -G docker ec2-user
sudo docker run --name mynginx1 -p 80:80 -d nginx


