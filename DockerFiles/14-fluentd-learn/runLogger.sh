#!/bin/bash

sudo docker run -d --log-driver=fluentd --log-opt fluentd-address=172.18.0.2:24224 --network="fluent-test" logger-app
