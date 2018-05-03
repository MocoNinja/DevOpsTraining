#! /bin/bash
./create.sh
sudo docker-compose down
sudo docker system prune
sudo docker-compose build --no-cache
sudo docker-compose up
