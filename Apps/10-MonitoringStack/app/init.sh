#! /bin/bash

sudo docker stack rm APP
sudo docker system prune --force
sudo docker stack deploy --compose-file docker-compose.yml APP
