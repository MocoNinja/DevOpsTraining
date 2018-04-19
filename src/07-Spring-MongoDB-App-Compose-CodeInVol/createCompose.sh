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
		command: "/home/start.sh"
	$MONGO_CONTAINER:
		image: mongo
		volumes:
			- $DBPATH:/data/db
EOM

echo "Switch tabs for spaces..."

sed -i "s|\t| |g" *.yml
