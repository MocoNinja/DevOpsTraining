#! /bin/bash

DBPATH='/home/centos/docker/persistence/mongodb/spring-guestbook'
DB_TABLE_NAME='guestbook-app'
NETWORKNAME='guestbook-network'
PORT="40008"
JAVA_IMAGE='spring-guestbook'
JAVA_CONTAINER='spring-guestbook'
MONGO_CONTAINER='spring-mongo'

echo "============================"
echo "= Stating Spring Mongo APP ="
echo "============================"

echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-="

echo "============================"
echo "==== Setting Up Database ==="
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

echo "============================"
echo "== Setting Up Application =="
echo "============================"

echo "Sedding host into java..."
if [ -f src/main/java/app/bd/MongoConfig.java ]; then
	rm src/main/java/app/bd/MongoConfig.java
fi

cp src/main/java/app/bd/MongoConfig.skeleton src/main/java/app/bd/MongoConfig.java
sed -i "s|127.0.0.1|$MONGO_CONTAINER|g" src/main/java/app/bd/MongoConfig.java

echo "Building and packaging war file..."
mvn clean package

echo "Serving war..."
cp target/mongodb-helloworld-0.0.1-SNAPSHOT.war ./app.war

echo "Cleaning..."
mvn clean

echo "Writing custom Dockerfile..."
if [ -f Dockerfile ]; then
	echo "Dockerfile already present. Overriding..."
	rm Dockerfile
fi

/bin/cat <<EOM >Dockerfile
FROM openjdk:8-jdk
COPY app.war /app.war
EXPOSE 8080
ENTRYPOINT ["java", "-Dspring.data.mongodb.uri=mongodb://$MONGO_CONTAINER/$DB_TABLE_NAME", "-jar","/app.war"]
EOM

echo "Compiling the image of the app..."
sudo docker build -t $JAVA_IMAGE .
cd ..

echo "Stating app instance..."
sudo docker run -d --name $JAVA_CONTAINER --network=$NETWORKNAME -p $PORT:8080  $JAVA_IMAGE
