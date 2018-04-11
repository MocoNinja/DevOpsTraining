#! /bin/bash

echo "Compiling the hello world Spring application Docker Image..."

sudo docker build -t spring-simple-hello .

echo "Running two containers at 40004 and 40005..."

sudo docker run -d -p 40004:8080 spring-simple-hello
sudo docker run -d -p 40005:8080 spring-simple-hello

