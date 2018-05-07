#! /bin/bash

sudo docker tag spring-guestbook localhost:5000/spring-guestbook-app
sudo docker push localhost:5000/spring-guestbook-app
