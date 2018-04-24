#! /bin/bash

DBPATH='/home/centos/docker/persistence/mongodb/sampleWithCient'
DB_TABLE_NAME='test-with-client'
PORT="40011"
MONGO_CONTAINER='mongo-db-test-client'
JAVA_CONTAINER='spring-app'
NETWORK_NAME='monguer-network'

echo "============================"
echo "= Stating Spring Mongo APP ="
echo "============================"

echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-="

echo "============================"
echo "== Setting Up Application =="
echo "============================"

cd app

if [ -f ./app.war ]; then
	echo "App already exists. Skipping build..."
else
	echo "Sedding host into java..."
	if [ -f src/main/java/app/bd/MongoConfig.java ]; then
		rm src/main/java/app/bd/MongoConfig.java
	fi
	
	cp src/main/java/app/bd/MongoConfig.skeleton src/main/java/app/bd/MongoConfig.java
	sed -i "s|127.0.0.1|$MONGO_CONTAINER|g" src/main/java/app/bd/MongoConfig.java
	sed -i "s|mongospringjavitest|$DB_TABLE_NAME|g" src/main/java/app/bd/MongoConfig.java
	
	echo "Building and packaging war file..."
	mvn clean package
	
	echo "Serving war..."
	cp target/mongodb-helloworld-0.0.1-SNAPSHOT.war ./app.war

	echo "Cleaning..."
	mvn clean
fi

cd ..

echo "Writing custom Dockerfile..."
if [ -f Dockerfile ]; then
	echo "Dockerfile already present. Overriding..."
	rm Dockerfile
fi

/bin/cat <<EOM >Dockerfile
FROM openjdk:8-jdk
COPY ./app/app.war /app.war
EXPOSE 8080
ENTRYPOINT ["java", "-Dspring.data.mongodb.uri=mongodb://$MONGO_CONTAINER/$DB_TABLE_NAME","-Djava.security.egd=file:/dev/./urandom", "-jar","/app.war"]
EOM

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
networks:
	$NETWORK_NAME:
services:
	app:
		build: .
		container_name: $JAVA_CONTAINER
		ports:
			- $PORT:8080
		networks:
			- $NETWORK_NAME
	mongodb:
		image: mongo
		container_name: $MONGO_CONTAINER
		volumes:
			- $DBPATH:/data/db
		ports:
			- 27017
		networks:
			- $NETWORK_NAME
	mongoclient:
		image: mongoclient/mongoclient
		container_name: mongo-client
		ports:
			- 3000:3000
		networks:
			- $NETWORK_NAME
EOM

echo "Switch tabs for spaces..."

sed -i "s|\t| |g" *.yml
