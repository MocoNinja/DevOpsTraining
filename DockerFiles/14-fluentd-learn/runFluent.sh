#!/bin/bash

# sudo docker run -d -v $(pwd)/data:/etc/fluentd/log 
sudo docker run -it -p 24224:24224 --network="fluent-test" fluentd-custom
