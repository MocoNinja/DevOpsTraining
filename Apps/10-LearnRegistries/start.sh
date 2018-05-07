#! /bin/bash
sudo docker service create --name registro \
	-p 5000:5000 \
	registry:2
