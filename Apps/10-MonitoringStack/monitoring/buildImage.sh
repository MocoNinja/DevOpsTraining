#! /bin/bash

echo "Build docker image..."
sudo docker build -t prometheus-moconinja .
echo "Tagging it..."
sudo docker tag prometheus-moconinja moconinja/prometheus-moconinja
echo "Phusing to dockerhub..."
sudo docker push moconinja/prometheus-moconinja
