#!/bin/bash

sudo docker build -t logger-app -f loggerApp.dockerfile .

sudo docker tag logger-app 192.168.2.18:5000/logger:v1

sudo docker push 192.168.2.18:5000/logger:v1
