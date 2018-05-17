#!/bin/bash

sudo docker build -t fluentd-custom -f fluentd.dockerfile .

sudo docker tag fluentd-custom 192.168.2.18:5000/fluentd-custom:v1

sudo docker push 192.168.2.18:5000/fluentd-custom:v1
