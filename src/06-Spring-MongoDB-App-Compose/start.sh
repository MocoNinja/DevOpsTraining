#! /bin/bash
sudo docker-composer down
sudo docker-compose build --no-cache
sudo docker-compose up
