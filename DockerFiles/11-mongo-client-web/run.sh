#! /bin/bash

sudo docker-compose down
sudo docker system prune
rm ?ocker*
sh create.sh
sudo docker-compose build --no-cache
sudo docker-compose up -d
