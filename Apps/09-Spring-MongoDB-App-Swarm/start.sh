#! /bin/bash

./clean.sh
./create.sh
sudo docker stack rm GUESTBOOK
sudo docker stack deploy --compose-file docker-compose.yml GUESTBOOK
