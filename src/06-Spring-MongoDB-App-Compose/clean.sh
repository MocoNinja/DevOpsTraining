#! /bin/bash

rm app.war
rm ?ocker*
sudo docker-compose down
sudo docker system prune
