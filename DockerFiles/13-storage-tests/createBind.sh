#! /bin/bash

NAME="TEST"

if [ -d ./$NAME ]; then
  rm -r ./$NAME
fi

mkdir ./$NAME

touch ./$NAME/prueba.txt

sudo docker run -d \
  -it \
  --rm \
  --name prueba \
  -v "$(pwd)/$NAME/":"/$NAME" \
  ubuntu:xenial

