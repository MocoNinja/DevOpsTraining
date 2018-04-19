#! /bin/bash
DB_TABLE_NAME='guestbook-app-compose'
MONGO_CONTAINER='spring-mongo-compose-variation'
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
java -Dspring.data.mongodb.uri=mongodb://$MONGO_CONTAINER/$DB_TABLE_NAME -Djava.security.egd=file:/dev/./urandom -jar app.war
echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-="
