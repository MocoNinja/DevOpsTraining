#!/bin/bash

echo "Building dockerfile..."

sudo docker build -t custom-fluent --file fluent.dockerfile .

echo "Tagging the image..."

sudo docker tag custom-fluent 192.168.2.18:5000/custom-fluent:v1

echo  "Pushing the image..."

sudo docker push 192.168.2.18:5000/custom-fluent:v1
