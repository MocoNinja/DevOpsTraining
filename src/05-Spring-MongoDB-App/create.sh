#! /bin/bash

echo "============================"
echo "= Stating Spring Mongo APP ="
echo "============================"

echo "Creating a network..."
sudo docker network create spring_demo_net

echo "Handling data folder..."

if [ ! -d /home/centos/mongo-app2/mongo/data ]; then
    echo "Data folder was not present. Creating it..."
    mkdir -p /home/centos/mongo-app/mongo2/data
else 
    echo "Data folder already present!"
fi

echo "Starting a mongo instance..."
echo "(USING OFFICIAL IMAGE)"
sudo docker run --name spring-demo-mongo --network=spring_demo_net -v /home/centos/mongo-app2/mongo/data:/data/db -d mongo

echo "Compiling the image of the app..."
cd java-app
sudo docker build -t spring-db-app .
cd ..

echo "Stating app instance..."
sudo docker run -d --name spring-demo --network=spring_demo_net -p 45000:8080  spring-db-app