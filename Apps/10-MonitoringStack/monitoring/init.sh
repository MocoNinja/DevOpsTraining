#! /bin/bash

sudo docker stack rm MONITOR
sudo docker system prune --force
sudo docker stack deploy --compose-file docker-compose.yml MONITOR
