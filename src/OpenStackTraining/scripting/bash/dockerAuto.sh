#! /bin/bash

echo "Cloning my containers..."
git clone https://github.com/MocoNinja/docker_training_initial
echo "CDing into the first one..."
cd /home/centos/docker_training_initial/src/01-hello_world_php
echo "Building an image..."
sudo docker build -t docker_hello .
echo "Starting two containers in ports 40000 and 40001..."
sudo docker run -d -p 40000:80 docker_hello
sudo docker run -d -p 40001:80 docker_hello
sudo docker ps
echo "CDing into the second one..."
cd /home/centos/docker_training_initial/src/02-simple_php_webapp
echo "Building an image..."
sudo docker build -t docker_hello_php .
echo "Starting two containers in ports 40002 and 40003..."
sudo docker run -d -p 40002:80 docker_hello_php
sudo docker run -d -p 40003:80 docker_hello_php
sudo docker ps