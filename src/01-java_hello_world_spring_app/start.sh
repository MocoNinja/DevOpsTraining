#! /bin/bash

if [ "$1" != "" ]; then
	PORT="$1"
	WORD="custom"
else
	PORT=8080
	WORD="default"
fi

echo "Launching with $WORD port $PORT"

java -Dserver.port=$PORT -jar target/gs-serving-web-content-0.1.0.jar
