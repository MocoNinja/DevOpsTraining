#!/bin/bash

NAME=javitest
FILE=exampleConf.properties 

sudo docker volume rm "$NAME"
sudo docker volume create "$NAME"

sudo cp ./$FILE /var/lib/docker/volumes/$NAME/_data/

sudo docker run -d \
  -it \
  --rm \
  -v $NAME:"/FILES" \
  ubuntu:xenial
