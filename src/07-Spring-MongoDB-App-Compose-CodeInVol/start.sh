#! /bin/bash

DBPATH='/home/centos/docker/persistence/mongodb/spring-guestbook-compose-variation'
DB_TABLE_NAME='guestbook-app-compose'
PORT="40011"
MONGO_CONTAINER='spring-mongo-compose-variation'
JAVA_CONTAINER='spring-guestbook-compose-variation'

echo "============================"
echo "= Stating Spring Mongo APP ="
echo "============================"

echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-="

echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-="

echo "============================"
echo "==== Setting Up the APP ===="
echo "============================"

echo "Handling data folder..."

if [ ! -d $DBPATH ]; then
    echo "Data folder was not present. Creating it..."
	mkdir -p $DBPATH
else 
    echo "Data folder already present!"
fi

echo "Creating the docker-compose.yml..."

if [ -f docker-compose.yml ]; then
	echo "docker-compose.yml already present. Overriding..."
	rm docker-compose.yml
fi

/bin/cat <<EOM >docker-compose.yml
version: '3'
services:
	$JAVA_CONTAINER:
		image: maven:alpine
		ports:
			- $PORT:8080
		volumes:
			- ./app:/home/
		entrypoint: /bin/bash
		command: "/home/app.sh"
	$MONGO_CONTAINER:
		image: mongo
		volumes:
			- $DBPATH:/data/db
EOM

echo "Switch tabs for spaces..."

sed -i "s|\t| |g" *.yml

echo "Generating launch script"

/bin/cat <<EOM >app.sh
 #! /bin/bash
 echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-="
 echo "============================"
 echo "== Setting Up Application =="
 echo "============================"
 echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-="
 #echo $0
 #echo $(pwd)
 cd /home/
 mvn clean
 if [ -f src/main/java/app/bd/MongoConfig.java ]; then
 rm src/main/java/app/bd/MongoConfig.java
 fi  
 cp src/main/java/app/bd/MongoConfig.skeleton src/main/java/app/bd/MongoConfig.java
 echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-="
 sed -i "s|127.0.0.1|$MONGO_CONTAINER|g" src/main/java/app/bd/MongoConfig.java
 sed -i "s|mongospringjavitest|$DB_TABLE_NAME|g" src/main/java/app/bd/MongoConfig.java 
  echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-="
  echo "Building and packaging war file..."
  mvn clean package 
  echo "Serving war..."
  mv target/*.war app.war
  echo "Cleaning..."
  mvn clean
  echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-="
  java -Dspring.data.mongodb.uri=mongodb://$MONGO_CONTAINER/$DB_TABLE_NAME -Djava.security.egd=file:/dev/./urandom     -jar app.war
echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-="
EOM

echo "Preparing it for execution..."
chmod +x app.sh

mv app.sh ./app

echo "And launching..."
sudo docker-composer down
sudo docker-compose build --no-cache
sudo docker-compose up -d
