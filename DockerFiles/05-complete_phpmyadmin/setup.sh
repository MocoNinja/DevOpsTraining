#! /bin/bash

## Setup of parameters or default values if they are not provided
# mysql_container_name
# app_container_name
# mysql_external_port
# app_external_port

## Way of checking: if 4 parameters are passed, custom values are read; else
# default values are set
# REMEMBER: echo $0 shall output the script's name
if [ "$4" != "" ]; then
	mysql_container_name=$1
	app_container_name=$2
	mysql_external_port=$3
	app_external_port=$4
else
	mysql_container_name="mysql-cont"
	app_container_name="phpmyadmin-cont"
	mysql_external_port="3306"
	app_external_port="8000"
fi

echo "Pulling images..."
docker pull mysql:5.7.13
docker pull phpmyadmin/phpmyadmin
echo "Creating network..."
docker network create mysql-network

# Start MySQL
echo "Creating MySQL container..."
docker run --name $mysql_container_name \
           --net=mysql-network \
           -p $mysql_external_port:3306 \
           -e MYSQL_ROOT_PASSWORD=password \
           -v $(pwd)/database:/var/lib/mysql \
           -d mysql:5.7.13  > /dev/null

# Start PHPMYADMIN
echo "Creating PhpMyadmin container..."
docker run --name app_container_name \
           --net=mysql-network \
           -e MYSQL_ROOT_PASSWORD=password \
           -e PMA_HOST="$mysql_container_name" \
           -e PMA_PORT=$mysql_external_port \
           -p $app_external_port:80 \
           -d phpmyadmin/phpmyadmin 
