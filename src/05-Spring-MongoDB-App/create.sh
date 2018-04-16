#! /bin/bash

DBPATH='/home/centos/docker/persistence/mongodb/spring-sample-app'
NETWORKNAME='spring_demo_net'
PORT=45000
JAVA_APP='spring-guestbook-mongo'

echo "============================"
echo "= Stating Spring Mongo APP ="
echo "============================"

echo "Creating a network..."
sudo docker network create $NETWORKNAME

echo "Handling data folder..."

if [ ! -d $DBPATH ]; then
    echo "Data folder was not present. Creating it..."
    mkdir -p $DBPATH
else 
    echo "Data folder already present!"
fi

echo "Starting a mongo instance..."
echo "(USING OFFICIAL IMAGE)"
sudo docker run --name spring-demo-mongo --network=$NETWORKNAME -v $DBPATH:/data/db -d mongo

echo "Compiling the image of the app..."
cd java-app
sudo docker build -t $JAVA_APP .
cd ..

echo "Stating app instance..."
sudo docker run -d --name spring-demo-app --network=$NETWORKNAME -p $PORT:8080  $JAVA_APP
