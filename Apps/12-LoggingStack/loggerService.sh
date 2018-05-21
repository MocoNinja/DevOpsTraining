#! /bin/bash

sudo docker service create --network admin-net --log-driver fluentd --replicas 5 --placement-pref "spread=node.labels.datacenter" 192.168.2.18:5000/logger:v1
