#! /bin/bash

DBPATH='/home/centos/docker/persistence/mongodb/spring-sample-app-customete'
DB_TABLE_NAME='test'
NETWORKNAME='net1'
PORT=45000
JAVA_IMAGE='spring-guestbook'
JAVA_CONTAINER='spring-guestbook'
MONGO_CONTAINER='spring-mongo'

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
sudo docker run --name $MONGO_CONTAINER --network=$NETWORKNAME -v $DBPATH:/data/db -d mongo

echo "Writing custom Dockerfile..."
if [ -f Dockerfile ]; then
	echo "Dockerfile already present. Overriding..."
	rm Dockerfile
fi

/bin/cat <<EOM >Dockerfile
FROM openjdk:8-jdk
ADD app.war /app.war
EXPOSE 8080
ENTRYPOINT ["java", "-Dspring.data.mongodb.uri=mongodb://$MONGO_CONTAINER/$DB_TABLE_NAME", "-jar","/app.war"]
EOM

echo "Compiling the image of the app..."
sudo docker build -t $JAVA_IMAGE .
cd ..

echo "Stating app instance..."
sudo docker run -d --name $JAVA_CONTAINER --network=$NETWORKNAME -p $PORT:8080  $JAVA_IMAGE
