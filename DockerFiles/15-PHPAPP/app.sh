#! /bin/bash

sudo docker run -it -d --volume $(pwd)/APP/:/var/www/html php:apache